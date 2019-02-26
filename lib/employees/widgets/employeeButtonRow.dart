import 'package:flutter/material.dart';
import 'package:taskist/employees/dbService.dart';
import '../../common/deviceApi.dart';
import '../../model/employee.dart';
import '../../model/device.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/device_model.dart';
import 'package:flutter/material.dart';
import 'package:taskist/employees/dbService.dart';
import '../../common/deviceApi.dart';
import '../../model/employee.dart';
import 'package:sms/sms.dart';

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
  bool _clockedIn = false;
  String text;
  DatabaseService dbService = new DatabaseService();

  int _clockButtonState = 0;

  setDevice() async {
    Device _device = await dbService.getDevice();
    setState(() {
      this.device = _device;
    });
  }

  @override
  void initState() {
    super.initState();
    setDevice();
    this.employee = widget.employee;
    setState(() {
      (employee.clockedIn == null) ? _clockedIn = false : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceModel =
        ScopedModel.of<DeviceModel>(context, rebuildOnChange: true);
    return (this.device != null)
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _createClockButton(),
            Container(width: 8),
            _createCheckOutButton(deviceModel: deviceModel),
          ])
        : CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          );
  }

  Widget _createCheckOutButton({
    DeviceModel deviceModel,
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.green,
    String text,
  }) {
    return (device != null)
        ? ClipRRect(
            // borderRadius: new BorderRadius.circular(30.0),
            borderRadius: new BorderRadius.vertical(),
            child: new MaterialButton(
              minWidth: 140.0,
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                (employee.id == device.ownerId)
                    ? checkInDevice(deviceModel)
                    : checkOutDevice();
              },
              child: new Text((employee.id == device.ownerId)
                  ? 'SIGN IN DEVICE'
                  : 'SIGN OUT DEVICE'),
            ),
          )
        : Container();
  }

  void checkInDevice(DeviceModel deviceModel) async {
    DatabaseService serv = new DatabaseService();

    // serv.getEmployee("employeeId");
    Employee employee = await serv.getEmployee(this.employee.id);
    // Employee employee = Employee.of(context);

    Devices devs = new Devices();
    var snipeId = '2';
    var updatedDevice;
    var device = await devs.getDeviceFromSnipe();
    if (deviceModel.owner == int.parse(employee.id)) {
      (int.parse(deviceModel.device.distanceToStore) < 200)
          ? await devs.checkInDevice(device['id'].toString())
          : Scaffold.of(context).showSnackBar(new SnackBar(
              content:
                  new Text("You need to be at the store to checkin a tablet")));
      updatedDevice = await devs.setDeviceOwner('STORE');
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text("Device successfully checked in")));
    } else {
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text("Error checking in device")));
    }
  }

  void checkOutDevice() {}

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
          color: (employee.clockedIn)
              ? Colors.orange.shade900
              : Colors.greenAccent,
          textColor: Colors.white,
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
    employee = await dbService.getEmployee(employee.id);

    setState(() {
      _clockButtonState = 0;
      _clockedIn = employee.clockedIn;
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
