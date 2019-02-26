import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../model/current_user_model.dart';
import '../../model/serviceItem.dart';
import '../page_orders.dart';

Dio dio = new Dio();

class ServiceItemForm extends StatefulWidget {
  final ServiceItem currentItem;
  ServiceItemForm({Key key, this.currentItem}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServiceItemFormState();
}

class _ServiceItemFormState extends State<ServiceItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> litems = [];
  TextEditingController lengthController = new TextEditingController();
  TextEditingController widthController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _notesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hasUrineKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _lengthKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _widthKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _urineKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _repairKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _hasImage = false;
  ServiceItem currentItem;
  bool isSwitched = false;
  bool _value1 = false;
  bool _value2 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  @override
  void initState() {
    String id = DateTime.now().toString();
    super.initState();
    currentItem = widget.currentItem;
    BaseOptions options = new BaseOptions(
        baseUrl: "https://api.servicemonster.net/v1",
        connectTimeout: 8000,
        receiveTimeout: 5000,
        headers: {
          'Authorization': 'Basic Sk5wbkZOelhxOnltMWM4cGU4QzNPNHM3bDBBVms=',
        });

    dio = new Dio(options);
  }

  _siFab(context, CurrentUserModel currentUserModel) {
    return FloatingActionButton.extended(
        icon: Icon(Icons.save),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            var size = int.tryParse(lengthController.text) *
                int.tryParse(widthController.text);
            // var formatter = new DateFormat('dd-MM-yyyy');
            var formatter = new DateFormat('M/d/yy');

            // currentItem.createdAtPretty = formatter.format(DateTime.now());
            currentItem.primaryPictureUrl = currentItem.pictures[0].url;
            currentItem.quantity = size;
            currentItem.length = int.tryParse(lengthController.text);
            currentItem.width = int.tryParse(widthController.text);
            var now = new DateTime.now();
            String formatted = formatter.format(now);
            currentItem.prettyCreatedAt = formatted;
            currentItem.hasUrine = _value1;
            currentItem.needsRepair = _value2;
            Duration dur = new Duration(days: 21);
            currentItem.createdById = currentUserModel.firebaseUser.uid;
            var due = now.add(dur);
            String dueFormatted = formatter.format(due);
            currentItem.prettyDueAt = dueFormatted;
            // currentItem.customerPhone =
            currentItem.status = 'Not Yet Started';
            currentItem.priority = 'Medium';
            currentItem.isDone = false;
            // currentItem.intake_notes = "Rug is highly urinated";
            currentItem.needsRepair = false;
            try {
              Firestore.instance
                  .collection('workorders')
                  .document(currentItem.workorderId)
                  .collection('serviceItems')
                  .document()
                  .setData(ServiceItemSerializer().toMap(currentItem));
            } catch (e) {
              print(e);
            }
// https://script.google.com/macros/s/AKfycbyahgWvy7GHdx3BADRiAVVTkQtuv7ET7ss1abd1RPS62pE6VlM/exec
            var map = ServiceItemSerializer().toMap(currentItem);
            var url =
                'https://script.google.com/macros/s/AKfycbyahgWvy7GHdx3BADRiAVVTkQtuv7ET7ss1abd1RPS62pE6VlM/exec ';
            var response =
                await dio.get(url, queryParameters: {"parameter": "ghgfhgfhg"});
            print(response);
            Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                content: Text(currentItem.id.toString() +
                    ' ' +
                    currentItem.workorderId)));
            //TODO put me back
            currentItem = null;

            https: //script.google.com/macros/s/AKfycbwrOe9OOwgWM5xrIB2c1q1eEsnYsDlictBUohd7XfKXKt-OtWjy/exec
            Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new RugPage()));
          }
        },
        label: new Text('Finish'));
  }

  @override
  Widget build(BuildContext context) {
    //     key: _scaffoldKey,
    var currentUserModel =
        ScopedModel.of<CurrentUserModel>(context, rebuildOnChange: true);
    return Scaffold(
        body: Stack(children: <Widget>[
          _getToolbar(context),
          Padding(
            padding: EdgeInsets.only(top: 53.0),
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
                          'ShopItem',
                          style: new TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Form',
                          style:
                              new TextStyle(fontSize: 28.0, color: Colors.grey),
                        ),
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
            padding: EdgeInsets.only(top: 87.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 0,
                  ),
                ),
                Text(
                  '[tag: ' + currentItem.tagId + ']',
                  style: new TextStyle(
                      fontSize: 12.0, color: Colors.blue.shade900),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: // We'll build this out in the next steps!

                Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 190.0, left: 18, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // formBuilder(),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                            leading: _buildCardSettingsInt_Length(),
                            // leading: Image.file(snapshot.data),
                            onTap: () {/* react to the tile being tapped */}),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                            leading: _buildCardSettingsInt_Width(),
                            // leading: Image.file(snapshot.data),
                            onTap: () {/* react to the tile being tapped */}),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 40.0, right: 18, left: 110),
                child: Transform.scale(
                    scale: 1.4,
                    child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Checkbox(
                              key: _urineKey,
                              value: _value1,
                              onChanged: (bool v) {
                                _value1Changed(v);
                              },
                            ),
                            Text("Urine"),
                          ]),
                          Row(children: <Widget>[
                            Checkbox(
                              value: _value2,
                              key: _repairKey,
                              onChanged: (bool v) {
                                _value2Changed(v);
                              },
                            ),
                            Text('Repair'),
                          ])
                        ])),
              ),
              // ])

              Padding(
                padding: EdgeInsets.only(top: 100.0, right: 18, left: 18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                          leading: _buildCardSettingsInt_Notes(),
                          // leading: Image.file(snapshot.data),
                          onTap: () {
                            /* react to the tile being tapped */
                          }),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ]),
        floatingActionButton: _siFab(context, currentUserModel),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 30, left: 20.0, right: 12.0),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        new Image(
            width: 35.0,
            height: 35.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/icon.png')),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(new PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new RugPage()));
            },
            child: new Icon(
              Icons.close,
              size: 35.0,
              color: (currentItem.isDone != null && currentItem.isDone == true)
                  ? Colors.grey
                  : Colors.green,
            )),
      ]),
    );
  }

  TextFormField _buildCardSettingsInt_Notes() {
    return new TextFormField(
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          filled: true,
          // icon: Icon(Icons.phone),
          labelText: 'Notes',
          suffixIcon: new FlatButton(
              onPressed: () {
                notesController.clear();
              },
              child: new Icon(Icons.clear))),
      // keyboardType: TextInputType.phone,
      // initialValue: '(903) 926-9768',
      // onSaved: (String value) {
      //   _phoneNumber = value.; },
      // validator: _validatePhoneNumber,
      maxLength: 114,
      // initialValue: '(903) ',
      controller: notesController,
      inputFormatters: <TextInputFormatter>[
        // WhitelistingTextInputFormatter.digitsOnly,
        // Fit the validating format.
        // _phoneNumberFormatter,
      ],
      autofocus: true,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 5,

      textCapitalization: TextCapitalization.sentences,
    );
  }

  TextFormField _buildCardSettingsInt_Length() {
    return new TextFormField(
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          filled: true,
          // icon: Icon(Icons.phone),
          labelText: 'Length',
          suffixIcon: new FlatButton(
              onPressed: () {
                lengthController.clear();
              },
              child: new Icon(Icons.clear))),
      keyboardType: TextInputType.phone,

      // initialValue: '(903) 926-9768',
      // onSaved: (String value) {
      //   _phoneNumber = value.; },
      // validator: _validatePhoneNumber,
      maxLength: 14,

      // initialValue: '(903) ',
      controller: lengthController,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      // },
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        // Fit the validating format.
        // _phoneNumberFormatter,
      ],
      autofocus: true,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      key: _lengthKey,
      // textCapitalization: TextCapitalization.none,
    );
  }

  TextFormField _buildCardSettingsInt_Width() {
    return new TextFormField(
      decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          filled: true,
          // icon: Icon(Icons.phone),
          labelText: 'Width',
          suffixIcon: new FlatButton(
              onPressed: () {
                widthController.clear();
              },
              child: new Icon(Icons.clear))),
      keyboardType: TextInputType.phone,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      // },
      key: _widthKey,
      // initialValue: '(903) 926-9768',
      // onSaved: (String value) {
      //   _phoneNumber = value.; },
      // validator: _validatePhoneNumber,
      maxLength: 14,
      // initialValue: '(903) ',
      controller: widthController,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        // Fit the validating format.
        // _phoneNumberFormatter,
      ],
      autofocus: true,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),

      // textCapitalization: TextCapitalization.none,
    );
  }
}
