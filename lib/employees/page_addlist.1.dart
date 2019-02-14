// import 'dart:async';
// import 'package:flutter/services.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:taskist/model/job.dart';
// // import 'package:taskist/model/customer.dart';
// import 'package:taskist/forms/addjob_form.dart';
// import 'package:taskist/forms/lookupCustomer.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:scoped_model/scoped_model.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

// FirebaseUser _currentUser;
// class NewTaskPage extends StatefulWidget {
//   final FirebaseUser user;

//   NewTaskPage({Key key, this.user}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _NewTaskPageState();
// }


// class _NewTaskPageState extends State<NewTaskPage> {
//   TextEditingController listNameController = new TextEditingController();

//   final List<Widget> _children = [
//     LookupCustomerForm(
//       // user: _currentUser,
//     ),
//     NewJobPage(
//       user: _currentUser,
//     ),
//   ];


//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   // Customer _customer;
//   final GlobalKey<FormState> _jobFormKey = GlobalKey<FormState>();

//   Color pickerColor = Color(0xff6633ff);
//   Color currentColor = Color(0xff6633ff);

//   ValueChanged<Color> onColorChanged;
//   String _username;
//   String _password;
//   bool _isLoggedIn = false;
//   bool _saving = false;
//   bool _searching = false;
//   // Job _customer = null;
//   List _phoneList;
//   String _connectionStatus = 'Unknown';
//   final Connectivity _connectivity = new Connectivity();
//   StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   bool _isInAsyncCall = false;

//   Future<Null> initConnectivity() async {
//     String connectionStatus;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       connectionStatus = (await _connectivity.checkConnectivity()).toString();
//     } on PlatformException catch (e) {
//       print(e.toString());
//       connectionStatus = 'Failed to get connectivity.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _connectionStatus = connectionStatus;
//     });
//   }


//   void addToFirebase() async {
//     setState(() {
//       _saving = true;
//     });

//     print(_connectionStatus);

//     if (_connectionStatus == "ConnectivityResult.none") {
//       showInSnackBar("No internet connection currently available");
//       setState(() {
//         _saving = false;
//       });
//     } else {
//       bool isExist = false;

//       QuerySnapshot query =
//           await Firestore.instance.collection(widget.user.uid).getDocuments();

//       query.documents.forEach((doc) {
//         if (listNameController.text.toString() == doc.documentID) {
//           isExist = true;
//         }
//       });

//       if (isExist == false && listNameController.text.isNotEmpty) {
//         await Firestore.instance
//             .collection(widget.user.uid)
//             .document(listNameController.text.toString().trim())
//             .setData({
//           "color": currentColor.value.toString(),
//           "date": DateTime.now().millisecondsSinceEpoch
//         });

//         listNameController.clear();

//         pickerColor = Color(0xff6633ff);
//         currentColor = Color(0xff6633ff);

//         Navigator.of(context).pop();
//       }
//       if (isExist == true) {
//         showInSnackBar("This list already exists");
//         setState(() {
//           _saving = false;
//         });
//       }
//       if (listNameController.text.isEmpty) {
//         showInSnackBar("Please enter a name");
//         setState(() {
//           _saving = false;
//         });
//       }
//     }
//   }


//   bool _isInvalidAsyncUser = false; // managed after response from server
//   bool _isInvalidAsyncPass = false; // managed after response from server

//   // validate user name
//   String _validateUserName(String userName) {
//     if (userName.length < 8) {
//       return 'Username must be at least 8 characters';
//     }

//     if (_isInvalidAsyncUser) {
//       // disable message until after next async call
//       _isInvalidAsyncUser = false;
//       return 'Incorrect user name';
//     }

//     return null;
//   }

//   // validate password
//   String _validatePassword(String password) {
//     if (password.length < 8) {
//       return 'Password must be at least 8 characters';
//     }

//     if (_isInvalidAsyncPass) {
//       // disable message until after next async call
//       _isInvalidAsyncPass = false;
//       return 'Incorrect password';
//     }

//     return null;
//   }
//   // int _currentIndex = 0;
//   // @override
//   // Widget build(BuildContext context) {
    
//   //   return Scaffold(key: _scaffoldKey,  
//   //    body: _children[_currentIndex]
//   //    );
//   // 
//   // changePage(int page) {
//   //   setState(() => _currentIndex = page);
//   // }
//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState?.removeCurrentSnackBar();

//     _scaffoldKey.currentState?.showSnackBar(new SnackBar(
//       content: new Text(value, textAlign: TextAlign.center),
//       backgroundColor: currentColor,
//       duration: Duration(seconds: 3),
//     ));
//   }

//   Container _getToolbar(BuildContext context) {
//     return new Container(
//       margin: new EdgeInsets.only(left: 10.0, top: 40.0),
//       child: new BackButton(color: Colors.black),
//     );
//   }
//   @override
//   void dispose() {
//     _scaffoldKey.currentState?.dispose();
//     _connectivitySubscription?.cancel();
//     super.dispose();
//   }


//   @override
//   void initState() {
//     super.initState();
//     initConnectivity();
//     // _phoneList.forEach((phone) => print(phone));
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       setState(() {
//         _connectionStatus = result.toString();
//       });
//     });
//   }

//    void _submit() {
//     if (_jobFormKey.currentState.validate()) {
//       _jobFormKey.currentState.save();

//       // dismiss keyboard during async call
//       FocusScope.of(context).requestFocus(new FocusNode());

//       // start the modal progress HUD
//       setState(() {
//         _isInAsyncCall = true;
//       });

//       // Simulate a service call
//       Future.delayed(Duration(seconds: 1), () {
//         final _accountUsername = 'username1';
//         final _accountPassword = 'password1';
//         setState(() {
//           if (_username == _accountUsername) {
//             _isInvalidAsyncUser = false;
//             if (_password == _accountPassword) {
//               // username and password are correct
//               _isInvalidAsyncPass = false;
//               _isLoggedIn = true;
//             } else
//               // username is correct, but password is incorrect
//               _isInvalidAsyncPass = true;
//           } else {
//             // incorrect username and have not checked password result
//             _isInvalidAsyncUser = true;
//             // no such user, so no need to trigger async password validator
//             _isInvalidAsyncPass = false;
//           }
//           // stop the modal progress HUD
//           _isInAsyncCall = false;
//         });
//         if (_isLoggedIn)
//           // do something
//           print('done');
//           // widget._onSignIn();
//       });
//     }
//   }



//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: ModalProgressHUD(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             child: buildLoginForm(context),
//           ),
//         ),
//          inAsyncCall: _isInAsyncCall,
//         // demo of some additional parameters
//         opacity: 0.5,
//         progressIndicator: CircularProgressIndicator(),
//       ),
//     );
//   }

//   Widget buildLoginForm(BuildContext context) {
//     final TextTheme textTheme = Theme.of(context).textTheme;
//     // run the validators on reload to process async results
//     _jobFormKey.currentState?.validate();
//     return Form(
//       key: this._jobFormKey,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               key: Key('username'),
//               decoration: InputDecoration(
//                   hintText: 'enter username', labelText: 'User Name'),
//               style: TextStyle(fontSize: 20.0, color: textTheme.button.color),
//               // validator: _validateUserName,
//               onSaved: (value) => _username = value,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               key: Key('password'),
//               obscureText: true,
//               decoration: InputDecoration(
//                   hintText: 'enter password', labelText: 'Password'),
//               style: TextStyle(fontSize: 20.0, color: textTheme.button.color),
//               // validator: _validatePassword,
//               onSaved: (value) => _password = value,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: RaisedButton(
//               onPressed: _submit,
//               child: Text('Login'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: _isLoggedIn
//                 ? Text(
//                     'Login successful!',
//                     key: Key('loggedIn'),
//                     style: TextStyle(fontSize: 20.0),
//                   )
//                 : Text(
//                     'Not logged in',
//                     key: Key('notLoggedIn'),
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//           ),
//         ],
//       ),
//     );
  
//       // ListView(
//       //   children: 
//       //    ScopedModelDescendant<JobModel>(
//       //       builder: (
//       //         BuildContext context,
//       //         Widget child,
//       //         JobModel model,
//       //       ) {
//       //         if (model.customer == null) {
                
//       //           return const LookupCustomerForm();
//       //         } else if (model.customer != null) {
//       //            return const Center(
//       //             child: Text('Welcome'),
//       //           );
//       //           // return  JobDetailPage(
//       //           // );
//       //         } else {
//       //           return const CircularProgressIndicator();
//       //         }
//       //       },
//       //     ),
      
//       // ),
//     // );




    
//   }

// }
 