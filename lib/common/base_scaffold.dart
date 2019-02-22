import 'package:flutter/material.dart';
import 'common_drawer.dart';
import 'custom_float.dart';
import 'uidata.dart';
import 'package:taskist/common/about_tile.dart';
import 'package:taskist/common/uidata.dart';
import 'package:taskist/common/menu_view_model.dart';
import 'package:taskist/common/profile_tile.dart';
import 'package:taskist/model/menu.dart';
import 'package:taskist/model/device_model.dart';
import 'package:taskist/model/employee.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/current_user_model.dart';
import '../model/device_model.dart';
import 'package:latlong/latlong.dart';
import 'package:latlong/latlong.dart';

class BaseScaffold extends StatelessWidget {
  final appTitle;
  final Employee currentEmployee;
  final scaffoldKey;
  final showBottomNav;
  Widget bodyData;
  final DeviceModel deviceModel;
  final Menu menu;

  BaseScaffold({
    this.appTitle,
    this.bodyData,
    this.menu,
    this.deviceModel,
    this.showBottomNav,
    this.scaffoldKey,
    this.currentEmployee,
  });

  Widget menuStack(BuildContext context, Menu menu) => InkWell(
        onTap: () => _showModalBottomSheet(context, menu),
        splashColor: Colors.orange,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              menuImage(menu),
              menuColor(),
              menuData(menu),
            ],
          ),
        ),
      );

  //stack 1/3
  Widget menuImage(Menu menu) => Image.asset(
        menu.image,
        fit: BoxFit.cover,
      );

  //stack 2/3
  Widget menuColor() => new Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 5.0,
          ),
        ]),
      );

  //stack 3/3
  Widget menuData(Menu menu) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            menu.icon,
            color: Colors.black,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            menu.title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget header(BuildContext context) {
    final deviceModelxx =
        ScopedModel.of<DeviceModel>(context, rebuildOnChange: true);

    print(deviceModelxx.device.currentPosition);
    return Ink(
      decoration: BoxDecoration(
          // gradient: LinearGradient(colors: UIData.kitGradients2)
          color: Colors.blueAccent),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                    width: 52.0,
                    height: 52.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      image: new DecorationImage(
                          // fit: BoxFit.fill,
                          image: (currentEmployee.avatarSmall != null)
                              ? NetworkImage(currentEmployee.avatarSmall)
                              : AssetImage('assets/image/icon.png')),
                    )),
                Text(
                  "Device Owner",
                  textScaleFactor: .8,
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileTile(
                title: "Route 2",
                subtitle: "",
                textColor: Colors.white,
              ),
            ),
            new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 52.0,
                      height: 52.0,
                      child: CircleAvatar(
                          child: IconButton(
                            icon: Icon(Icons.map),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green.shade600),
                      // width: 52.0,
                      // height: 52.0,
                      padding: const EdgeInsets.all(2.0), // borde width
                      decoration: new BoxDecoration(
                        color: const Color(0xFFFFFFFF), // border color
                        shape: BoxShape.circle,
                      )),
                  Text(
                    (deviceModelxx.device.distanceToStore != null)
                        ? deviceModelxx.device.distanceToStore + 'm'
                        : 'no updates',
                    textScaleFactor: .8,
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  )
                ]
                // CircleAvatar(
                //     radius: 25.0,
                //     backgroundImage: NetworkImage(owner.avatar.small)),
                )
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, Menu menu) {
    // MenuBloc menuBloc = MenuBloc();
    MenuViewModel menu = MenuViewModel();

    showModalBottomSheet(
        context: context,
        builder: (context) => Material(
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(15.0),
                    topRight: new Radius.circular(15.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                header(context),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: menu.getMenuItems().length,
                    itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListTile(
                              title: Text(
                                menu.menuItems[i].title,
                              ),
                              onTap: () {
                                //  callback(2);
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, "/${menu.menuItems[i].title}");
                              }),
                        ),
                  ),
                ),
                MyAboutTile()
              ],
            )));
  }

  Widget myBottomBar(BuildContext context) => BottomAppBar(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shape: CircularNotchedRectangle(),
        child: Ink(
          height: 60.0,
          decoration: new BoxDecoration(
            // color: Colors.blueAccent,
            border: new Border.all(color: Colors.blueAccent, width: 2),
            // borderRadius: BorderRadius.all(Radius.circular(7.0)),
            // gradient: new LinearGradient(colors: UIData.kitGradients3)
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                child: new InkWell(
                  radius: 10.0,
                  splashColor: Colors.grey,
                  onTap: () => _showModalBottomSheet(context, menu),
                  child: Center(
                    widthFactor: 2,
                    child: new Icon(Icons.menu,
                        size: 40, color: Colors.blueAccent),
                    //  Text(
                    //   "ADD TO WISHLIST",
                    //   style: new TextStyle(
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                  ),
                ),
              ),
              // new SizedBox(
              //   width: 10.0,
              // ),
              SizedBox(
                height: double.infinity,
                child: new InkWell(
                  onTap: () {},
                  // radius: 10.0,
                  // splashColor: Colors.grey,
                  child: Center(
                    widthFactor: 2,
                    child: new Icon(Icons.phone,
                        size: 37, color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // ScopedModelDescendant<DeviceModel>(builder: (context, child, device) {
    final deviceModelx =
        ScopedModel.of<DeviceModel>(context, rebuildOnChange: true);
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      drawer: CommonDrawer(),
      body: bodyData,
      bottomNavigationBar: showBottomNav ? myBottomBar(context) : null,
    );
    // });
  }
}
