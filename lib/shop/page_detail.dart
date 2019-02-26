import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskist/model/workorder.dart';
import 'package:taskist/model/serviceItem.dart';
import 'package:taskist/shop/widgets/serviceItemCard.dart';
import 'package:taskist/common/common_scaffold.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:taskist/shop/page_addServiceItem.dart';
import 'package:taskist/shop/shopService.dart';

// import 'package:taskist/rugs/forms/imagesListScreen.dart';
Dio dio;
// import 'package:taskist/model/serviceItemList.dart';

class DetailPage extends StatefulWidget {
  final FirebaseUser user;
  // final int i;
  // final Map<String, List<JobModel>> jobPanel;
  final Workorder currentWorkorder;

  // final String color;

  // DetailPage({Key key, this.user, this.i, this.job, this.color})
  //     : super(key: key);
  DetailPage({Key key, this.user, this.currentWorkorder}) : super(key: key);
  factory DetailPage.forDesignTime() {
    // TODO: add arguments
    return new DetailPage();
  }

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController itemController = new TextEditingController();
  List<ServiceItem> serviceItems;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  ShopService shopService = new ShopService();
  Workorder _currentWorkorder;

  @override
  void initState() {
    super.initState();
    _currentWorkorder = widget.currentWorkorder;
    // serviceItems = widget.currentWorkorder.serviceItems;
    // serviceItems = shopService.getServiceItems(widget.currentWorkorder.id);
    switch (widget.currentWorkorder.status) {
      case 'Active':
        currentColor = Colors.green[800];
        break;
      default:
        currentColor = Color.fromRGBO(66, 165, 245, 1.0);
        break;
    }
  }

  void addServiceItemToFirebase() async {
    // bool isExist = false;
    // int length = widget.job.serviceItems.length + 1;
    // List<dynamic> list = new List<dynamic>();
    // widget.job.serviceItems
    //   ..forEach((v) {
    //     list.add(v);
    //   });
    // try {
    //   await Firestore.instance
    //       .collection('service-items')
    //       .document(widget.job.fbId + '_' + length.toString())
    //       .setData(
    //           {"name": itemController.text.toString().trim(), "isDone": true});
    //   List l = new List();
    //   l.add({"name": itemController.text.toString().trim(), "isDone": false});
    //   widget.job.serviceItems.add(
    //       {"name": itemController.text.toString().trim(), "isComplete": false});

    //   await Firestore.instance
    //       .collection("workorders")
    //       .document(widget.job.fbId)
    //       .updateData({'serviceItems': FieldValue.arrayUnion(l)});
    // } catch (e) {
    //   print(e);
    // }
    // itemController.clear();
    // Navigator.of(context).pop();
  }

  void _callRestAPI(workorder) async {
    // BaseOptions options = new BaseOptions(
    //   baseUrl: "https://ashdevtools.com/",
    //   connectTimeout: 5000,
    //   receiveTimeout: 3000,
    //   // headers: {
    //   //   'Authorization': 'Basic Sk5wbkZOelhxOnltMWM4cGU4QzNPNHM3bDBBVms=',
    //   // }
    // );
    dio = new Dio();
    var serviceItem =
        ServiceItemSerializer().toMap(_currentWorkorder.serviceItems[0]);
    var ord = WorkorderSerializer().toMap(_currentWorkorder);
    var data = {};
    data['workOrder'] = ord;
    data['serviceItem'] = serviceItem;
    String jserviceItem = json.encode(serviceItem);
    String sdata = json.encode(data);

    try {
      // var response = await dio.post("/api/v1/ruglist", data: jserviceItem);
      var response = await dio.post("/ruglist", data: sdata);
    } catch (e) {
      print(e);
    }

    // var url = "http://ashdevtools.com/ruglist";
    // http.post(url, body: {"name": "doodle", "color": "blue"}).then((response) {
    //   print("Response status: ${response.statusCode}");
    //   print("Response body: ${response.body}");
    // });

    // http.read("https://ashdevtools.com/ruglist").then(print);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      // backGroundColor: Colors.grey.shade100,
      backGroundColor: Colors.white,
      actionFirstIcon: null,
      appTitle: "Product Detail",
      showFAB: true,
      scaffoldKey: _scaffoldState,
      callback: () => navigateAddServiceItem(),
      showDrawer: false,
      centerDocked: true,
      floatingIcon: Icons.add,
      showBottomNav: true,
      bodyData: Stack(
        children: <Widget>[
          _getToolbar(context),
          getServiceItems(),
        ],
      ),
    );
  }

  void navigateAddServiceItem() {
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new AddServiceItems(
              user: widget.user,
              currentJob: _currentWorkorder,
            )));
  }

  getServiceItems() {
    // List<ServiceItem> listElement = new List();
    int nbIsDone = 0;

    _currentWorkorder.serviceItems.forEach((i) {
      if (i.isDone) {
        nbIsDone++;
      }
    });

    // return Column(children: <Widget>[
    //   // Padding(
    //   //     padding: EdgeInsets.only(top: 120.0),
    //   //     child:
    //   //     Column(
    //   //       children: <Widget>[

    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       new Text(
    //         // widget.jobPanel.keys.elementAt(widget.i),
    //         _currentWorkorder.customer.lastName,
    //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
    //       ),
    //       GestureDetector(
    //         onTap: () {
    //           showDialog(
    //             context: context,
    //             builder: (BuildContext context) {
    //               return new AlertDialog(
    //                 title: Text("Delete: " + _currentWorkorder.id.toString()),
    //                 content: Text(
    //                   "Are you sure you want to delete this list?",
    //                   style: TextStyle(fontWeight: FontWeight.w400),
    //                 ),
    //                 actions: <Widget>[
    //                   ButtonTheme(
    //                     //minWidth: double.infinity,
    //                     child: RaisedButton(
    //                       elevation: 3.0,
    //                       onPressed: () {
    //                         Navigator.pop(context);
    //                       },
    //                       child: Text('No'),
    //                       color: currentColor,
    //                       textColor: const Color(0xffffffff),
    //                     ),
    //                   ),
    //                   ButtonTheme(
    //                     //minWidth: double.infinity,
    //                     child: RaisedButton(
    //                       elevation: 3.0,
    //                       onPressed: () {
    //                         _callRestAPI(_currentWorkorder);
    //                       },
    //                       child: Text('YES'),
    //                       color: currentColor,
    //                       textColor: const Color(0xffffffff),
    //                     ),
    //                   ),
    //                 ],
    //               );
    //             },
    //           );
    //         },
    //         child: Icon(
    //           FontAwesomeIcons.trash,
    //           size: 25.0,
    //           color: currentColor,
    //         ),
    //       ),
    //     ],
    //   ),
    //   // ),
    //   Padding(
    //     padding: EdgeInsets.only(top: 5.0, left: 50.0),
    //     child: Row(
    //       children: <Widget>[
    //         new Text(
    //           nbIsDone.toString() +
    //               " of " +
    //               _currentWorkorder.serviceItems.length.toString() +
    //               " order items",
    //           style: TextStyle(fontSize: 18.0, color: Colors.black54),
    //         ),
    //       ],
    //     ),
    //   ),
    //   Padding(
    //     padding: EdgeInsets.only(top: 5.0),
    //     child: Row(
    //       children: <Widget>[
    //         Expanded(
    //           flex: 2,
    //           child: Container(
    //             margin: EdgeInsets.only(left: 50.0),
    //             color: Colors.grey,
    //             height: 1.5,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   // Center(
    //   //     child:
    //   // Column(
    //   //     mainAxisAlignment: MainAxisAlignment.start,
    //   //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //   //     children: <Widget>[
    //   Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         Expanded(
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 120.0),
          child: new Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 30.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    _currentWorkorder.customer.lastName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            //  _currentWorkorder.customer.lastName,
                            title: Text(
                                "Delete: " + _currentWorkorder.id.toString()),
                            content: Text(
                              "Are you sure you want to delete this list?",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            actions: <Widget>[
                              ButtonTheme(
                                //minWidth: double.infinity,
                                child: RaisedButton(
                                  elevation: 3.0,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No'),
                                  color: currentColor,
                                  textColor: const Color(0xffffffff),
                                ),
                              ),
                              ButtonTheme(
                                //minWidth: double.infinity,
                                child: RaisedButton(
                                  elevation: 3.0,
                                  onPressed: () {
                                    // Firestore.instance
                                    //     .collection(widget.user.uid)
                                    //     .document(widget.currentList.keys
                                    //     .elementAt(widget.i))
                                    //     .delete();
                                    // Navigator.pop(context);
                                    // Navigator.of(context).pop();
                                  },
                                  child: Text('YES'),
                                  color: currentColor,
                                  textColor: const Color(0xffffffff),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      FontAwesomeIcons.trash,
                      size: 25.0,
                      color: currentColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 30.0),
              child: Row(
                children: <Widget>[
                  new Text(
                    nbIsDone.toString() +
                        " of " +
                        _currentWorkorder.serviceItems.length.toString() +
                        " order items",
                    style: TextStyle(fontSize: 18.0, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0, right: 20),
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 30.0, right: 20),
                child: Column(children: <Widget>[
                  Container(
                      color: Color(0xFFFCFCFC),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height - 350,
                          child: StreamBuilder<List<ServiceItem>>(
                              stream: shopService.getServiceItems(
                                  workorderId: _currentWorkorder.id),
                              builder: (context, snapShot) {
                                if (!snapShot.hasData)
                                  return const Text('Loading...');
                                return ListView.builder(
                                    shrinkWrap: false,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: snapShot.data.length,
                                    itemBuilder: (BuildContext ctxt, int i) {
                                      return new Slidable(
                                        delegate: new SlidableBehindDelegate(),
                                        actionExtentRatio: 0.25,
                                        child: GestureDetector(
                                          child: Container(
                                            // height: 80.0,
                                            color: snapShot.data
                                                    .elementAt(i)
                                                    .isDone
                                                ? Color(0xFFF0F0F0)
                                                : Color(0xFFFCFCFC),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(
                                                    snapShot.data
                                                            .elementAt(i)
                                                            .isDone
                                                        ? FontAwesomeIcons
                                                            .checkSquare
                                                        : FontAwesomeIcons
                                                            .square,
                                                    color: snapShot.data
                                                            .elementAt(i)
                                                            .isDone
                                                        ? currentColor
                                                        : Colors.black,
                                                    size: 20.0,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    decoration: new BoxDecoration(
                                                        border: new Border.all(
                                                            color: Colors
                                                                .blueAccent)),
                                                    child: new Icon(
                                                      (snapShot.data
                                                              .elementAt(i)
                                                              .hasUrine)
                                                          ? FontAwesomeIcons
                                                              .restroom
                                                          : FontAwesomeIcons
                                                              .check,
                                                      color: (snapShot.data
                                                              .elementAt(i)
                                                              .hasUrine)
                                                          ? Colors
                                                              .yellow.shade700
                                                          : Colors.white,
                                                      size: 12.0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                  ),
                                                  Text(
                                                    snapShot.data
                                                            .elementAt(i)
                                                            .length
                                                            .toString() +
                                                        ' x ' +
                                                        snapShot.data
                                                            .elementAt(i)
                                                            .width
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      snapShot.data
                                                          .elementAt(i)
                                                          .serviceName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: snapShot.data
                                                              .elementAt(i)
                                                              .isDone
                                                          ? TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color:
                                                                  currentColor,
                                                              fontSize: 22.0,
                                                            )
                                                          : TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22.0,
                                                            ),
                                                    ),
                                                  ),
                                                  (snapShot.data
                                                              .elementAt(i)
                                                              .pictures[0]
                                                              .url !=
                                                          null)
                                                      ? SizedBox(
                                                          height: 184.0,
                                                          width: 184.0,
                                                          child: Stack(
                                                            children: <Widget>[
                                                              Positioned.fill(
                                                                child: Image.network(
                                                                    snapShot
                                                                        .data
                                                                        .elementAt(
                                                                            i)
                                                                        .pictures[
                                                                            0]
                                                                        .url),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 184.0,
                                                          width: 184.0,
                                                          child: Stack(
                                                            children: <Widget>[
                                                              Positioned.fill(
                                                                child: Image
                                                                    .network(
                                                                        'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg'),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // secondaryActions: <Widget>[
                                        //   new IconSlideAction(
                                        //     caption: 'Delete',
                                        //     color: Colors.red,
                                        //     icon: Icons.delete,
                                        //     onTap: () {
                                        //       Firestore.instance
                                        //           .collection("workorders")
                                        //           .document(currentWorkorder.id)
                                        //           .updateData({
                                        //         listElement
                                        //             .elementAt(i)
                                        //             .customer
                                        //             .accountName: ""
                                        //       });
                                        //     },
                                        //   ),
                                        // ],
                                      );
                                    });
                              })
                          // ],
                          ))
                ]))
          ])
          // ],
          // )
          // ]);
          )
    ]);
  }

  Color pickerColor;
  Color currentColor;

  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 12.0),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        new Image(
            width: 35.0,
            height: 35.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/list.png')),
        // RaisedButton(
        //   elevation: 3.0,
        //   onPressed: () {
        //     pickerColor = currentColor;
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: const Text('Pick a color!'),
        //           content: SingleChildScrollView(
        //             child: ColorPicker(
        //               pickerColor: pickerColor,
        //               onColorChanged: changeColor,
        //               enableLabel: true,
        //               colorPickerWidth: 1000.0,
        //               pickerAreaHeightPercent: 0.7,
        //             ),
        //           ),
        //           actions: <Widget>[
        //             FlatButton(
        //               child: Text('Got it'),
        //               onPressed: () {
        //                 Firestore.instance
        //                     .collection("workorders")
        //                     .document(_currentWorkorder.id)
        //                     .updateData(
        //                         {"color": pickerColor.value.toString()});

        //                 setState(() => currentColor = pickerColor);
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //           ],
        //         );
        //       },
        //     );
        //   },
        //   child: Text(_currentWorkorder.id),
        //   color: currentColor,
        //   textColor: const Color(0xffffffff),
        // ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: new Icon(
            Icons.close,
            size: 40.0,
            color: currentColor,
          ),
        ),
      ]),
    );
  }
}
