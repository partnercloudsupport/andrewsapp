import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/serviceItem.dart';
import 'package:taskist/model/workorder.dart';
import './widgets/serviceItemForm.dart';
import './widgets/imagesListScreen.dart';
import './page_orders.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:barcode_scan/barcode_scan.dart';

class AddServiceItems extends StatefulWidget {
  final FirebaseUser user;
  final Workorder currentJob;

  AddServiceItems({Key key, this.user, this.currentJob}) : super(key: key);

  @override
  _AddServiceItemsState createState() => _AddServiceItemsState();
}

class _AddServiceItemsState extends State<AddServiceItems> {
  // final _serviceItemList = List<ServiceItem>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ServiceItem currentItem;
  var uuid = new Uuid();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.

  Future<File> _imageFile;
  Future<ServiceItemForm> _form;
  final TextEditingController eCtrl = new TextEditingController();
  int _act = 1;
  int currStep = 1;
  DateTime today = new DateTime.now();
  var twentyOnedaysFromNow;
  static var _focusNode = new FocusNode();
  // ServiceItem _currentItem =
  //     ServiceItem(length: 0, width: 0, pictures: new List());

  @override
  void initState() {
    String id = DateTime.now().toString();
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
    twentyOnedaysFromNow = today.add(new Duration(days: 21));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //     key: _scaffoldKey,
        body: ListView(children: <Widget>[
      //       _getToolbar(context),
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
                      'ServiceItem',
                      style: new TextStyle(fontSize: 28.0, color: Colors.grey),
                    )
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
      // ItemsListScreen(),
      Padding(
        padding: EdgeInsets.only(top: 50.0, left: 0.0, right: 0.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[]),
      ),
      _buildCameraButton(context)
    ]));
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 12.0),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        new Image(
            width: 35.0,
            height: 35.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/icon.png')),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new RugPage()));
          },
          child: (currentItem != null)
              ? new Icon(
                  Icons.close,
                  size: 40.0,
                  color:
                      (currentItem.isDone != null && currentItem.isDone == true)
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

  Padding _buildCameraButton(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: 50.0,
            height: 50.0,
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            child: new IconButton(
              icon: new Icon(Icons.camera),
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera);
              },
              iconSize: 30.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text('Scan Tag', style: TextStyle(color: Colors.black45)),
          ),
        ],
      ),
    );
  }

  var barcode;

  void _onImageButtonPressed(ImageSource source) async {
    // try {
    // String _barcode = await BarcodeScanner.scan();
    var rng = new Random();
    String _barcode = '{"id":"BCID-1233","tagColor":"yellow"}';
    // setState(() => this.barcode = barcode);
    barcode = json.decode(_barcode);
    barcode['id'] = 'BCID-' + rng.nextInt(100).toString();
    bool urine;
    (barcode['tagColor'] == 'yellow') ? urine = true : urine = false;
    int now = DateTime.now().microsecondsSinceEpoch;

    setState(() {
      this.currentItem = new ServiceItem(
          // id: uuid.v5(Uuid.NAMESPACE_OID, barcode['id']),
          id: widget.currentJob.id + barcode['id'],
          serviceName: "Pitwash one rug",
          createdAt: now,
          hasUrine: urine,
          workorderId: widget.currentJob.id,
          smWorkorderId: widget.currentJob.smOrderId,
          tagColor: barcode['tagColor'],
          tagId: barcode['id'],
          pictures: new List(),
          isDone: false,
          smGUID: 'asdf');
    });

    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new ItemsListScreen(
              //             // pageBuilder: (_, __, ___) => new ItemsListScreen(
              //             // user: widget.user,
              currentItem: this.currentItem,
            )));
    // } on PlatformException catch (e) {
    //   if (e.code == BarcodeScanner.CameraAccessDenied) {
    //     setState(() {
    //       this.barcode = 'The user did not grant the camera permission!';
    //     });
    //   } else {
    //     setState(() => this.barcode = 'Unknown error: $e');
    //   }
    // } on FormatException {
    //   setState(() => this.barcode =
    //       'null (User returned using the "back"-button before scanning anything. Result)');
    // } catch (e) {
    //   setState(() => this.barcode = 'Unknown error: $e');
    // }
  }
  // Navigator.of(context).push(new PageRouteBuilder(
  //     pageBuilder: (_, __, ___) => new ItemsListScreen(
  //           //             // pageBuilder: (_, __, ___) => new ItemsListScreen(
  //           //             // user: widget.user,
  //           currentItem: currentItem,
  //         )));

  // setState(() {
  //   _imageFile = ImagePicker.pickImage(source: ImageSource.camera);
  // });

  // Widget customerPanel() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
  //     child: Card(
  //       elevation: 2.0,
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             Text(
  //               widget.currentJob.customer.firstName +
  //                   ' ' +
  //                   widget.currentJob.customer.lastName,
  //               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
  //             ),
  //             SizedBox(
  //               height: 10.0,
  //             ),
  //             Text(widget.currentJob.customer.phones.first.toString()),
  //             SizedBox(
  //               height: 10.0,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 // Text(  widget.newJob.customer.address.streetAddress + widget.newJob.customer.address.city + widget.newJob.customer.address.state + widget.newJob.customer.address.zipcode),
  //                 (widget.currentJob.customer.address.pretty != null)
  //                     ? Text(widget.currentJob.customer.address.pretty)
  //                     : Text(
  //                         "Due 02/25/2019",
  //                         style: TextStyle(
  //                             color: Colors.orange.shade800,
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 15.0),
  //                       )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}

// class Contact {
//   final String name;
//   final String email;
//   final String imageUrl;

//   const Contact(this.name, this.email, this.imageUrl);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Contact &&
//           runtimeType == other.runtimeType &&
//           name == other.name;

//   @override
//   int get hashCode => name.hashCode;

//   @override
//   String toString() {
//     return name;
//   }
// }
