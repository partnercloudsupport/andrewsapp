// import 'package:flutter/material.dart';
// import 'timesheets_bloc.dart';
// import 'package:taskist/model/timesheet.dart';
// import 'package:taskist/tests/common/common_divider.dart';
// import 'package:taskist/tests/common/label_icon.dart';
// import 'package:taskist/tests/common/uidata.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../tests/common/uidata.dart';
// import 'package:flutter/material.dart';
// import 'package:taskist/logic/timesheet_bloc_provider.dart';
// // import 'widgets/people_Timesheets_list.dart';

// // class TimesheetsList extends StatefulWidget {
// //   final String _emailAddress;

// //   TimesheetsList(this._emailAddress);

// //   @override
// //   TimesheetsListState createState() {
// //     return TimesheetsListState();
// //   }
// // }

// // class TimesheetsListState extends State<TimesheetsList>
// //     with SingleTickerProviderStateMixin {
// //   TabController _tabController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
// //     _tabController.addListener(_handleTabIndex);
// //   }

// //   @override
// //   void dispose() {
// //     _tabController.removeListener(_handleTabIndex);
// //     _tabController.dispose();
// //     super.dispose();
// //   }

// //   void _handleTabIndex() {
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           StringConstant.TimesheetListTitle,
// //           style: TextStyle(
// //             color: Colors.black,
// //           ),
// //         ),
// //         backgroundColor: Colors.amber,
// //         elevation: 0.0,
// //         bottom: TabBar(
// //           controller: _tabController,
// //           tabs: <Tab>[
// //             Tab(text: StringConstant.worldTab),
// //             Tab(text: StringConstant.myTab),
// //           ],
// //         ),
// //       ),
// //       body: TabBarView(
// //         controller: _tabController,
// //         children: <Widget>[
// //           MyTimesheetsListScreen(widget._emailAddress),
// //         ],
// //       ),
// //       floatingActionButton: _bottomButtons(),
// //     );
// //   }

// //   Widget _bottomButtons() {
// //     if (_tabController.index == 1) {
// //       // return FloatingActionButton(
// //       //     child: Icon(Icons.add),
// //       //     onPressed: () {
// //       //       Navigator.push(
// //       //           context,
// //       //           MaterialPageRoute(
// //       //               builder: (context) => AddTimesheetScreen(widget._emailAddress)));
// //       //     });
// //     } else {
// //       return null;
// //     }
// //   }
// // }

// class TimesheetsList extends StatelessWidget {
//   //column1
//   Widget profileColumn(BuildContext context, Timesheet timesheet) => Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           // CircleAvatar(
//           //   backgroundImage: NetworkImage(timesheet.personImage),
//           // ),
//           Expanded(
//               child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   timesheet.userId,
//                   style: Theme.of(context)
//                       .textTheme
//                       .body1
//                       .apply(fontWeightDelta: 700),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(
//                   timesheet.status,
//                   style: Theme.of(context).textTheme.caption.apply(
//                       fontFamily: UIData.ralewayFont, color: Colors.pink),
//                 )
//               ],
//             ),
//           ))
//         ],
//       );

//   //column last
//   Widget actionColumn(Timesheet timesheet) => FittedBox(
//         fit: BoxFit.contain,
//         child: ButtonBar(
//           alignment: MainAxisAlignment.center,
//           children: <Widget>[
//             LabelIcon(
//               // label: "${timesheet.likesCount} Likes",
//               label: " Likes",
//               icon: FontAwesomeIcons.solidThumbsUp,
//               iconColor: Colors.green,
//             ),
//             LabelIcon(
//               // label: "${timesheet.commentsCount} Comments",
//               label: "Comments",
//               icon: FontAwesomeIcons.comment,
//               iconColor: Colors.blue,
//             ),
//             Text(
//               timesheet.status,
//               style: TextStyle(fontFamily: UIData.ralewayFont),
//             )
//           ],
//         ),
//       );

//   //alltmesheets dropdown
//   Widget bottomBar() => PreferredSize(
//       preferredSize: Size(double.infinity, 50.0),
//       child: Container(
//           color: Colors.black,
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 50.0,
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               color: Colors.white,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     "All Timesheets",
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.w700),
//                   ),
//                   Icon(Icons.arrow_drop_down)
//                 ],
//               ),
//             ),
//           )));

//   Widget bodyList(List<Timesheet> timesheets) => SliverList(
//         delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: timesheetCard(context, timesheets[index]),
//           );
//         }, childCount: timesheets.length),
//       );

//   Widget bodySliverList() {
//     TimesheetBloc timesheetBloc = TimesheetBloc();
//     _bloc = TimesheetsBlocProvider.of(context);

//     return StreamBuilder<List<Timesheet>>(
//         stream: timesheetBloc.timesheetList,
//         builder: (context, snapshot) {
//           return snapshot.hasData
//               ? CustomScrollView(
//                   slivers: <Widget>[
//                     bodyList(snapshot.data),
//                   ],
//                 )
//               : Center(child: CircularProgressIndicator());
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: bodySliverList(),
//     );
//   }
// }
