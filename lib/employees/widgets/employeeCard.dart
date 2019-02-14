import 'package:flutter/material.dart';
import 'employee_detail.dart';
import 'package:flutter/material.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
// import 'package:taskist/rugs/models/employeepanel.dart';
import 'package:taskist/rugs/page_detail.dart';

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 18.0,
        color: new Color(0xff00c6ff)
    );
  }
}

class EmployeeCard extends StatelessWidget {

  final Employee employee;
  final Device device;
  final bool horizontal;

  EmployeeCard(this.employee, this.device, {this.horizontal = true});

  EmployeeCard.vertical(this.employee, this.device): horizontal = false;


  @override
  Widget build(BuildContext context) {

    final employeeThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: 
       (employee.email != null) ?
          new Hero(
          tag: "employee-hero-${employee.email}",
          child: new CircleAvatar(
          backgroundImage: new NetworkImage(employee.avatar),
          radius: 45,
        )
          ):
          new Hero(
          tag: "employee-hero-${employee.id}",
          child: new CircleAvatar(
          backgroundImage: new NetworkImage(employee.avatar),
          radius: 45,
        )
    )
          );
          
          


    Widget _employeeValue({String value, String image}) {
      return new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
               (employee.cell_phone != null) ?
            new Text(employee.cell_phone, style: Style.smallTextStyle)
            :
            new Text(employee.id, style: Style.smallTextStyle)
          ]
        ),
      );
    }


    final employeeCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(employee.name, style: Style.titleTextStyle),
          new Container(height: 10.0),
               (employee.email != null) ?
          new Text(employee.email, style: Style.commonTextStyle)
          :
          new Text(employee.id, style: Style.commonTextStyle),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               (employee.cell_phone != null) ?
              new Expanded(
                flex: horizontal ? 1 : 0,
                child: _employeeValue(
                  value: employee.cell_phone,
                  image: 'assets/images/ic_distance.png')

              ): null,
              //  new Expanded(
              //   flex: horizontal ? 1 : 0,
              //   child: _employeeValue(
              //     value: employee.id,
              //     image: 'assets/images/ic_distance.png')

              // ),
              new Container(
                width: horizontal ? 8.0 : 32.0,
              ),
               (employee.email != null) ?

              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _employeeValue(
                  value: employee.email,
                  image: 'assets/images/ic_gravity.png')
              ): 
                 new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _employeeValue(
                  value: 'n/a',
                  image: 'assets/images/ic_gravity.png')
              ),
            ],
          ),
        ],
      ),
    );


    final employeeCard = new Container(
      child: employeeCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? new EdgeInsets.only(left: 46.0)
        : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new EmployeeDetailPage(employee, device),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                new FadeTransition(opacity: animation, child: child),
              ) ,
            )
          : null,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            employeeCard,
            employeeThumbnail,
          ],
        ),
      )
    );
  }
}