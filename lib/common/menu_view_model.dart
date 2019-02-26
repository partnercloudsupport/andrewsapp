import 'package:flutter/material.dart';
import 'package:taskist/model/menu.dart';
import 'package:taskist/common/uidata.dart';

class MenuViewModel {
  List<Menu> menuItems;

  MenuViewModel({this.menuItems});

  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
          title: "Dashboard",
          menuColor: Color(0xff261d33),
          icon: Icons.dashboard,
          image: UIData.dashboardImage,
          items: ["Dashboard 1", "Dashboard 2", "Dashboard 3", "Dashboard 4"]),
      Menu(title: "Assets", menuColor: Color(0xffc7d8f4), icon: Icons.send),
      Menu(
        title: "MapView",
        menuColor: Color(0xffc7d8f4),
        icon: Icons.map,
        // image: UIData.loginImage
      ),
      Menu(
          title: "RugPage",

          // menuColor: Color(0xff7f5741),
          menuColor: Colors.black,
          icon: Icons.timeline,
          image: UIData.timelineImage),
      // items: ["Feed", "Tweets", "Timeline 3", "Timeline 4"]

      Menu(
        title: "EmployeeList",
        menuColor: Color(0xff050505),
        icon: Icons.person,
        image: UIData.profileImage,
      ),
      // items: ["View Profile", "Profile 2", "Profile 3", "Profile 4"]

      Menu(
        title: "Settings",
        menuColor: Color(0xff2a8ccf),
        icon: Icons.settings,
        image: UIData.settingsImage,
        // items: ["Device Settings", "Settings 2", "Settings 3", "Settings 4"]
      ),
    ];
  }
}
