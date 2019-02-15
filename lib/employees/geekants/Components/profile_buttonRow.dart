import 'package:flutter/material.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/model/device.dart';
import '../../dbService.dart';

class ProfileButtonRow extends StatefulWidget {
  final Device device;
  final Employee employee;

  ProfileButtonRow({
    Key key,
    @required this.device,
    @required this.employee,
  }) : super(key: key);

  @override
  _ProfileButtonRowState createState() => new _ProfileButtonRowState();
}

class _ProfileButtonRowState extends State<ProfileButtonRow> {
  Employee employee;
  Device device;
  int _clockButtonState = 0;
  bool _clockedIn;
  @override
  void initState() {
    super.initState();
    _clockedIn = widget.employee.clockedIn;

    this.employee = widget.employee;
    this.device = widget.device;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _createClockButton(),
        Container(width: 20),
        _createCheckOutButton()
      ],
    );
  }

  Widget _createCheckOutButton({
    String text,
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.green,
  }) {
    return new ClipRRect(
      // borderRadius: new BorderRadius.circular(30.0),
      borderRadius: new BorderRadius.vertical(),
      child: new MaterialButton(
        minWidth: 140.0,
        height: 40,
        color: Colors.blue.shade900,
        textColor: Colors.white,
        onPressed: () {
          // (employee.id == this.widget.device.assignedTo['id'])
          //     ? _checkInDevice()
          //     : _changeDeviceOwner();
        },
        child: new Text(
            (employee.id == "false") ? 'CHECKIN DEVICE' : 'CHECKOUT DEVICE'),
      ),
    );
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
    clockString;
    employee.clockedIn = !employee.clockedIn;
    (employee.clockedIn == null) ? employee.clockedIn = false : null;
    (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';

    _createClockButton();
  }

  Widget _createClockButton(
      //   String clockString,
      {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white,
  }) {
    String clockString;
    (employee.clockedIn == null) ? employee.clockedIn = false : null;
    (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';
    // String deviceString = 'unavailable';
    // if (device != null) {
    //   (device.owner == employee.id)
    //       ? deviceString = 'CHECK IN'
    //       : deviceString = 'CHECKOUT DEVICE';
    // }

    // if (employee.clockedIn && employee.currentDeviceId == widget.device.serial) {
    if (_clockButtonState == 0) {
      return new ClipRRect(
        // borderRadius: new BorderRadius.circular(30.0),
        borderRadius: new BorderRadius.vertical(),
        child: new MaterialButton(
          minWidth: 140.0,
          color: Colors.red.shade900,
          textColor: Colors.white,
          onPressed: () {
            // _punchClock();
            _clockEmployee();
            // (employee.clockedIn != null)
            //     ? (employee.clockedIn)
            //         ? _clockoutEmployee()
            //         : _clockInEmployee()
            //     : _clockInEmployee();
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

  final DatabaseService dbService = new DatabaseService();
}
