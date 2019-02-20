import 'package:flutter/material.dart';
import 'common_drawer.dart';
import 'custom_float.dart';
import 'uidata.dart';
import 'package:taskist/common/about_tile.dart';
import 'package:taskist/common/uidata.dart';
import 'package:taskist/common/menu_view_model.dart';
import 'package:taskist/common/profile_tile.dart';
import 'package:taskist/model/menu.dart';
import 'package:taskist/model/employee.dart';
import 'dart:async';

class CommonScaffold extends StatelessWidget {
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final callback;
  final backGroundColor;
  // final List userList;
  // final Employee owner;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final floatingIcon;
  final centerDocked;
  final elevation;
  final alerts;
  final Menu menu;

  CommonScaffold(
      {this.appTitle,
      this.bodyData,
      // this.owner,
      this.showFAB = true,
      this.callback,
      // this.userList,
      this.showDrawer = false,
      this.backGroundColor,
      this.menu,
      this.actionFirstIcon = Icons.search,
      this.scaffoldKey,
      this.showBottomNav = true,
      this.centerDocked = true,
      this.alerts = false,
      this.floatingIcon,
      this.elevation = 4.0});

  // Widget menuStack(BuildContext context, Menu menu) => InkWell(
  //       onTap: () => _showModalBottomSheet(context, menu),
  //       splashColor: Colors.orange,
  //       child: Card(
  //         clipBehavior: Clip.antiAlias,
  //         elevation: 2.0,
  //         child: Stack(
  //           fit: StackFit.expand,
  //           children: <Widget>[
  //             menuImage(menu),
  //             menuColor(),
  //             menuData(menu),
  //           ],
  //         ),
  //       ),
  //     );

  // //stack 1/3
  // Widget menuImage(Menu menu) => Image.asset(
  //       menu.image,
  //       fit: BoxFit.cover,
  //     );

  // //stack 2/3
  // Widget menuColor() => new Container(
  //       decoration: BoxDecoration(boxShadow: <BoxShadow>[
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.8),
  //           blurRadius: 5.0,
  //         ),
  //       ]),
  //     );

  // //stack 3/3
  // Widget menuData(Menu menu) => Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Icon(
  //           menu.icon,
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10.0,
  //         ),
  //         Text(
  //           menu.title,
  //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //         )
  //       ],
  //     );

//  Widget bodySliverList() {
//     MenuBloc menuBloc = MenuBloc();
//     return StreamBuilder<List<Menu>>(
//         stream: menuBloc.menuItems,
//         builder: (context, snapshot) {
//           return snapshot.hasData
//               ? CustomScrollView(
//                   slivers: <Widget>[
//                     appBar(),
//                     bodyGrid(snapshot.data),
//                   ],
//                 )
//               : Center(child: CircularProgressIndicator());
//         });
//   }
  // Widget header() => Ink(
  //       decoration: BoxDecoration(
  //           // gradient: LinearGradient(colors: UIData.kitGradients2)
  //           color: Colors.blueAccent),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: <Widget>[
  //             new Container(
  //                 child: new CircleAvatar(
  //                     // child: const Text('C'),
  //                     foregroundColor: Colors.yellow,
  //                     backgroundImage: NetworkImage(owner.avatar.small)),
  //                 width: 52.0,
  //                 height: 52.0,
  //                 padding: const EdgeInsets.all(2.0), // borde width
  //                 decoration: new BoxDecoration(
  //                   color: const Color(0xFFFFFFFF), // border color
  //                   shape: BoxShape.circle,
  //                 )),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: ProfileTile(
  //                 title: "Andrews App",
  //                 subtitle: "(903) 926-9768 , (111) 111-1111 , (903) 344-1733 ",
  //                 textColor: Colors.white,
  //               ),
  //             ),

  //             // CircleAvatar(
  //             //     radius: 25.0,
  //             //     backgroundImage: NetworkImage(owner.avatar.small)),
  //           ],
  //         ),
  //       ),
  //     );

  // void _showModalBottomSheet(BuildContext context, Menu menu) {
  //   // MenuBloc menuBloc = MenuBloc();
  //   MenuViewModel menu = MenuViewModel();

  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) => Material(
  //           clipBehavior: Clip.antiAlias,
  //           color: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: new BorderRadius.only(
  //                   topLeft: new Radius.circular(15.0),
  //                   topRight: new Radius.circular(15.0))),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             mainAxisSize: MainAxisSize.max,
  //             children: <Widget>[
  //               header(),
  //               Expanded(
  //                 child: ListView.builder(
  //                   shrinkWrap: false,
  //                   itemCount: menu.getMenuItems().length,
  //                   itemBuilder: (context, i) => Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //                         child: ListTile(
  //                             title: Text(
  //                               menu.menuItems[i].title,
  //                             ),
  //                             onTap: () {
  //                               //  callback(2);
  //                               Navigator.pop(context);
  //                               Navigator.pushNamed(
  //                                   context, "/${menu.menuItems[i].title}");
  //                             }),
  //                       ),
  //                 ),
  //               ),
  //               MyAboutTile()
  //             ],
  //           )));
  // }

  // Widget myBottomBar(BuildContext context) => BottomAppBar(
  //       clipBehavior: Clip.antiAlias,
  //       elevation: 3,
  //       shape: CircularNotchedRectangle(),
  //       child: Ink(
  //         height: 60.0,
  //         decoration: new BoxDecoration(
  //           // color: Colors.blueAccent,
  //           border: new Border.all(color: Colors.blueAccent, width: 2),
  //           // borderRadius: BorderRadius.all(Radius.circular(7.0)),
  //           // gradient: new LinearGradient(colors: UIData.kitGradients3)
  //         ),
  //         child: new Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             SizedBox(
  //               height: double.infinity,
  //               child: new InkWell(
  //                 radius: 10.0,
  //                 splashColor: Colors.grey,
  //                 onTap: () => _showModalBottomSheet(context, menu),
  //                 child: Center(
  //                   widthFactor: 2,
  //                   child: new Icon(Icons.menu,
  //                       size: 40, color: Colors.blueAccent),
  //                   //  Text(
  //                   //   "ADD TO WISHLIST",
  //                   //   style: new TextStyle(
  //                   //       fontSize: 12.0,
  //                   //       fontWeight: FontWeight.bold,
  //                   //       color: Colors.white),
  //                   // ),
  //                 ),
  //               ),
  //             ),
  //             // new SizedBox(
  //             //   width: 10.0,
  //             // ),
  //             SizedBox(
  //               height: double.infinity,
  //               child: new InkWell(
  //                 onTap: () {},
  //                 // radius: 10.0,
  //                 // splashColor: Colors.grey,
  //                 child: Center(
  //                   widthFactor: 2,
  //                   child: new Icon(Icons.phone,
  //                       size: 37, color: Colors.blueAccent),
  //                 ),
  //               ),
  //             ),

  //             // new SizedBox(
  //             //   width: 120.0,
  //             // ),
  //           ],
  //         ),
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      // appBar: AppBar(
      //   elevation: .4,
      //   toolbarOpacity: .5,
      //   backgroundColor: Colors.white,
      //   // title: Image.asset('assets/icon.png', scale: 5,),
      //   actions: <Widget>[
      //     SizedBox(
      //       width: 5.0,
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       color: Colors.black,
      //       icon: Icon(Icons.search),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       color: Colors.black,
      //       icon: Icon(Icons.exit_to_app),
      //     )
      //   ],
      // ),
      drawer: CommonDrawer(),
      body: bodyData,
      floatingActionButton: showFAB
          ? CustomFloat(
              builder: alerts
                  ? Text(
                      "5",
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    )
                  : null,
              icon: floatingIcon,
              qrCallback: () => callback(),
            )
          : null,
      floatingActionButtonLocation: centerDocked
          ? FloatingActionButtonLocation.endDocked
          : FloatingActionButtonLocation.endFloat,
      // bottomNavigationBar: showBottomNav ? myBottomBar(context) : null,
    );
  }
}
