// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:taskist/utils/diamond_fab.dart';
// import 'package:taskist/shop/addServiceItem.dart';

// // import 'package:taskist/model/serviceItemList.dart';

// class DetailPage extends StatefulWidget {
//   final FirebaseUser user;
//   // final int i;
//   // final Map<String, List<JobModel>> jobPanel;
//   final JobModel job;

//   // final String color;

//   // DetailPage({Key key, this.user, this.i, this.job, this.color})
//   //     : super(key: key);
//   DetailPage({Key key, this.user, this.job}) : super(key: key);
//   factory DetailPage.forDesignTime() {
//     // TODO: add arguments
//     return new DetailPage();
//   }

//   @override
//   State<StatefulWidget> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   TextEditingController itemController = new TextEditingController();
//   List<dynamic> serviceItems;

//   void addServiceItemToFirebase() async {
//     bool isExist = false;
//     int length = widget.job.serviceItems.length + 1;
//     List<dynamic> list = new List<dynamic>();
//     widget.job.serviceItems
//       ..forEach((v) {
//         list.add(v);
//       });
//     try {
//       await Firestore.instance
//           .collection('service-items')
//           .document(widget.job.fbId + '_' + length.toString())
//           .setData(
//               {"name": itemController.text.toString().trim(), "isDone": true});
//       List l = new List();
//       l.add({"name": itemController.text.toString().trim(), "isDone": false});
//       widget.job.serviceItems.add(
//           {"name": itemController.text.toString().trim(), "isDone": false});

//       await Firestore.instance
//           .collection("workorders")
//           .document(widget.job.fbId)
//           .updateData({'serviceItems': FieldValue.arrayUnion(l)});
//     } catch (e) {
//       print(e);
//     }
//     itemController.clear();
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       body: new Stack(
//         children: <Widget>[
//           _getToolbar(context),
//           Container(
//             child: NotificationListener<OverscrollIndicatorNotification>(
//               onNotification: (overscroll) {
//                 overscroll.disallowGlow();
//               },
//               child: new StreamBuilder<QuerySnapshot>(
//                   stream: Firestore.instance
//                       .collection("workorders")
//                       .where("fbId", isEqualTo: widget.job.fbId.toString())
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (!snapshot.hasData)
//                       return new Center(
//                           child: CircularProgressIndicator(
//                         backgroundColor: currentColor,
//                       ));
//                     return new Container(
//                       child: getExpenseItems(snapshot),
//                     );
//                   }),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: DiamondFab(
//         onPressed: () {
//           Navigator.of(context).push(new PageRouteBuilder(
//               pageBuilder: (_, __, ___) => new AddServiceItems(
//                     user: widget.user,
//                     currentJob: widget.job,
//                   )
//               // showDialog(
//               //   context: context,
//               //   builder: (BuildContext context) {
//               //     return AlertDialog(
//               //       content: Row(
//               //         children: <Widget>[
//               //           Expanded(
//               //             child: new TextField(
//               //               autofocus: true,
//               //               decoration: InputDecoration(
//               //                   border: new OutlineInputBorder(
//               //                       borderSide:
//               //                           new BorderSide(color: currentColor)),
//               //                   labelText: "Item",
//               //                   hintText: "Item",
//               //                   contentPadding: EdgeInsets.only(
//               //                       left: 16.0,
//               //                       top: 20.0,
//               //                       right: 16.0,
//               //                       bottom: 5.0)),
//               //               controller: itemController,
//               //               style: TextStyle(
//               //                 fontSize: 22.0,
//               //                 color: Colors.black,
//               //                 fontWeight: FontWeight.w500,
//               //               ),
//               //               keyboardType: TextInputType.text,
//               //               textCapitalization: TextCapitalization.sentences,
//               //             ),
//               //           )
//               //         ],
//               //       ),
//               //       actions: <Widget>[
//               //         ButtonTheme(
//               //           //minWidth: double.infinity,
//               //           child: RaisedButton(
//               //             elevation: 3.0,
//               //             onPressed: addServiceItemToFirebase,
//               //             // addServiceItem(),

//               //             child: Text('Add'),
//               //             color: currentColor,
//               //             textColor: const Color(0xffffffff),
//               //           ),
//               //         )
//               //       ],
//               //     );
//               //   },
//               ));
//         },
//         child: Icon(Icons.add),
//         backgroundColor: currentColor,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
//     List<JobModel> listElement = new List();
//     int nbIsDone = 0;
//     JobModel job;
//     if (widget.user.uid.isNotEmpty) {
//       snapshot.data.documents.forEach((f) {
//         job = JobModel.fromSnapshot(f);
//       });
//       listElement.forEach((i) {
//         if (i.isDone) {
//           nbIsDone++;
//         }
//       });

//       return Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 150.0),
//             child: new Column(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       new Text(
//                         // widget.jobPanel.keys.elementAt(widget.i),
//                         widget.job.customer.accountName,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 35.0),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return new AlertDialog(
//                                 title:
//                                     Text("Delete: " + widget.job.id.toString()),
//                                 content: Text(
//                                   "Are you sure you want to delete this list?",
//                                   style: TextStyle(fontWeight: FontWeight.w400),
//                                 ),
//                                 actions: <Widget>[
//                                   ButtonTheme(
//                                     //minWidth: double.infinity,
//                                     child: RaisedButton(
//                                       elevation: 3.0,
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text('No'),
//                                       color: currentColor,
//                                       textColor: const Color(0xffffffff),
//                                     ),
//                                   ),
//                                   ButtonTheme(
//                                     //minWidth: double.infinity,
//                                     child: RaisedButton(
//                                       elevation: 3.0,
//                                       onPressed: () {
//                                         // Firestore.instance
//                                         //     .collection('workorders')
//                                         //     .document(widget.job.id)

//                                         //     .delete();
//                                         // Navigator.pop(context);
//                                         // Navigator.of(context).pop();
//                                       },
//                                       child: Text('YES'),
//                                       color: currentColor,
//                                       textColor: const Color(0xffffffff),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         child: Icon(
//                           FontAwesomeIcons.trash,
//                           size: 25.0,
//                           color: currentColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 5.0, left: 50.0),
//                   child: Row(
//                     children: <Widget>[
//                       new Text(
//                         nbIsDone.toString() +
//                             " of " +
//                             widget.job.serviceItems.length.toString() +
//                             " tasks",
//                         style: TextStyle(fontSize: 18.0, color: Colors.black54),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 5.0),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         flex: 2,
//                         child: Container(
//                           margin: EdgeInsets.only(left: 50.0),
//                           color: Colors.grey,
//                           height: 1.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 30.0),
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         color: Color(0xFFFCFCFC),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.height - 350,
//                           child: ListView.builder(
//                               physics: const BouncingScrollPhysics(),
//                               itemCount: widget.job.serviceItems.length,
//                               itemBuilder: (BuildContext ctxt, int i) {
//                                 return new Slidable(
//                                   delegate: new SlidableBehindDelegate(),
//                                   actionExtentRatio: 0.25,
//                                   child: GestureDetector(
//                                     // onTap: () {
//                                     //   Firestore.instance
//                                     //       .collection(widget.user.uid)
//                                     //       .document(widget.jobPanel.elementAt(widget.i).job.id)
//                                     //       .updateData({
//                                     //     listElement.elementAt(i).customer.accountName:
//                                     //         !listElement.elementAt(i).isDone
//                                     //   });
//                                     // },
//                                     child: Container(
//                                       height: 50.0,
//                                       color: widget.job.serviceItems
//                                               .elementAt(i)['isDone']
//                                           ? Color(0xFFF0F0F0)
//                                           : Color(0xFFFCFCFC),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(left: 50.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: <Widget>[
//                                             Icon(
//                                               widget.job.serviceItems
//                                                       .elementAt(i)['isDone']
//                                                   ? FontAwesomeIcons.checkSquare
//                                                   : FontAwesomeIcons.square,
//                                               color: widget.job.serviceItems
//                                                       .elementAt(i)['isDone']
//                                                   ? currentColor
//                                                   : Colors.black,
//                                               size: 20.0,
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 30.0),
//                                             ),
//                                             Flexible(
//                                               child: Text(
//                                                 widget.job.serviceItems
//                                                     .elementAt(i)['name'],
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 1,
//                                                 style: widget.job.serviceItems
//                                                         .elementAt(i)['isDone']
//                                                     ? TextStyle(
//                                                         decoration:
//                                                             TextDecoration
//                                                                 .lineThrough,
//                                                         color: currentColor,
//                                                         fontSize: 27.0,
//                                                       )
//                                                     : TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 27.0,
//                                                       ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   secondaryActions: <Widget>[
//                                     new IconSlideAction(
//                                       caption: 'Delete',
//                                       color: Colors.red,
//                                       icon: Icons.delete,
//                                       onTap: () {
//                                         Firestore.instance
//                                             .collection(widget.user.uid)
//                                             .document(widget.job.id)
//                                             .updateData({
//                                           listElement
//                                               .elementAt(i)
//                                               .customer
//                                               .accountName: ""
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     serviceItems = widget.job.serviceItems;
//     switch (widget.job.status) {
//       case 'Active':
//         currentColor = Colors.green[800];
//         break;
//       default:
//         currentColor = Color.fromRGBO(66, 165, 245, 1.0);
//         break;
//     }
//   }

//   Color pickerColor;
//   Color currentColor;

//   ValueChanged<Color> onColorChanged;

//   changeColor(Color color) {
//     setState(() => pickerColor = color);
//   }

//   Padding _getToolbar(BuildContext context) {
//     return new Padding(
//       padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 12.0),
//       child:
//           new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         new Image(
//             width: 35.0,
//             height: 35.0,
//             fit: BoxFit.cover,
//             image: new AssetImage('assets/list.png')),
//         RaisedButton(
//           elevation: 3.0,
//           onPressed: () {
//             pickerColor = currentColor;
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Pick a color!'),
//                   content: SingleChildScrollView(
//                     child: ColorPicker(
//                       pickerColor: pickerColor,
//                       onColorChanged: changeColor,
//                       enableLabel: true,
//                       colorPickerWidth: 1000.0,
//                       pickerAreaHeightPercent: 0.7,
//                     ),
//                   ),
//                   actions: <Widget>[
//                     FlatButton(
//                       child: Text('Got it'),
//                       onPressed: () {
//                         Firestore.instance
//                             .collection(widget.user.uid)
//                             .document(widget.job.id)
//                             .updateData(
//                                 {"color": pickerColor.value.toString()});

//                         setState(() => currentColor = pickerColor);
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Text(widget.job.status),
//           color: currentColor,
//           textColor: const Color(0xffffffff),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: new Icon(
//             Icons.close,
//             size: 40.0,
//             color: currentColor,
//           ),
//         ),
//       ]),
//     );
//   }
// }
