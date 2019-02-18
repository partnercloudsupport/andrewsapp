import 'package:flutter/material.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/employees/widgets/employee_footer.dart';
import 'package:taskist/employees/widgets/employee_detail_headerFB.dart';
import 'package:taskist/employees/widgets/employeeDetailBodyFB.dart';
import '../dbService.dart';

class EmployeeButtonRow extends StatefulWidget {
  EmployeeButtonRow({
    this.employee,
  });
  final Employee employee;

  _EmployeeButtonState createState() => new _EmployeeButtonState();
}

class _EmployeeButtonState extends State<EmployeeButtonRow> {
  Employee employee;
  Device device;
  bool _clockedIn;
  String text;
  DatabaseService dbService = new DatabaseService();

  int _clockButtonState = 0;

  setDevice() async {
    this.device = await dbService.getDevice();
  }

  @override
  void initState() {
    super.initState();
    setDevice();
    (employee.clockedIn == null) ? _clockedIn = false : null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      _createClockButton(),
      _createCheckOutButton(),
    ]);
  }

  Widget _createCheckOutButton(
    String text, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.green,
  }) {
    return new ClipRRect(
      // borderRadius: new BorderRadius.circular(30.0),
      borderRadius: new BorderRadius.vertical(),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {
          (employee.id == device.owner)
              ? text = 'CHECK IN DEVICE'
              : text = 'CHECK OUT DEVICE';
        },
        child: new Text(text),
      ),
    );
  }

  Widget _createClockButton({
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.green,
  }) {
    String clockString;
    (employee.clockedIn == null) ? employee.clockedIn = false : null;
    (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';
    // if (employee.clockedIn && employee.currentDeviceId == widget.device.serial) {
    if (_clockButtonState == 0) {
      return new ClipRRect(
        // borderRadius: new BorderRadius.circular(30.0),
        borderRadius: new BorderRadius.vertical(),
        child: new MaterialButton(
          minWidth: 140.0,
          color: backgroundColor,
          textColor: textColor,
          onPressed: () {
            _clockEmployee();
          },
          child: new Text(clockString),
        ),
      );
    } else if (_clockButtonState == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      );
    } else {
      return Icon(Icons.check, color: Colors.green);
    }
  }

  _clockEmployee() async {
    String clockString;
    (employee.clockedIn == null) ? employee.clockedIn = false : null;
    (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';
    setState(() {
      _clockButtonState = 1;
    });
    // final ts = createNewTimesheet(employee, device);
    await dbService.punchClock(employee, device);
    setState(() {
      _clockButtonState = 0;
    });

    setState(() {
      _clockedIn = !_clockedIn;
    });

    employee.clockedIn = !employee.clockedIn;
    (employee.clockedIn == null) ? employee.clockedIn = false : null;
    (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';

    _createClockButton();
  }

  // void animateClockButton() {
  //   setState(() {
  //     _clockButtonState = 1;
  //   });

  //   Timer(Duration(milliseconds: 3300), () {
  //     setState(() {
  //       _clockButtonState = 2;
  //     });
  //   });
  // }

}
