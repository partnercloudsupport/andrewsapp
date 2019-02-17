import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import '../../model/serviceItem.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import './serviceItemForm.dart';
import '../page_orders.dart';

class CameraScreen extends StatefulWidget {
  final ServiceItem currentItem;
  CameraScreen({this.currentItem});

  @override
  _CameraScreenState createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  String imagePath;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  setCameras() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }

    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    setCameras();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 12.0),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        new Image(
            width: 35.0,
            height: 35.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/icon.png')),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: (widget.currentItem != null)
              ? new Icon(
                  Icons.close,
                  size: 40.0,
                  color: (widget.currentItem.isDone != null &&
                          widget.currentItem.isDone == true)
                      ? Colors.grey
                      : Colors.green,
                )
              : new Icon(
                  Icons.close,
                  size: 40.0,
                  color: Colors.green,
                ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          _getToolbar(context),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
            ),
          ),
          _captureControlRowWidget(),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// Display the control bar with buttons to take pictures.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null && controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        )
      ],
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          detectLabels().then((_) {});
        }
      }
    });
  }

  Future<void> detectLabels() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFilePath(imagePath);
    // final LabelDetector labelDetector = FirebaseVision.instance.labelDetector();
    // final List<Label> labels = await labelDetector.detectInImage(visionImage);
    final List<String> labels = new List();
    labels.add(DateTime.now().toString());
    labels.add(widget.currentItem.id);
    labels.add('Photo: ' + (widget.currentItem.pictures.length + 1).toString());

    List<String> labelTexts = new List();
    for (String label in labels) {
      final String text = label;

      labelTexts.add(text);
    }
    final String label = 'label';
    final String uuid = Uuid().v1();
    final String downloadURL = await _uploadFile(uuid);

    // await _addItem(downloadURL, labelTexts);
    await _addItem(downloadURL, labelTexts, widget.currentItem.id);
  }

  Future<void> _addItem(
      String downloadURL, List<String> labels, String serviceItemId) async {
    var id = await Firestore.instance
        .collection('shop_photos/' + widget.currentItem.id + '/photos')
        .add(<String, dynamic>{
      'downloadURL': downloadURL,
      'labels': labels,
      'serviceItemId': serviceItemId
    });
    print(id.documentID);
    widget.currentItem.pictures.add(id.documentID);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ItemsListScreen(
                currentItem: widget.currentItem,
              )),
    );
  }

  Future<String> _uploadFile(filename) async {
    final File file = File(imagePath);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('$filename.jpg');
    final StorageUploadTask uploadTask = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
      ),
    );

    final downloadURL =
        await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadURL.toString();
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_vision';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

List<CameraDescription> cameras;

class ItemsListScreen extends StatefulWidget {
  final ServiceItem currentItem;
  ItemsListScreen({this.firestore, @required this.currentItem});

  final Firestore firestore;

  @override
  State<StatefulWidget> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  ServiceItem currentItem;
  Firestore firestore;

  @override
  void initState() {
    String id = DateTime.now().toString();
    super.initState();
    currentItem = widget.currentItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          _getToolbar(context),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Add',
                          style: new TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Photos',
                          style:
                              new TextStyle(fontSize: 28.0, color: Colors.grey),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 0,
                  ),
                ),
                Text(
                  '[tag: ' + currentItem.tagId + ']',
                  style: new TextStyle(
                      fontSize: 12.0, color: Colors.blue.shade900),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 75.0),
            child: ItemsList(
                firestore: Firestore.instance, currentItem: currentItem),
          ),
        ]),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            (currentItem.pictures.length > 0)
                ? Center(
                    child: FloatingActionButton.extended(
                      heroTag: "demotag",
                      label: new Text('Continue to details'),
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(new PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new ServiceItemForm(
                                // currentItem: this.currentItem,
                                currentItem: this.currentItem)));
                      },
                    ),
                  )
                : Container(width: 1),
            Container(
              height: 30,
            ),
            FloatingActionButton(
              heroTag: "demotag2",
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CameraScreen(currentItem: currentItem)),
                );
              },
            ),
          ],
        )

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => CameraScreen(currentItem: currentItem)),
        //     );
        //   },
        //   child: const Icon(Icons.add),
        // ),
        );
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 12.0),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        new Image(
            width: 35.0,
            height: 35.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/icon.png')),
        GestureDetector(
            onTap: () {
              (currentItem.pictures.length != 0)
                  ? Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new RugPage(
                          // currentItem: this.currentItem,
                          )))
                  : Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new RugPage(
                          // currentItem: this.currentItem,
                          )));
            },
            child: (currentItem != null)
                ? (currentItem.pictures.length > 0)
                    ? new Icon(
                        Icons.close,
                        size: 40.0,
                        color: (currentItem.isDone != null &&
                                currentItem.isDone == true)
                            ? Colors.grey
                            : Colors.green,
                      )
                    : new Icon(
                        Icons.close,
                        size: 40.0,
                        color: Colors.green,
                      )
                : new Icon(
                    Icons.close,
                    size: 40.0,
                    color: (currentItem.isDone != null &&
                            currentItem.isDone == true)
                        ? Colors.grey
                        : Colors.green,
                  ))
      ]),
    );
  }
}

class ItemsList extends StatelessWidget {
  final ServiceItem currentItem;
  ItemsList({this.firestore, @required this.currentItem});

  final Firestore firestore;

  @override
  Widget build(BuildContext context) {
    return Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('shop_photos/' + currentItem.id + '/photos')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                final int itemsCount = snapshot.data.documents.length;
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 40.0, right: 40.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: itemsCount,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot document =
                          snapshot.data.documents[index];
                      return Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            height: 184.0,
                            width: 184.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.network(document['downloadURL']),
                                ),
                              ],
                            ),
                          )
                          // return ListTile(
                          //   title: Text('${item.fbId}   (lat:${item.fbId})'),
                          //   subtitle: Text('distance: ${item.id}'),
                          // );
                          );
                    });
                // return ListView.builder(
                //   itemCount: itemsCount,
                //   itemBuilder: (_, int index) {
                //     final DocumentSnapshot document =
                //         snapshot.data.documents[index];
                //     return SafeArea(
                //       top: false,
                //       bottom: false,
                //       child: Container(
                //         padding: const EdgeInsets.all(8.0),
                //         height: 220.0,
                //         child: Card(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(16.0),
                //               topRight: Radius.circular(16.0),
                //               bottomLeft: Radius.circular(16.0),
                //               bottomRight: Radius.circular(16.0),
                //             ),
                //           ),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               // photo and title
                //               SizedBox(
                //                 height: 184.0,
                //                 child: Stack(
                //                   children: <Widget>[
                //                     Positioned.fill(
                //                       child: Image.network(
                //                           document['downloadURL']),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               // Expanded(
                //               //   child: Padding(
                //               //     padding: const EdgeInsets.fromLTRB(
                //               //         16.0, 16.0, 16.0, 0.0),
                //               //     child: DefaultTextStyle(
                //               //       softWrap: true,
                //               //       //overflow: TextOverflow.,
                //               //       style: Theme.of(context).textTheme.subhead,
                //               //       child: Column(
                //               //           crossAxisAlignment:
                //               //               CrossAxisAlignment.start,
                //               //           children: <Widget>[
                //               //             Text(document['labels'].join(', ')),
                //               //           ]),
                //               //     ),
                //               //   ),
                //               // ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
            ),
          ),
        ]);
  }
}

// class FlutterVisionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ItemsListScreen(),
//     );
//   }
// }

// Future<void> main() async {
//   // Fetch the available cameras before initializing the app.
//   try {
//     cameras = await availableCameras();
//   } on CameraException catch (e) {
//     logError(e.code, e.description);
//   }
//   runApp(FlutterVisionApp());
// }

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');
