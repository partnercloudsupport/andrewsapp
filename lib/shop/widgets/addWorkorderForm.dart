import 'dart:async';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:taskist/model/workorder.dart';
import 'package:taskist/model/account.dart';
import 'package:taskist/shop/page_addServiceItem.dart';

import 'package:connectivity/connectivity.dart';

Dio dio;

class AddWorkorderForm extends StatefulWidget {
  final FirebaseUser user;
  final Workorder newJob;
  AddWorkorderForm({Key key, this.user, this.newJob}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewJobPageState();
}

class _NewJobPageState extends State<AddWorkorderForm> {
  TextEditingController jobNotesController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _saving = false;

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<Null> initConnectivity() async {
    String connectionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });
  }

  void addToFirebase() async {
    setState(() {
      _saving = true;
    });

    print(_connectionStatus);

    if (_connectionStatus == "ConnectivityResult.none") {
      showInSnackBar("No internet connection currently available");
      setState(() {
        _saving = false;
      });
    } else {}
    bool isExist = false;
    var smOrderId;
    try {
      var response = await dio.post("/orders", data: {
        "accountID": widget.newJob.customer.smId,
// 	"siteID":"119ace88-a1f7-11e2-b2c6-00155d467ded"
      });

      smOrderId = response.data['recordID'];
    } catch (e) {
      print(e);
    }

    if (smOrderId == null) {
      showInSnackBar('bad shit');
      return;
    }
    var workorder;
    var customerMap =
        // AccountSerializer.fromMap(querySnapshot.documents.first.data);
        AccountSerializer().toMap(widget.newJob.customer);
//TODO fix uid setting
    var newDoc;
    int now = DateTime.now().millisecondsSinceEpoch;

    try {
      newDoc = await Firestore.instance.collection("workorders").add({
        "notes": jobNotesController.text.toString().trim(),
        "date": DateTime.now().millisecondsSinceEpoch.toString(),
        "customer": customerMap,
        "createdBy": widget.user.uid,
        "isDone": false,
        "createdAt": now,
        "status": "Active",
        "serviceItems": [],
        "smOrderId": smOrderId.toString()
      });
      print(newDoc.documentID);
    } catch (e) {
      print(e);
      setState(() {
        _saving = false;
      });
    }
    jobNotesController.clear();
    setState(() {
      _saving = false;
    });
    workorder = await Firestore.instance
        .collection("workorders")
        .document(newDoc.documentID)
        .get();

    Workorder w = WorkorderSerializer().fromMap(workorder.data);
    w.id = newDoc.documentID;

    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new AddServiceItems(
              user: widget.user,
              currentJob: w,
            )));
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // key: _scaffoldKey,
    // body:
    return ModalProgressHUD(
        child: new Stack(
          children: <Widget>[
            // _getToolbar(context),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
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
                                  'New',
                                  style: new TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Workorder',
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
                    padding: EdgeInsets.only(top: 50.0, left: 0.0, right: 0.0),
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      widget.newJob.customer.firstName +
                                          ' ' +
                                          widget.newJob.customer.lastName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(widget.newJob.customer.phones.first
                                        .toString()),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        // Text(  widget.newJob.customer.address.streetAddress + widget.newJob.customer.address.city + widget.newJob.customer.address.state + widget.newJob.customer.address.zipcode),
                                        (widget.newJob.customer.address1 !=
                                                null)
                                            ? Text(widget
                                                    .newJob.customer.address1 +
                                                ' ' +
                                                widget.newJob.customer.city +
                                                ', ' +
                                                widget.newJob.customer.state +
                                                ' ' +
                                                widget.newJob.customer.zip)
                                            : Text(
                                                "Due 02/25/2019",
                                                style: TextStyle(
                                                    color:
                                                        Colors.orange.shade800,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15.0),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: new Column(
                      children: <Widget>[
                        new TextFormField(
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              labelText: "Notes",
                              contentPadding: EdgeInsets.only(
                                  left: 16.0,
                                  top: 20.0,
                                  right: 16.0,
                                  bottom: 5.0)),
                          controller: jobNotesController,
                          autofocus: true,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 20,
                        ),
                        new Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: new Column(
                      children: <Widget>[
                        (_saving != true)
                            ? new RaisedButton(
                                child: new Text(
                                  _saving ? 'Wait...' : 'Create Order',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                                elevation: 4.0,
                                splashColor: Colors.deepPurple,
                                onPressed: addToFirebase,
                              )
                            : CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        inAsyncCall: _saving);
    // );
  }

  @override
  void dispose() {
    // _scaffoldKey.currentState?.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    BaseOptions options = new BaseOptions(
        baseUrl: "https://api.servicemonster.net/v1",
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          'Authorization': 'Basic Sk5wbkZOelhxOnltMWM4cGU4QzNPNHM3bDBBVms=',
        });
    dio = new Dio(options);

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result.toString();
      });
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.removeCurrentSnackBar();

    _scaffoldKey.currentState?.showSnackBar(new SnackBar(
      content: new Text(value, textAlign: TextAlign.center),
      duration: Duration(seconds: 3),
    ));
  }
}
