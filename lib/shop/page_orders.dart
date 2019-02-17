import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskist/model/workorder.dart';
import 'package:taskist/model/serviceItem.dart';
import 'package:taskist/shop/page_detail.dart';
import 'package:taskist/common/common_scaffold.dart';
import 'page_addWorkorder.dart';
import 'package:taskist/shop/widgets/workorderCard.dart';
import 'package:taskist/shop/shopService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RugPage extends StatefulWidget {
  final FirebaseUser user;

  RugPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<RugPage>
    with SingleTickerProviderStateMixin {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _getToolbar(context),
          new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              'Shop',
                              style: new TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Orders',
                              style: new TextStyle(
                                  fontSize: 28.0, color: Colors.grey),
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
                padding: EdgeInsets.only(top: 50.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: new IconButton(
                        icon: new Icon(Icons.add),
                        onPressed: _addTaskPressed,
                        iconSize: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Add Workorder',
                          style: TextStyle(color: Colors.black45)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Container(
              height: 360.0,
              padding: EdgeInsets.only(bottom: 25.0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                },
                child: new StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('workorders')
                        // .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return new Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ));
                      return new ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        scrollDirection: Axis.horizontal,
                        children: getExpenseItems(snapshot),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<ServiceItem> listElement = new List(), listElement2;
    Map<Workorder, List<ServiceItem>> userMap = new Map();
    List<Workorder> orderList = new List();
    Workorder workorder = new Workorder();
    List<String> cardColor = new List();

    snapshot.data.documents.forEach((f) {
      Workorder thisOrder = WorkorderSerializer().fromMap(f.data);
      thisOrder.id = f.documentID;
      print(thisOrder.id);
      orderList.add(thisOrder);
    });

    if (true) {
      cardColor.clear();

      snapshot.data.documents.map<List>((f) {
        String color;
        f.data.forEach((a, b) {
          // if (b.runtimeType == bool) {
          // listElement.add(new ServiceItem());
          // }
          // if (b.runtimeType == String && a == "color") {
          //   color = b;
          // }
        });
        listElement2 = new List<ServiceItem>.from(listElement);
        for (int i = 0; i < listElement2.length; i++) {
          if (listElement2.elementAt(i).isDone == false) {
            userMap[WorkorderSerializer().fromMap(f.data)] = listElement2;
            cardColor.add(color);
            break;
          }
        }
        if (listElement2.length == 0) {
          userMap[WorkorderSerializer().fromMap(f.data)] = listElement2;
          cardColor.add(color);
        }
        listElement.clear();
      }).toList();

      return new List.generate(orderList.length, (int index) {
        return new GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new DetailPage(
                      user: widget.user,
                      // currentWorkorder: userMap.keys.elementAt(index),
                      currentWorkorder: orderList.elementAt(index),
                      // i: index,
                      // currentList: userMap,
                      // color: cardColor.elementAt(index),
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        new ScaleTransition(
                          scale: new Tween<double>(
                            begin: 1.5,
                            end: 1.0,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Interval(
                                0.50,
                                1.00,
                                curve: Curves.linear,
                              ),
                            ),
                          ),
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Interval(
                                  0.00,
                                  0.50,
                                  curve: Curves.linear,
                                ),
                              ),
                            ),
                            child: child,
                          ),
                        ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            // color: Color(int.parse(cardColor.elementAt(index))),
            color: Colors.blue,
            child: new Container(
              width: 220.0,
              //height: 100.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                      child: Container(
                        child: Text(
                          //  userMap.values.elementAt(index).length,
                          userMap.keys.elementAt(index).customer.lastName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 50.0),
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 220.0,
                            child: ListView.builder(
                                //physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    userMap.values.elementAt(index).length,
                                itemBuilder: (BuildContext ctxt, int i) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        userMap.values
                                                .elementAt(index)
                                                .elementAt(i)
                                                .isDone
                                            ? FontAwesomeIcons.checkCircle
                                            : FontAwesomeIcons.circle,
                                        color: userMap.values
                                                .elementAt(index)
                                                .elementAt(i)
                                                .isDone
                                            ? Colors.white70
                                            : Colors.white,
                                        size: 14.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                      ),
                                      Flexible(
                                        child: Text(
                                          userMap.values
                                              .elementAt(index)
                                              .elementAt(i)
                                              .serviceName,
                                          style: userMap.values
                                                  .elementAt(index)
                                                  .elementAt(i)
                                                  .isDone
                                              ? TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.white70,
                                                  fontSize: 17.0,
                                                )
                                              : TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _addTaskPressed() async {
    Navigator.of(context).push(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new NewTaskPage(
              user: widget.user,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new ScaleTransition(
              scale: new Tween<double>(
                begin: 1.5,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.50,
                    1.00,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.00,
                      0.50,
                      curve: Curves.linear,
                    ),
                  ),
                ),
                child: child,
              ),
            ),
      ),
    );
    //Navigator.of(context).pushNamed('/new');
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Image(
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/list.png')),
      ]),
    );
  }
}
// class RugPage extends StatefulWidget {
//   final FirebaseUser user;

//   RugPage({Key key, this.user}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<RugPage>
//     with SingleTickerProviderStateMixin {
//   int index = 1;
//   final _scaffoldState = GlobalKey<ScaffoldState>();
//   ShopService shopService = new ShopService();
//   @override
//   Widget build(BuildContext context) {
//     return CommonScaffold(
//         backGroundColor: Colors.white,
//         actionFirstIcon: null,
//         appTitle: "Product Detail",
//         showFAB: true,
//         scaffoldKey: _scaffoldState,
//         showDrawer: false,
//         centerDocked: true,
//         floatingIcon: Icons.add,
//         showBottomNav: true,
//         bodyData: Center(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 50.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           color: Colors.grey,
//                           height: 1.5,
//                         ),
//                       ),
//                       Expanded(
//                           flex: 2,
//                           child: new Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text(
//                                 'Rug',
//                                 style: new TextStyle(
//                                     fontSize: 30.0,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 'List',
//                                 style: new TextStyle(
//                                     fontSize: 28.0, color: Colors.grey),
//                               )
//                             ],
//                           )),
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           color: Colors.grey,
//                           height: 1.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: 50.0,
//                   ),
//                   child: new Column(
//                     children: <Widget>[
//                       new Container(
//                         width: 50.0,
//                         height: 50.0,
//                         decoration: new BoxDecoration(
//                             border: new Border.all(color: Colors.black38),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(7.0))),
//                         child: new IconButton(
//                           icon: new Icon(Icons.add),
//                           onPressed: _addTaskPressed,
//                           iconSize: 30.0,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10.0),
//                         child: Text('Add Job',
//                             style: TextStyle(color: Colors.black45)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: StreamBuilder<List<Workorder>>(
//                     stream: shopService.getWorkorders(),
//                     builder: (context, snapShot) {
//                       if (!snapShot.hasData)
//                         return new Center(
//                             child: CircularProgressIndicator(
//                           backgroundColor: Colors.blue,
//                         ));

//                       return ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           padding: EdgeInsets.only(left: 40.0, right: 40.0),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: snapShot.data.length,
//                           itemBuilder: (context, index) {
//                             var item = snapShot.data[index];
//                             return WorkorderCard(item);
//                             // return ListTile(
//                             //   title: Text('${item.fbId}   (lat:${item.fbId})'),
//                             //   subtitle: Text('distance: ${item.id}'),
//                             // );
//                           });
//                     },
//                   ),
//                 ),
//               ]),
//         ));
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   void _addTaskPressed() async {
//     Navigator.of(context).push(
//       new PageRouteBuilder(
//         pageBuilder: (_, __, ___) => new NewTaskPage(
//               user: widget.user,
//             ),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//             new ScaleTransition(
//               scale: new Tween<double>(
//                 begin: 1.5,
//                 end: 1.0,
//               ).animate(
//                 CurvedAnimation(
//                   parent: animation,
//                   curve: Interval(
//                     0.50,
//                     1.00,
//                     curve: Curves.linear,
//                   ),
//                 ),
//               ),
//               child: ScaleTransition(
//                 scale: Tween<double>(
//                   begin: 0.0,
//                   end: 1.0,
//                 ).animate(
//                   CurvedAnimation(
//                     parent: animation,
//                     curve: Interval(
//                       0.00,
//                       0.50,
//                       curve: Curves.linear,
//                     ),
//                   ),
//                 ),
//                 child: child,
//               ),
//             ),
//       ),
//     );
//     //Navigator.of(context).pushNamed('/new');
//   }

//   Padding _getToolbar(BuildContext context) {
//     return new Padding(
//       padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
//       child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         new Image(
//             width: 40.0,
//             height: 40.0,
//             fit: BoxFit.cover,
//             image: new AssetImage('assets/icon.png')),
//       ]),
//     );
//   }
// }
