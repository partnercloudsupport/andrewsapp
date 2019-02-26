import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskist/model/account.dart';
import 'package:taskist/shop/page_addServiceItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskist/model/workorder.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/model/serviceItem.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
    baseUrl: "https://api.servicemonster.net/v1",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Authorization': 'Basic Sk5wbkZOelhxOnltMWM4cGU4QzNPNHM3bDBBVms=',
    });

Dio dio = new Dio(options);

class NewCustomerForm extends StatelessWidget {
  final String phoneNumber;
  // final List serviceItemsList;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  NewCustomerForm(
    this.phoneNumber,
    // @required this.serviceItemsList,
  );

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: _formKey,
        child: new Stack(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
            child: new Column(
              children: <Widget>[
                new TextFormField(
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      filled: true,
                      icon: Icon(Icons.person_add),
                      labelText: 'First Name',
                      suffixIcon: new FlatButton(
                          onPressed: () {
                            firstNameController.clear();
                          },
                          child: new Icon(Icons.clear))),
                  keyboardType: TextInputType.text,
                  controller: firstNameController,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: new TextFormField(
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        filled: true,
                        icon: Icon(Icons.person_add),
                        labelText: 'Last Name',
                        suffixIcon: new FlatButton(
                            onPressed: () {
                              lastNameController.clear();
                            },
                            child: new Icon(Icons.clear))),
                    keyboardType: TextInputType.text,
                    controller: lastNameController,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: new Column(
                    children: <Widget>[
                      new RaisedButton(
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        elevation: 4.0,
                        splashColor: Colors.deepPurple,
                        // onPressed: _saving ? null : searchCustomer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class LookupCustomerForm extends StatefulWidget {
  final CustomerCallback onCustomerSet;

  const LookupCustomerForm({Key key, this.onCustomerSet}) : super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<LookupCustomerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController listPhoneController = new TextEditingController();

  final _UsNumberTextInputFormatter _phoneNumberFormatter =
      _UsNumberTextInputFormatter();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final Map<String, String> _formData = <String, String>{
    'nickname': '',
    'fullName': '',
    'photoUrl': '',
  };
  bool _foundCustomer = false;
  bool _saving = false;

  void searchCustomer() async {
    Account _customer;

    print(listPhoneController.text.length);
    if (listPhoneController.text.length != 14) {
      listPhoneController.text == '';
      // Navigator.of(context).pop();
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid number'),
            );
          });
    }

    setState(() {
      _saving = true;
    });
    var smResponse = await dio.get("/accounts/", queryParameters: {
      "wValue": listPhoneController.text,
      "wField": "phone1",
      "wOperator": "like"
    });
    var data;
    if (smResponse.data['items'].length < 1) {
      smResponse = await dio.get("/accounts/", queryParameters: {
        "wValue": listPhoneController.text,
        "wField": "phone2",
        "wOperator": "like"
      });

      if (smResponse.data['items'].length < 1) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Cannot find an existing customer"),
              content: Container(
                  child:
                      Container(child: Text('Create new one or try again?'))),
              contentPadding: EdgeInsets.all(20),
              actions: <Widget>[
                RaisedButton(
                  child: Text('New', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      _saving = false;
                      listPhoneController.text = '';
                    });

                    Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            new NewCustomerForm(listPhoneController.text)));
                  },
                ),
                Container(width: 10),
                RaisedButton(
                  child:
                      Text('Try Again', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      _saving = false;
                      listPhoneController.text = '';
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      }
    } else {
      if (smResponse.data['items'].length > 1) {
        List l = new List();
        String list = "";
        for (var i = 0; i < smResponse.data['items'].length; i++) {
          var x = smResponse.data['items'][i];
          Account c = AccountSerializer().fromMap(x);
          print(c.toString());
          l.add(c.accountName);
          list += c.accountName;
          list += ", ";
        }
        print(l.toString());
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Accounts with this phone number: " + list),
              content: Container(
                  child: Container(
                      child: Text('Clean up in SM before using this number.'))),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    setState(() {
                      _saving = false;
                      listPhoneController.text = '';
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      data = smResponse.data['items'][0];
    }

    // // print(_data['accountName']);

    // print(data['phone1']);
    // print(data['phone2']);
    // print(data['phone3']);
    List<String> phones = List<String>();
    if (data['phone1'] != null) {
      phones.add(data['phone1']);
    }
    if (data['phone2'] != null) {
      phones.add(data['phone2']);
    }
    if (data['phone3'] != null) {
      phones.add(data['phone3']);
    }
    data['phones'] = phones;
    data['smId'] = data['accountID'];

    if (smResponse.data['items'].length == 1) {
      Account account = AccountSerializer().fromMap(data);

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(account.firstName + ' ' + account.lastName),
            content:
                Container(child: Container(child: Text('Is this correct?'))),
            actions: <Widget>[
              FlatButton(
                color: Colors.green,
                child: Text('Yes'),
                onPressed: () {
                  _setFoundCustomer(true);
                  _submit(account);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('No'),
                color: Colors.redAccent,
                onPressed: () {
                  setState(() {
                    _saving = false;
                    listPhoneController.text = '';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if (data.length > 1) {}

    setState(() {
      _saving = false;
    });
    // QuerySnapshot querySnapshot = await Firestore.instance
    //     .collection("accounts_dev")
    //     // .where('phones', arrayContains: listPhoneController.text)
    //     .where('phones', arrayContains: '(111) 111-1111')
    //     .getDocuments();
    // try {
    //   if (querySnapshot.documents.length == 1) {
    //     print(querySnapshot.documents.first.documentID);

    //     // if(c2.id == null){
    //     //   c2.id = querySnapshot.documents.first.documentID;
    //     // }
    //     // Account c = new Account.fromJson(querySnapshot.documents.first.data);
    //     Account c =
    //         // AccountSerializer.fromMap(querySnapshot.documents.first.data);
    //         AccountSerializer().fromMap(querySnapshot.documents.first.data);
    //     try {
    //       String name = c.lastName + ', ' + c.firstName;
    //       var smResponse = await dio.get("/accounts/", queryParameters: {
    //         "wValue": name,
    //         "wField": "accountName",
    //         "wOperator": "like"
    //       });

    //       var data = smResponse.data['items'][0];
    //       // data.smId = response.data['items'][0].accountId;
    //       // querySnapshot.documents.first.data['smId'] = response.data['items'][0]['accountID'];
    //       c = AccountSerializer().fromMap(querySnapshot.documents.first.data);
    //       c.smId = smResponse.data['items'][0]['accountID'];
    //       print(c);
    //     } catch (e) {
    //       print(e);
    //     }

    //     return showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text(c.firstName + ' ' + c.lastName),
    //           content:
    //               Container(child: Container(child: Text('Is this correct?'))),
    //           actions: <Widget>[
    //             FlatButton(
    //               child: Text('Yes'),
    //               onPressed: () {
    //                 _setFoundCustomer(true);
    //                 _submit(c);
    //                 Navigator.of(context).pop();
    //               },
    //             ),
    //             FlatButton(
    //               child: Text('No'),
    //               onPressed: () {
    //                 setState(() {
    //                   // listPhoneController.clear();
    //                   // listPhoneController.text = '(903) ';
    //                   _saving = false;
    //                 });
    //                 Navigator.of(context).pop();
    //               },
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   } else {
    //     if (querySnapshot.documents.length > 1) {
    //       try {
    //         // Customer c = new Customer.fromJson(querySnapshot.documents.first.data);
    //         List l = new List();
    //         String list = "";
    //         for (var i = 0; i < querySnapshot.documents.length; i++) {
    //           var x = querySnapshot.documents[i];
    //           Account c = AccountSerializer().fromMap(x.data);
    //           print(c.toString());
    //           l.add(c.accountName);
    //           list += c.accountName;
    //           list += ", ";
    //         }
    //         print(l.toString());
    //         return showDialog(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return AlertDialog(
    //               title: Text("Accounts with this phone number: " + list),
    //               content: Container(
    //                   child: Container(
    //                       child: Text(
    //                           'Clean up in SM before using this number.'))),
    //               actions: <Widget>[
    //                 FlatButton(
    //                   child: Text('Ok'),
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                 ),
    //               ],
    //             );
    //           },
    //         );
    //       } catch (e) {
    //         print(e);
    //       }
    //     } else {
    //       Scaffold.of(context).showSnackBar(new SnackBar(
    //           content: new Text("Customer not found"),
    //           backgroundColor: Colors.blue,
    //           duration: Duration(seconds: 3)));
    //     }
    //   }
    // } catch (e) {
    //   print(e);
    //   //  const SnackBar snackBar = SnackBar(content: Text('Form submitted'));
    //   //  Job.of(context).register(_formData);
    //   // Scaffold.of(context).showSnackBar(snackBar);
    //   _scaffoldKey.currentState?.removeCurrentSnackBar();
    //   Scaffold.of(context).showSnackBar(new SnackBar(
    //       content: new Text("Customer not foundy"),
    //       backgroundColor: Colors.blue,
    //       duration: Duration(seconds: 3)));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: _formKey,
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
                            flex: 3,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Customer',
                                  style: new TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Lookup',
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
                    padding:
                        EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                    child: new Column(
                      children: <Widget>[
                        new TextFormField(
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              filled: true,
                              icon: Icon(Icons.phone),
                              labelText: 'Phone Number *',
                              suffixIcon: new FlatButton(
                                  onPressed: () {
                                    listPhoneController.clear();
                                  },
                                  child: new Icon(Icons.clear))),
                          keyboardType: TextInputType.phone,
                          // initialValue: '(903) 926-9768',
                          // onSaved: (String value) {
                          //   _phoneNumber = value.; },
                          validator: _validatePhoneNumber,
                          maxLength: 14,
                          // initialValue: '(903) ',
                          controller: listPhoneController,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                            // Fit the validating format.
                            _phoneNumberFormatter,
                          ],
                          autofocus: true,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),

                          // textCapitalization: TextCapitalization.none,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: new Column(
                            children: <Widget>[
                              new RaisedButton(
                                child: const Text(
                                  'Lookup',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                                elevation: 4.0,
                                splashColor: Colors.deepPurple,
                                onPressed: _saving ? null : searchCustomer,
                              ),
                            ],
                          ),
                        ),
                        //                Row(
                        //   children: <Widget>[
                        //     const Spacer(),
                        //     OutlineButton(
                        //       highlightedBorderColor: Colors.black,
                        //       onPressed: _submittable() ? _submit : null,
                        //       child: const Text('Register'),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )); // inAsyncCall: _saving);
  }

  bool _submittable() {
    return _foundCustomer;
  }

  @override
  void initState() {
    super.initState();

// Set default configs
// or new Dio with a Options instance.
    BaseOptions options = new BaseOptions(
        baseUrl: "https://api.servicemonster.net/v1",
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          'Authorization': 'Basic Sk5wbkZOelhxOnltMWM4cGU4QzNPNHM3bDBBVms=',
        });

    dio = new Dio(options);
  }

  void _submit(c) {
    widget.onCustomerSet(c);

    _formKey.currentState.save();
    setState(() {
      _saving = false;
    });

    const SnackBar snackBar = SnackBar(content: Text('Form submitted'));
    //  Job.of(context).register(_formData);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  String _validatePhoneNumber(String value) {
    // _formWasEdited = true;
    final RegExp phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '(###) ###-#### - Enter a US phone number.';
    return null;
  }

  void _setFoundCustomer(bool newValue) {
    setState(() {
      _foundCustomer = newValue;
    });
  }
}

typedef CustomerCallback = void Function(Account customer);
