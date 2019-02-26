import 'package:flutter/material.dart';
import 'package:taskist/model/timesheet.dart';
import 'package:taskist/model/employee.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import '../dbService.dart';

class TimesheetList extends StatelessWidget {
  final Employee employee;

  TimesheetList({Key key, this.employee}) : super(key: key);
  final DatabaseService dbService = new DatabaseService();
  Animation<double> buttonGrowAnimation;
  Animation<double> listTileWidth;
  Animation<Alignment> listSlideAnimation;
  Animation<Alignment> buttonSwingAnimation;
  Animation<EdgeInsets> listSlidePosition;
  Animation<Color> fadeScreenAnimation;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: new EdgeInsets.fromLTRB(32.0, 600.0, 0.0, 32.0),
      child: new Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Timesheet>>(
                stream: dbService.getTimesheets(constraints: [
                  new QueryConstraint(
                      field: "employeeId", isEqualTo: employee.id)
                ]),
                builder: (context, snapShot) {
                  if (!snapShot.hasData || snapShot.data.isEmpty) {
                    return Center(
                        child: Text(
                      'No Datax',
                      style: TextStyle(color: Colors.white),
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: snapShot.data.length,
                        itemBuilder: (context, index) {
                          var item = snapShot.data[index];
                          var intime = new DateTime.fromMillisecondsSinceEpoch(
                              item.in_timestamp * 1000);
                          var outtime = new DateTime.fromMillisecondsSinceEpoch(
                              item.out_timestamp * 1000);
                          String sintime =
                              "${intime.hour.toString()}-${intime.month.toString().padLeft(2, '0')}-${intime.day.toString().padLeft(2, '0')}";
                          String souttime =
                              "${outtime.year.toString()}-${outtime.month.toString().padLeft(2, '0')}-${outtime.day.toString().padLeft(2, '0')}";
                          Duration difference = outtime.difference(intime);
                          return ListTile(
                            leading: new Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 26.0,
                            ),
                            title: Text(
                                'Hours: ${difference.inHours.toString()}                  Date: ${sintime}'),
                            // "${intime.year.toString()}-${intime.month.toString().padLeft(2, '0')}-${intime.day.toString().padLeft(2, '0')}"),
                            // subtitle:
                            //     Text(),
                            trailing: Text(
                                "In: ${intime.hour.toString()}:${intime.minute.toString()}          Out: ${outtime.hour.toString()}:${outtime.minute.toString()}"),
                          );
                        });
                  }
                  ;
                  // return ListView.separated(
                  //     separatorBuilder: (context, index) => Divider(
                  //           color: Colors.black,
                  //         ),
                  //   itemCount: snapShot.data.length,
                  //   itemBuilder: (context, index) {
                  //     var item = snapShot.data[index];
                  //     // return EmployeeCard(item);
                  //     return ListTile(
                  //       leading: const Icon(
                  //         Icons.access_time,
                  //         color: Colors.blue,
                  //       ),
                  //       title: Text('${item.id}, ${item.id}'),
                  //       subtitle: Text('${item.id}, ${item.id}'),
                  //     );
                  //   });
                },
              ),
            ),
          ])),
    );
  }

  // return Container(
  //   child: ListView.builder(
  //       itemCount: timesheets.length,
  //       padding: const EdgeInsets.all(15.0),
  //       itemBuilder: (context, position) {
  //         return Column(
  //           children: <Widget>[
  //             Divider(height: 5.0),
  //             ListTile(
  //               title: Text(
  //                 '${timesheets[position].id}',
  //                 style: TextStyle(
  //                   fontSize: 22.0,
  //                   color: Colors.deepOrangeAccent,
  //                 ),
  //               ),
  //               subtitle: Text(
  //                 '${timesheets[position].id}',
  //                 style: new TextStyle(
  //                   fontSize: 18.0,
  //                   fontStyle: FontStyle.italic,
  //                 ),
  //               ),
  //               leading: Column(
  //                 children: <Widget>[
  //                   CircleAvatar(
  //                     backgroundColor: Colors.blueAccent,
  //                     radius: 35.0,
  //                     child: Text(
  //                       'User ${timesheets[position].id}',
  //                       style: TextStyle(
  //                         fontSize: 22.0,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               onTap: () => _onTapItem(context, timesheets[position]),
  //             ),
  //           ],
  //         );
  //       }),
  // );
}

void _onTapItem(BuildContext context, Timesheet timesheet) {
  Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(timesheet.id.toString() + ' - ' + timesheet.id)));
}
