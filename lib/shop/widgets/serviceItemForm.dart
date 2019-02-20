import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import '../../model/serviceItem.dart';
import 'package:taskist/model/workorder.dart';
import '../widgets/imagesListScreen.dart';
import '../widgets/customerCard.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../page_orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  bool _autoValidate = false;
  bool _hasImage = false;
  ServiceItem currentItem;

  @override
  void initState() {
    String id = DateTime.now().toString();
    super.initState();
    currentItem = widget.currentItem;
  }

  _siFab(context) {
    return FloatingActionButton.extended(
        icon: Icon(Icons.save),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            var size = int.tryParse(lengthController.text) *
                int.tryParse(widthController.text);
            currentItem.quantity = size;
            currentItem.length = int.tryParse(lengthController.text);
            currentItem.width = int.tryParse(widthController.text);
            var now = new DateTime.now();
            var formatter = new DateFormat('M/d/yy');
            String formatted = formatter.format(now);
            currentItem.prettyCreatedAt = formatted;
            Duration dur = new Duration(days: 21);
            var due = now.add(dur);
            String dueFormatted = formatter.format(due);
            currentItem.prettyDueAt = dueFormatted;
            // currentItem.customerPhone =
            currentItem.status = 'Not Yet Started';
            currentItem.priority = 'Medium';
            currentItem.intake_notes = "Rug is highly urinated";
            currentItem.needsRepair = 'FALSE';
            print(currentItem.prettyDueAt);
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
            // currentItem = null;

            // Navigator.of(context).push(new PageRouteBuilder(
            //     pageBuilder: (_, __, ___) => new RugPage()));

            Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                content: Text(currentItem.id.toString() +
                    ' ' +
                    currentItem.workorderId)));
          }
        },
        label: new Text('Finish'));
  }

  @override
  Widget build(BuildContext context) {
    //     key: _scaffoldKey,
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
                  padding: EdgeInsets.only(top: 170.0, left: 18, right: 18),
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
        floatingActionButton: _siFab(context),
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

  saveItem(b) async {}
  // Padding _getToolbar(BuildContext context) {
  //   return new Padding(
  //     padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
  //     child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       new Image(
  //           width: 40.0,
  //           height: 40.0,
  //           fit: BoxFit.cover,
  //           image: new AssetImage('assets/icon.png')),
  //     ]),
  //   );
  // }

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
    // return CardSettingsInt(
    //   key: _sizeKey,
    //   label: 'Leght',
    //   unitLabel: 'feet',
    //   initialValue: _currentItem.length,
    //   onSaved: (value) => _currentItem.length = value,
    //   onChanged: (value) => _showSnackBar('Height', value),
    // );
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
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
    // return CardSettingsInt(
    //   key: _sizeKey,
    //   label: 'Leght',
    //   unitLabel: 'feet',
    //   initialValue: _currentItem.length,
    //   onSaved: (value) => _currentItem.length = value,
    //   onChanged: (value) => _showSnackBar('Height', value),
    // );
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
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

  // CardSettingsButton _buildCardSettingsButton_Save() {
  //   return CardSettingsButton(
  //     label: 'SAVE',
  //     onPressed: _savePressed,
  //   );
  // }

  // Future _savePressed() async {
  //   final form = _formKey.currentState;

  //   if (form.validate()) {
  //     form.save();

  //     // showResults(context, _serviceItemList);
  //   } else {
  //     // setState(() => _autoValidate = true);
  //   }
  // }

  // void _showSnackBar(String label, dynamic value) {
  //   // _scaffoldKey.currentState.removeCurrentSnackBar();
  //   // _scaffoldKey.currentState.showSnackBar(
  //   //   SnackBar(
  //   //     content: Text(label + ' = ' + value.toString()),
  //   //   ),
  //   // );
  // }
  // void _resetPressed() {
  //   _formKey.currentState.reset();
  // }
}
