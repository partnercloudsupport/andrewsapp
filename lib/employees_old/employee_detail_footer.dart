// import 'package:flutter/material.dart';
// import 'package:taskist/model/employee.dart';
// import 'package:taskist/employees/timesheets_list.dart';
// import 'package:taskist/employees/assets_activity.dart';

// class EmployeeShowcase extends StatefulWidget {
//   EmployeeShowcase(this.employee);

//   final Employee employee;

//   @override
//   _EmployeeShowcaseState createState() => new _EmployeeShowcaseState();
// }

// class _EmployeeShowcaseState extends State<EmployeeShowcase>
//     with TickerProviderStateMixin {
//   List<Tab> _tabs;
//   List<Widget> _pages;
//   TabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _tabs = [
//       new Tab(text: 'TimeSheets'),
//       new Tab(text: 'Assets Activity'),
//       // new Tab(text: 'Articles'),
//     ];
//     _pages = [
//       new TimesheetsList(),
//       new AssetsActivity(),
//       // new ArticlesShowcase(),
//     ];
//     _controller = new TabController(
//       length: _tabs.length,
//       vsync: this,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: new Column(
//         children: <Widget>[
//           new TabBar(
//             controller: _controller,
//             tabs: _tabs,
//             indicatorColor: Colors.white,
//           ),
//           new SizedBox.fromSize(
//             size: const Size.fromHeight(300.0),
//             child: new TabBarView(
//               controller: _controller,
//               children: _pages,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
