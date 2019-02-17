import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskist/employees/page_employees.dart';
import 'package:taskist/root_page.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

final _credentials = new ServiceAccountCredentials.fromJson(r'''
{
  "private_key_id": "080257ff1b260cd9b859dad2c4d45939e51d733e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD1hZQ+QPiYQw91\ncACvf4vxYvriEUqIafRsBkpPOUlrQ8pmkk4j6+JExACoWGZSEOMYEy+kQs740Je6\nW4elGVPwWi/hgTh9YSWDHSnlbRlB2Iw8EPA2/e+KBDICwIVvi4aXSN4qChFCtGKa\nlqhjcoZitW6PdxNlOZijNdqqEU+yGnSrEBUOXA6knzsCigckP0RLh9xuFQdXwMXP\n9p7d3jjchm9MDe806adzWKbJWZIQ7vIA2arA8iPEnro28BrcGukhcodZqvoIQP/O\nYy1J+YzSJWwhmcRJuOwcDBOdRaE3D0L0m3ONCLu4TPM1O4isoyB7rVuUPDBe7elE\nCXfe/Z/PAgMBAAECggEAAxgE/LMr5BtK5BNzvBe9hzP/Q6mtHe1Gil/v6sdRhgZW\nKWxkNgQAbMES3bbeHzWdmaLllvUij4nCsl355m+HGmsV2bUbpZ97mLHdjR8Op5ZC\nJMr1Lp7iOFks2iexPBfEK+mGpyf2Ug1c2rmASLSGPf3Zn/mDpzhjvywWuSLmYAZQ\nACywxYgtjCeK9y7skU8dSMG8BVkF2d9k8z8rf7WMGLySLtTlcojkvz1Pzsztr7JZ\nYx3QcwjTtBiZdTqKIgyA9VHEZUtYwNNTZtfJGC+ve6PeohIrZZVJCYEWkOkUFIH5\nHRZO91gtgtv7WfxjQIAdt3cWpJkXgPpHOXv+KVNC6QKBgQD8N1yVwjXRfgK+rYjJ\n/PZJM7+s3sR/BLqMBPqMojgCWxyH7jjvEdGs0NYqCzhkVEhGZ673b2RsSkqKE5oL\nxvry9+FQylJdClcULwEaZ8Ih7x7CeGZjcyBXb2E2PmSDzhBk3jbgRSsOwMqXIcLC\nCVGEQRkWDPYGnSqLNMajmDiIRwKBgQD5NIHdJ8r5UKN5k0ucP4LeTcQfGtkf8RhC\nlXli0PJgKa+tK5bQDvEkmOG+Ktzhsu1Sb2kknXeU/U8briknO/x3LEmJ7Zx8fixk\n+6Z/Y4zsGnTh/oJVFWp1U9EF+s+nsMsc/yrzy5EnJJ1rHt4EaYvspWEkMsfcwSi5\nHYE/Okp4OQKBgQCxafACmD5rQoyDvGYAT6SfEXu/CmSGRLlETSxBSMrFPXnwVC5Q\nXOR0/+HmaUYdrPu6Kqz0+LJXSlrsjaVKq4lS5/Lida9CK0fdtsK75Ei2vhGREkhT\npGQXnQ1wrqrd3FHD4lwPnhgPpKXdca4h95QTyAbxb+SP+nY2vcUMxsLdeQKBgQDr\nQPJHgMVQTxvELZT3T82PZwJ6CrJmQQeR8+G/s1jcBv5dEAUzLKfg0KJrD7OtLWh0\npdAwTKcS8362ttcKvso7Bof1uWY88C+gtSAcqjHiwacNoWIQSENTt2hfqMJXn8Jf\nAVPfCpFgzmP9OAqHR8xb/lOSBI5Ai+iRuJTGx5R9oQKBgH0qusIsw83MsnAvHUuD\nEE/GK8GnWYmAAoZvgKl0bBQ4AizKGeGke1unyW85AZLFPx3oN0dKjElKcm/2Az4n\n+mExT/zDayrlvZd+HzAsAI0FLQy2+uCoc6arHFQX0qDERW0IqwzCbK4SnfCwcfAo\nQRIQsqoLCIkLLYVi3iRQvLF7\n-----END PRIVATE KEY-----\n",
  "client_email": "sheets@andrewsgrowth-app.iam.gserviceaccount.com",
  "client_id": "116601385620973295110",
  "type": "service_account"
}
''');

// const _SCOPES = const [SheetsApi.DriveScope];
const _SCOPES = const [
  SheetsApi.SpreadsheetsScope,
  StorageApi.DevstorageReadOnlyScope
];

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser _currentUser;
//564190111758-ivvj0f2o84krm5bn725hhnk0au4t49hq.apps.googleusercontent.com
//Uf93aS6ODkils_ayoUfw9o05
Future<Null> main() async {
  // clientViaServiceAccount(_credentials, _SCOPES).then((http_client) async {
  //   var sheets = new SheetsApi(http_client);
  //   var res = await AddSheetRequest.fromJson({"asdf": "asdf"});
  //   print(res);

  //   // await sheets.spreadsheets
  //   //     .get('1UT109UQ9nqy6APxgcFpK3cRan_TV9e_loklteGvWu9s');

  //   // var thissheet = await sheets.spreadsheets
  //   //     .get('1nsXrWoaCOlrqQrFaHLBjHKzU4eoeUQkcOMADKdfdn_A');
  //   // print(thissheet.spreadsheetUrl);
  //   var storage = new StorageApi(http_client);
  //   storage.buckets.list('andrewsgrowth-app').then((buckets) {
  //     print("Received ${buckets.items.length} bucket names:");
  //     for (var file in buckets.items) {
  //       print(file.name);
  //     }
  //   });
  // });
  _currentUser = await currentUser();
  print(_currentUser.uid);
  print(_currentUser.uid);
  print(_currentUser.uid);
  runApp(new TaskistApp());
}

Future<FirebaseUser> currentUser() async {
  final user = await _auth.currentUser();
  return user;
}

// class HomePage extends StatefulWidget {
//   final FirebaseUser user;

//   HomePage({Key key, this.user}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _HomePageState();
// }

class TaskistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      showSemanticsDebugger: false,
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/home': (context) => RootPage(user: _currentUser),
        // '/home': (context) => AntsLoginScreen(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/EmployeeList': (context) => EmployeeList(),
        // '/anthome': (context) => GeekyAntsHome(),
      },
      title: "Andrews App",
      home: RootPage(
        user: _currentUser,
      ),
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   int _currentIndex = 1;

//   final List<Widget> _children = [
//     // Tests(),
//     // EmployeesListPage(),
//     // EmployeesListPage(
//     //     // user: _currentUser,
//     //     ),
//     // EmployeesListPage(
//     //     // user: _currentUser,
//     //     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // bottomNavigationBar: BottomNavigationBar(
//       //   onTap: onTabTapped,
//       //   currentIndex: _currentIndex,
//       //   fixedColor: Colors.deepPurple,
//       //   items: <BottomNavigationBarItem>[
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.tablets), title: new Text("")),
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.calendarCheck),
//       //         title: new Text("")),
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.calendar), title: new Text("")),
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.slidersH), title: new Text(""))
//       //   ],
//       // ),
//       body: _children[_currentIndex],
//     );
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

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }
