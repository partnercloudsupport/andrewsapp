import 'package:flutter/material.dart';
import 'package:taskist/employees/widgets/timesheetsList.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/employees/widgets/activity_log.dart';
import 'package:taskist/employees/dbService.dart';
// import '../geekants/Components/ListViewContainer.dart';

class EmployeeDetailFooter extends StatefulWidget {
  EmployeeDetailFooter(this.employee);

  final Employee employee;
  // final DatabaseService dbService;

  @override
  _FriendShowcaseState createState() => new _FriendShowcaseState();
}

class _FriendShowcaseState extends State<EmployeeDetailFooter>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;
  Employee employee;
  final DatabaseService dbService = new DatabaseService();
  Animation<double> listTileWidth;
  Animation<Alignment> listSlideAnimation;
  Animation<EdgeInsets> listSlidePosition;

  @override
  void initState() {
    super.initState();
    this.employee = widget.employee;
    _tabs = [
      new Tab(text: 'Time Sheets'),
      new Tab(text: 'Messsages'),
      new Tab(text: 'Activity Log'),
    ];
    _pages = [
      new TimesheetList(employee: employee),
      // new ListViewContent(
      //   listSlideAnimation: listSlideAnimation,
      //   listSlidePosition: listSlidePosition,
      //   listTileWidth: listTileWidth,
      // ),
      new ActivityLog(employee: employee),
    ];
    _controller = new TabController(
      length: _tabs.length,
      initialIndex: 0,
      vsync: this,
    );
  }

//   Widget _timesheetList(BuildContext context) {
//        return  Container(
//             padding: new EdgeInsets.fromLTRB(32.0, 600.0, 0.0, 32.0),
//             child: new Center(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                   new Text(
//                     'TIME SHEETS',
//                     // style: Style.headerTextStyle,
//                   ),
//                   Expanded(
//                     child: StreamBuilder<List<Timesheet>>(
//                       stream: dbService.getTimesheets(constraints: [
//                         new QueryConstraint(
//                             field: "empId", isEqualTo: employee.id)
//                       ]),
//                       builder: (context, snapShot) {
//                         if (!snapShot.hasData || snapShot.data.isEmpty) {
//                           return Center(child: Text('No Data'));
//                         } else {
//                           return ListView.separated(
//                               separatorBuilder: (context, index) => Divider(
//                                     color: Colors.black,
//                                   ),
//                               itemCount: snapShot.data.length,
//                               itemBuilder: (context, index) {
//                                 var item = snapShot.data[index];
//                                 // return EmployeeCard(item);
//                                 return ListTile(
//                                   leading: const Icon(Icons.access_time),
//                                   title: Text(
//                                       '${item.prettyInDay}, ${item.prettyInTime}'),
//                                   subtitle: Text(
//                                       '${item.prettyOutDay}, ${item.prettyOutTime}'),
//                                 );
//                               });
//                         }
//                       },
//                     ),
//                   ),
//                 ])),
//           );
// }
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new TabBar(
            labelStyle: TextStyle(color: Colors.black),
            controller: _controller,
            tabs: _tabs,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
