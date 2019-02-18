import 'package:flutter/material.dart';
import 'package:taskist/model/timesheet.dart';
import 'package:flutter/material.dart';
import 'package:taskist/employees/widgets/timesheetsList.dart';
import 'package:taskist/model/employee.dart';
// import 'package:taskist/employees/widgets/messages.dart';
import 'package:taskist/employees/widgets/activity_log.dart';
import 'package:taskist/employees/dbService.dart';
import 'package:taskist/model/timesheet.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import '../dbService.dart';

class ActivityLog extends StatelessWidget {
  final Employee employee;
  final DatabaseService dbService = new DatabaseService();

  ActivityLog({Key key, this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<Timesheet>>(
            stream: dbService.getTimesheets(constraints: [
              new QueryConstraint(field: "employeeId", isEqualTo: employee.id)
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
                      return Column(
                        children: <Widget>[
                          Divider(height: 5.0),
                          ListTile(
                            title: Text(
                              '${item.id}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            subtitle: Text(
                              '${item.id}',
                              style: new TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            leading: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  radius: 35.0,
                                  child: Text(
                                    'User ${item.id}',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // onTap: () => _onTapItem(context, item.),
                          ),
                        ],
                      );
                      // }),
                    });
              }

              void _onTapItem(BuildContext context, Timesheet timesheet) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text(
                        timesheet.id.toString() + ' - ' + timesheet.id)));
              }
            }));
  }
}
