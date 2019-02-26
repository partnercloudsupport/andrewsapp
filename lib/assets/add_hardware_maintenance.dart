// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:taskist/model/employee.dart';
// import 'package:taskist/model/asset.dart';
// import 'package:taskist/services/employee_service.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'asset_list.dart';
// import '../services/asset_service.dart';
// import './hardware_maintenance_form.dart';

// class AddHardwareMaintenance extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView(children: <Widget>[
//       _getToolbar(context),
//       Padding(
//         padding: EdgeInsets.only(top: 50.0),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               flex: 1,
//               child: Container(
//                 color: Colors.grey,
//                 height: 1.5,
//               ),
//             ),
//             Expanded(
//                 flex: 2,
//                 child: new Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Add',
//                       style: new TextStyle(
//                           fontSize: 30.0, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'ServiceItem',
//                       style: new TextStyle(fontSize: 28.0, color: Colors.grey),
//                     )
//                   ],
//                 )),
//             Expanded(
//               flex: 1,
//               child: Container(
//                 color: Colors.grey,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//       // ItemsListScreen(),
//       Padding(
//         padding: EdgeInsets.only(top: 50.0, left: 0.0, right: 0.0),
//         child: new Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[]),
//       ),
//       _buildIDScanButton(context)
//     ]));
//   }

//   Padding _getToolbar(BuildContext context) {
//     return new Padding(
//       padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 12.0),
//       child:
//           new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         new Image(
//             width: 35.0,
//             height: 35.0,
//             fit: BoxFit.cover,
//             image: new AssetImage('assets/icon.png')),
//         // GestureDetector(
//         //   onTap: () {
//         //     Navigator.of(context).push(new PageRouteBuilder(
//         //         pageBuilder: (_, __, ___) => new AssetList()));
//         //   },
//         //   child: new Icon(
//         //     Icons.close,
//         //     size: 40.0,
//         //     color: Colors.red,
//         //   ),
//         // ),
//       ]),
//     );
//   }

//   Padding _buildIDScanButton(BuildContext context) {
//     return new Padding(
//       padding: EdgeInsets.only(top: 50.0),
//       child: new Column(
//         children: <Widget>[
//           new Container(
//             width: 50.0,
//             height: 50.0,
//             decoration: new BoxDecoration(
//                 border: new Border.all(color: Colors.black38),
//                 borderRadius: BorderRadius.all(Radius.circular(7.0))),
//             child: new IconButton(
//               icon: new Icon(Icons.camera),
//               onPressed: () {
//                 _onIDScanButtonPressed(context);
//               },
//               iconSize: 30.0,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10.0),
//             child: Text('Scan Tag', style: TextStyle(color: Colors.black45)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onIDScanButtonPressed(BuildContext context) async {
//     var barcode;
//     var _barcode = await BarcodeScanner.scan();
//     barcode = json.decode(_barcode);
//     Employee currentEmployee =
//         await EmployeeService().getById(barcode['employeeId']);

//     Navigator.of(context).push(new PageRouteBuilder(
//         pageBuilder: (_, __, ___) => new EquipmentScan(
//               currentEmployee,
//             )));
//   }
// }

// class EquipmentScan extends StatelessWidget {
//   Employee currentEmployee;
//   EquipmentScan(
//     @required this.currentEmployee,
//     // @required this.serviceItemsList,
//   );

//   @override
//   Widget build(BuildContext context) {
//     Padding _buildEQScanButton(BuildContext context) {
//       return new Padding(
//         padding: EdgeInsets.only(top: 50.0),
//         child: new Column(
//           children: <Widget>[
//             new Container(
//               width: 50.0,
//               height: 50.0,
//               decoration: new BoxDecoration(
//                   border: new Border.all(color: Colors.black38),
//                   borderRadius: BorderRadius.all(Radius.circular(7.0))),
//               child: new IconButton(
//                 icon: new Icon(Icons.camera),
//                 onPressed: () {
//                   _scanEQButtonPressed(context);
//                 },
//                 iconSize: 30.0,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 10.0),
//               child: Text('Scan Tag', style: TextStyle(color: Colors.black45)),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void _scanEQButtonPressed(BuildContext context) async {
//     var barcode;
//     var _barcode = await BarcodeScanner.scan();
//     barcode = json.decode(_barcode);
//     Asset currentAsset = await AssetService().getAssetById(barcode['assetId']);

//     Navigator.of(context).push(new PageRouteBuilder(
//         pageBuilder: (_, __, ___) => new HardwareMaintenanceForm(
//             currentAsset: currentAsset,
//             currentEmployee: this.currentEmployee)));
//   }
// }
