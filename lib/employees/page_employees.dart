import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskist/employees/widgets/employeeCard.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/common/assetsApi.dart';
import 'dbService.dart';
import './widgets/employeeCard.dart';
import 'package:taskist/common/common_scaffold.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeesListPageState createState() => new _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeeList> {
  Device _device;
  @override
  void initState() {
    super.initState();
    _setDevice();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _setDevice() async {
    _device = await getDevice();
    // this.device = await getDevice();
  }

  final _scaffoldState = GlobalKey<ScaffoldState>();

  final DatabaseService dbService = new DatabaseService();
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backGroundColor: Colors.grey.shade100,
      actionFirstIcon: null,
      appTitle: "Employee List",
      showFAB: true,
      scaffoldKey: _scaffoldState,
      showDrawer: false,
      centerDocked: true,
      floatingIcon: Icons.add,
      showBottomNav: true,
      bodyData: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Employee>>(
                stream: dbService.getEmployees(),
                builder: (context, snapShot) {
                  if (!snapShot.hasData || snapShot.data.isEmpty) {
                    return Center(child: Text('No Data'));
                  } else {
                    return ListView.builder(
                        itemCount: snapShot.data.length,
                        itemBuilder: (context, index) {
                          var item = snapShot.data[index];
                          return EmployeeCard(item, _device);
                          // return ListTile(
                          //   title: Text(
                          //       '${item.name}   (lat:${item.email})'),
                          //   subtitle: Text('distance: ${item.id}'),
                          // );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
