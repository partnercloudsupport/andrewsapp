import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskist/employees/widgets/employee_detail.dart';
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

  void _navigateToEmployeeDetails(context, Employee employee) {
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            new EmployeeDetailsPage(employee: employee)));

    // Navigator.of(context).push(
    //   new MaterialPageRoute(
    //     builder: (c) {
    //       return new EmployeeDetail(employee: employee);
    //     },
    //   ),
    // );
  }

  Widget _buildEmployeeListTile(
      BuildContext context, Employee employee, index) {
    return new ListTile(
      onTap: () => _navigateToEmployeeDetails(context, employee),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(employee.avatar.small),
        ),
      ),
      title: new Text(employee.firstname),
      subtitle: new Text(
          (employee.email != null) ? employee.email : "needs updating"),
    );
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Image(
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/icon.png')),
      ]),
    );
  }

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
        bodyData: Stack(children: <Widget>[
          _getToolbar(context),
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Employee',
                          style: new TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'List',
                          style:
                              new TextStyle(fontSize: 28.0, color: Colors.grey),
                        )
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 130.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<List<Employee>>(
                      stream: dbService.getEmployees(),
                      builder: (context, snapShot) {
                        if (!snapShot.hasData)
                          return new Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                          ));

                        return ListView.builder(
                            itemCount: snapShot.data.length,
                            itemBuilder: (context, index) {
                              var item = snapShot.data[index];
                              return _buildEmployeeListTile(
                                  context, item, index);
                              // return ListTile(
                              //   title: Text(
                              //       '${item.name}   (lat:${item.email})'),
                              //   subtitle: Text('distance: ${item.id}'),
                              // );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
