import 'package:flutter/material.dart';
// import 'package:taskist/employees/employeesmodels/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskist/model/employee.dart';

class EmployeeDetailBodyFB extends StatelessWidget {
  EmployeeDetailBodyFB(this.employee);
  final Employee employee;

  Widget _buildLocationInfo(TextTheme textTheme) {
    // String address;
    // try {
    //   address = employee['address']['street'] +
    //       ', ' +
    //       employee['address']['city'] +
    //       ' ' +
    //       employee['address']['zipcode'];
    // } catch (e) {
    //   print(e);
    //   address = 'null';
    // }
    return new Row(
      children: <Widget>[
        new Icon(
          Icons.place,
          color: Colors.white,
          size: 16.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: 
          new Text(
            "asdf",
            // employee.address.getPretty(),
            // "address",
            style: textTheme.subhead.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _createCircleBadge(IconData iconData, Color color) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new CircleAvatar(
        backgroundColor: color,
        child: new Icon(
          iconData,
          color: Colors.white,
          size: 16.0,
        ),
        radius: 16.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          employee.name,
          // "name",
          style: textTheme.headline.copyWith(color: Colors.white),
        ),
        new Text(
          (employee.email != null) ? employee.email : "needs updating",
          // 'email',
          style: textTheme.subhead.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: _buildLocationInfo(textTheme),
        ),
        // new Padding(
        //   padding: const EdgeInsets.only(top: 16.0),
        //   child: new Text(
        //     'Lorem Ipsum is simply dummy text of the printing and typesetting '
        //         'industry. Lorem Ipsum has been the industry\'s standard dummy '
        //         'text ever since the 1500s.',
        //     style:
        //         textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
        //   ),
        // ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Row(
            children: <Widget>[
              _createCircleBadge(Icons.beach_access, theme.accentColor),
              _createCircleBadge(Icons.cloud, Colors.white12),
              _createCircleBadge(Icons.shop, Colors.white12),
            ],
          ),
        ),
      ],
    );
  }
}
