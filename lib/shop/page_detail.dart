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

import 'package:taskist/shop/addServiceItem.dart';
import 'package:taskist/shop/shopService.dart';
// import 'package:taskist/rugs/forms/imagesListScreen.dart';

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
  List<dynamic> serviceItems;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  ShopService shopService = new ShopService();
  @override
  void initState() {
    super.initState();
    serviceItems = widget.currentWorkorder.serviceItems;
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
          Container(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: getServiceItems(widget.currentWorkorder),
              // child: new StreamBuilder<QuerySnapshot>(
              //     stream: Firestore.instance
              //         .collection("workorders")
              //         .where("fbId", isEqualTo: widget.job.fbId.toString())
              //         .snapshots(),
              //     builder: (BuildContext context,
              //         AsyncSnapshot<QuerySnapshot> snapshot) {
              //       if (!snapshot.hasData)
              //         return new Center(
              //             child: CircularProgressIndicator(
              //           backgroundColor: currentColor,
              //         ));
              //       return new Container(
              //         child: getServiceItems(snapshot),
              //       );
              //     }),
              // getEvents(constraints: [new QueryConstraint(field: "creatorId", isEqualTo: _currentUser.id)]);

              // child: StreamBuilder<List<Workorder>>(
              //   stream: shopService.getWorkorders(constraints: [
              //     new QueryConstraint(
              //         field: "fbId", isEqualTo: widget.job.fbId.toString())
              //   ]),
              //   builder: (context, snapShot) {
              //     if (!snapShot.hasData)
              //       return new Center(
              //           child: CircularProgressIndicator(
              //         backgroundColor: Colors.blue,
              //       ));
              //     return ListView.builder(
              //         itemCount: snapShot.data.length,
              //         itemBuilder: (context, index) {
              //           var item = snapShot.data[index];
              //           return ServiceItemCard(item);
              //           // return ListTile(
              //           //   title: Text(
              //           //       '${item.name}   (lat:${item.email})'),
              //           //   subtitle: Text('distance: ${item.id}'),
              //           // );
              //         });
              //     // return new Container(
              //     //       child: getServiceItems(snapShot),
              //     //     );
              //     // return ListView.builder(
              //     //     itemCount: snapShot.data.length,
              //     //     itemBuilder: (context, index) {
              //     //       var item = snapShot.data[index];
              //     //       return EmployeeCard(item, _device);
              //     //       // return ListTile(
              //     //       //   title: Text(
              //     //       //       '${item.name}   (lat:${item.email})'),
              //     //       //   subtitle: Text('distance: ${item.id}'),
              //     //       // );
              //     //     });
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  navigateAddServiceItem() {
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new AddServiceItems(
              //             // pageBuilder: (_, __, ___) => new ItemsListScreen(
              //             // user: widget.user,
              currentJob: widget.currentWorkorder,
            )));
  }

  // getServiceItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  getServiceItems(Workorder currentWorkorder) {
    List<ServiceItem> listElement = new List();
    int nbIsDone = 0;
    // Workorder job;
    // // if (widget.user.uid.isNotEmpty) {
    // if (true) {
    //   snapshot.data.documents.forEach((f) {
    //     // job = Workorder.fromSnapshot(f);
    //     Workorder workorder = WorkorderSerializer.fromMap(f);
    //   });
    currentWorkorder.serviceItems.forEach((i) {
      if (i.isDone) {
        nbIsDone++;
      }
    });

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 150.0),
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      // widget.jobPanel.keys.elementAt(widget.i),
                      currentWorkorder.customer.lastName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 35.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: Text(
                                  "Delete: " + currentWorkorder.id.toString()),
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
                                      //     .collection('workorders')
                                      //     .document(widget.job.id)

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
                padding: EdgeInsets.only(top: 5.0, left: 50.0),
                child: Row(
                  children: <Widget>[
                    new Text(
                      nbIsDone.toString() +
                          " of " +
                          currentWorkorder.serviceItems.length.toString() +
                          " tasks",
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
                        margin: EdgeInsets.only(left: 50.0),
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Color(0xFFFCFCFC),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 350,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: currentWorkorder.serviceItems.length,
                            itemBuilder: (BuildContext ctxt, int i) {
                              return new Slidable(
                                delegate: new SlidableBehindDelegate(),
                                actionExtentRatio: 0.25,
                                child: GestureDetector(
                                  // onTap: () {
                                  //   Firestore.instance
                                  //       .collection(widget.user.uid)
                                  //       .document(widget.jobPanel.elementAt(widget.i).job.id)
                                  //       .updateData({
                                  //     listElement.elementAt(i).customer.accountName:
                                  //         !listElement.elementAt(i).isDone
                                  //   });
                                  // },
                                  child: Container(
                                    height: 50.0,
                                    color: currentWorkorder.serviceItems
                                            .elementAt(i)
                                            .isDone
                                        ? Color(0xFFF0F0F0)
                                        : Color(0xFFFCFCFC),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            currentWorkorder.serviceItems
                                                    .elementAt(i)
                                                    .isDone
                                                ? FontAwesomeIcons.checkSquare
                                                : FontAwesomeIcons.square,
                                            color: currentWorkorder.serviceItems
                                                    .elementAt(i)
                                                    .isDone
                                                ? currentColor
                                                : Colors.black,
                                            size: 20.0,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 30.0),
                                          ),
                                          Flexible(
                                            child: Text(
                                              currentWorkorder.serviceItems
                                                  .elementAt(i)
                                                  .serviceName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: currentWorkorder
                                                      .serviceItems
                                                      .elementAt(i)
                                                      .isDone
                                                  ? TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: currentColor,
                                                      fontSize: 27.0,
                                                    )
                                                  : TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 27.0,
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                secondaryActions: <Widget>[
                                  // new IconSlideAction(
                                  //   caption: 'Delete',
                                  //   color: Colors.red,
                                  //   icon: Icons.delete,
                                  //   onTap: () {
                                  //     Firestore.instance
                                  //         .collection("workorders")
                                  //         .document(currentWorkorder.id)
                                  //         .updateData({
                                  //       listElement
                                  //           .elementAt(i)
                                  //           .customer
                                  //           .accountName: ""
                                  //     });
                                  //   },
                                  // ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color pickerColor;
  Color currentColor;

  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 12.0),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        new Image(
            width: 35.0,
            height: 35.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/list.png')),
        RaisedButton(
          elevation: 3.0,
          onPressed: () {
            pickerColor = currentColor;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: pickerColor,
                      onColorChanged: changeColor,
                      enableLabel: true,
                      colorPickerWidth: 1000.0,
                      pickerAreaHeightPercent: 0.7,
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Got it'),
                      onPressed: () {
                        Firestore.instance
                            .collection("workorders")
                            .document(widget.currentWorkorder.id)
                            .updateData(
                                {"color": pickerColor.value.toString()});

                        setState(() => currentColor = pickerColor);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text(widget.currentWorkorder.id),
          color: currentColor,
          textColor: const Color(0xffffffff),
        ),
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
