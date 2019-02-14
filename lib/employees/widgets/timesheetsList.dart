import 'package:flutter/material.dart';
import 'package:taskist/model/timesheet.dart';
 
class ListViewTimesheets extends StatelessWidget {
  final List<Timesheet> timesheets;
 
  ListViewTimesheets({Key key, this.timesheets}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: timesheets.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text(
                    '${timesheets[position].id}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  subtitle: Text(
                    '${timesheets[position].id}',
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
                          'User ${timesheets[position].id}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () => _onTapItem(context, timesheets[position]),
                ),
              ],
            );
          }),
    );
  }
 
  void _onTapItem(BuildContext context, Timesheet timesheet) {
    Scaffold
        .of(context)
        .showSnackBar(new SnackBar(content: new Text(timesheet.id.toString() + ' - ' + timesheet.id)));
  }
}