// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:card_settings/card_settings.dart';
// import '../model/current_user_model.dart';
// import '../model/asset.dart';
// import '../model/employee.dart';
// import './asset_list.dart';
// import '../model/maintenance_record.dart';
// import 'package:taskist/model/workorder.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:scoped_model/scoped_model.dart';

// class HardwareMaintenanceForm extends StatefulWidget {
//   final Asset currentAsset;
//   final Employee currentEmployee;
//   HardwareMaintenanceForm({Key key, this.currentAsset, this.currentEmployee})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _HardwareMaintenanceFormFormState();
// }

// class _HardwareMaintenanceFormFormState extends State<HardwareMaintenanceForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<String> litems = [];
//   TextEditingController notesController = new TextEditingController();
//   final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _notesKey = GlobalKey<FormState>();
//   bool _autoValidate = false;
//   bool _hasImage = false;
//   Asset currentAsset;
//   Employee currentEmployee;
//   MaintenanceRecord currentRecord = new MaintenanceRecord();

//   @override
//   void initState() {
//     String id = DateTime.now().toString();
//     super.initState();
//     currentEmployee = widget.currentEmployee;
//     currentAsset = widget.currentAsset;
//   }

//   _siFab(context, CurrentUserModel currentUserModel) {
//     return FloatingActionButton.extended(
//         icon: Icon(Icons.save),
//         onPressed: () async {
//           if (_formKey.currentState.validate()) {
//             // var size = int.tryParse(lengthController.text) *
//             //     int.tryParse(widthController.text);
//             // currentRecord.quantity = size;
//             // currentRecord.length = int.tryParse(lengthController.text);
//             // currentRecord.width = int.tryParse(widthController.text);
//             // var now = new DateTime.now();
//             // var formatter = new DateFormat('M/d/yy');
//             // String formatted = formatter.format(now);
//             // currentRecord.prettyCreatedAt = formatted;
//             // Duration dur = new Duration(days: 21);
//             // currentRecord.createdBy = currentUserModel.firebaseUser.uid;
//             // var due = now.add(dur);
//             // String dueFormatted = formatter.format(due);
//             // currentRecord.prettyDueAt = dueFormatted;
//             // // currentRecord.customerPhone =
//             // currentRecord.status = 'Not Yet Started';
//             // currentRecord.priority = 'Medium';
//             // currentRecord.isDone = false;
//             // currentRecord.intake_notes = "Rug is highly urinated";
//             // currentRecord.needsRepair = 'FALSE';
//             // print(currentRecord.prettyDueAt);
//             // try {
//             //   Firestore.instance
//             //       .collection('workorders')
//             //       .document(currentRecord.workorderId)
//             //       .collection('hardwareItems')
//             //       .document()
//             //       .setData(HardwareItemSerializer().toMap(currentRecord));
//             // } catch (e) {
//             //   print(e);
//             // }
//             // Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
//             //     content: Text(currentRecord.id.toString() +
//             //         ' ' +
//             //         currentRecord.workorderId)));
//             // currentRecord = null;

//             // ;

//             // Navigator.of(context).push(new PageRouteBuilder(
//             //     pageBuilder: (_, __, ___) => new AssetList()));
//           }
//         },
//         label: new Text('Finish'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     //     key: _scaffoldKey,
//     var currentUserModel =
//         ScopedModel.of<CurrentUserModel>(context, rebuildOnChange: true);
//     return Scaffold(
//         body: Stack(children: <Widget>[
//           _getToolbar(context),
//           Padding(
//             padding: EdgeInsets.only(top: 53.0),
//             child: Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey,
//                     height: 1.5,
//                   ),
//                 ),
//                 Expanded(
//                     flex: 2,
//                     child: new Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           'ShopItem',
//                           style: new TextStyle(
//                               fontSize: 30.0, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           'Form',
//                           style:
//                               new TextStyle(fontSize: 28.0, color: Colors.grey),
//                         ),
//                       ],
//                     )),
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey,
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 87.0),
//             child: Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey,
//                     height: 0,
//                   ),
//                 ),
//                 Text(
//                   '[tag: ' + currentRecord.id + ']',
//                   style: new TextStyle(
//                       fontSize: 12.0, color: Colors.blue.shade900),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey,
//                     height: 0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Form(
//             key: _formKey,
//             child: // We'll build this out in the next steps!

//                 Column(children: <Widget>[
//               Padding(
//                   padding: EdgeInsets.only(top: 170.0, left: 18, right: 18),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       // formBuilder(),
//                       Expanded(
//                         flex: 2,
//                         child: ListTile(
//                             leading: _buildMaintenanceRecordNotes(),
//                             // leading: Image.file(snapshot.data),
//                             onTap: () {/* react to the tile being tapped */}),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: ListTile(
//                             leading: _buildMaintenanceRecordNotes(),
//                             // leading: Image.file(snapshot.data),
//                             onTap: () {/* react to the tile being tapped */}),
//                       ),
//                     ],
//                   )),
//               Padding(
//                 padding: EdgeInsets.only(top: 100.0, right: 18, left: 18),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: ListTile(
//                           leading: _buildMaintenanceRecordNotes(),
//                           // leading: Image.file(snapshot.data),
//                           onTap: () {
//                             /* react to the tile being tapped */
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//           )
//         ]),
//         floatingActionButton: _siFab(context, currentUserModel),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
//   }

//   Padding _getToolbar(BuildContext context) {
//     return new Padding(
//       padding: EdgeInsets.only(top: 30, left: 20.0, right: 12.0),
//       child:
//           new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         new Image(
//             width: 35.0,
//             height: 35.0,
//             fit: BoxFit.cover,
//             image: new AssetImage('assets/icon.png')),
//         // GestureDetector(
//         //     onTap: () {
//         //       Navigator.of(context).push(new PageRouteBuilder(
//         //           pageBuilder: (_, __, ___) => new AssetList()));
//         //     },
//         //     child: new Icon(Icons.close, size: 35.0, color: Colors.red)),
//       ]),
//     );
//   }

//   saveItem(b) async {}
//   TextFormField _buildMaintenanceRecordNotes() {
//     return new TextFormField(
//       decoration: InputDecoration(
//           border: new OutlineInputBorder(
//               borderSide: new BorderSide(color: Colors.teal)),
//           filled: true,
//           labelText: 'Notes',
//           suffixIcon: new FlatButton(
//               onPressed: () {
//                 notesController.clear();
//               },
//               child: new Icon(Icons.clear))),
//       maxLength: 114,
//       // initialValue: '(903) ',
//       controller: notesController,
//       inputFormatters: <TextInputFormatter>[],
//       autofocus: true,
//       style: TextStyle(
//         fontSize: 22.0,
//         color: Colors.black,
//         fontWeight: FontWeight.w500,
//       ),
//       maxLines: 5,

//       textCapitalization: TextCapitalization.sentences,
//     );
//   }

//   // TextFormField _buildCardSettingsInt_Length() {
//   //   return new TextFormField(
//   //     decoration: InputDecoration(
//   //         border: new OutlineInputBorder(
//   //             borderSide: new BorderSide(color: Colors.teal)),
//   //         filled: true,
//   //         // icon: Icon(Icons.phone),
//   //         labelText: 'Length',
//   //         suffixIcon: new FlatButton(
//   //             onPressed: () {
//   //               lengthController.clear();
//   //             },
//   //             child: new Icon(Icons.clear))),
//   //     keyboardType: TextInputType.phone,
//   //     maxLength: 14,
//   //     controller: lengthController,
//   //     validator: (value) {
//   //       if (value.isEmpty) {
//   //         return 'Please enter some text';
//   //       }
//   //     },
//   //     inputFormatters: <TextInputFormatter>[
//   //       WhitelistingTextInputFormatter.digitsOnly,
//   //     ],
//   //     autofocus: true,
//   //     style: TextStyle(
//   //       fontSize: 22.0,
//   //       color: Colors.black,
//   //       fontWeight: FontWeight.w500,
//   //     ),
//   //     key: _lengthKey,
//   //   );
//   // }

//   // TextFormField _buildCardSettingsInt_Width() {
//   //   return new TextFormField(
//   //     decoration: InputDecoration(
//   //         border: new OutlineInputBorder(
//   //             borderSide: new BorderSide(color: Colors.teal)),
//   //         filled: true,
//   //         // icon: Icon(Icons.phone),
//   //         labelText: 'Width',
//   //         suffixIcon: new FlatButton(
//   //             onPressed: () {
//   //               widthController.clear();
//   //             },
//   //             child: new Icon(Icons.clear))),
//   //     keyboardType: TextInputType.phone,
//   //     validator: (value) {
//   //       if (value.isEmpty) {
//   //         return 'Please enter some text';
//   //       }
//   //     },
//   //     key: _widthKey,
//   //     maxLength: 14,
//   //     controller: widthController,
//   //     inputFormatters: <TextInputFormatter>[
//   //       WhitelistingTextInputFormatter.digitsOnly,
//   //     ],
//   //     autofocus: true,
//   //     style: TextStyle(
//   //       fontSize: 22.0,
//   //       color: Colors.black,
//   //       fontWeight: FontWeight.w500,
//   //     ),
//   //   );
//   // }
// }
