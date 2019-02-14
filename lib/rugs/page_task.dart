import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskist/model/element.dart';
import 'package:taskist/rugs/models/job.dart';
import 'package:taskist/rugs/models/serviceItem.dart';
import 'package:taskist/rugs/page_detail.dart';
import 'package:taskist/common/common_scaffold.dart';
import 'package:dio/dio.dart';
import 'page_addlist.dart';
import 'package:taskist/rugs/widgets/jobCard.dart';

Dio dio;

class RugPage extends StatefulWidget {
  final FirebaseUser user;

  RugPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<RugPage>
    with SingleTickerProviderStateMixin {
  int index = 1;
final _scaffoldState = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
           // backGroundColor: Colors.grey.shade100,
        backGroundColor: Colors.white,
        actionFirstIcon: null,
        appTitle: "Product Detail",
        showFAB: true,
        scaffoldKey: _scaffoldState,
        showDrawer: false,
        centerDocked: true,
        floatingIcon: Icons.add,
        // bodyData: bodyData(productBloc.productItems),
    showBottomNav: true,
      bodyData: ListView(
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
                              'Rug',
                              style: new TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'List',
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
                      child: Text('Add Job',
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
                        // .collection(widget.user.uid)
                        .collection("workorders")
                        .orderBy("date", descending: true)
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
                        children: getJobs(snapshot) as List<Widget>,
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

  getJobs(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<JobModel> jobList = new List();
    JobModel c;
    snapshot.data.documents.map<List>((f) {
      c = new JobModel.fromSnapshot(f);
      jobList.add(c);
    }).toList();
    return new List.generate(jobList.length, (int index) {
      return new GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailPage(
                    user: widget.user,
                    // i: index,
                    job: jobList.elementAt(index),
                    // color: "0xFFFFFE1",
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
        child: new JobModelCard(jobList.elementAt(index)),
      );
    });
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
            image: new AssetImage('assets/icon.png')),
      ]),
    );
  }
}
