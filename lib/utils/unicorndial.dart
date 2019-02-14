// class FloatingActionButtonDemo extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => FloatingActionButtonDemoState();
// }

// class FloatingActionButtonDemoState extends State<FloatingActionButtonDemo> {
//   FloatingActionButtonLocation floatingActionButtonLocation =
//       FloatingActionButtonLocation.endDocked;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(/*TODO: code to be written later*/);
//   }
// }

//   FloatingActionButtonLocation floatingActionButtonLocation =
//       FloatingActionButtonLocation.endDocked;

// class BottomTabItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final FloatingActionButtonDemoState floatingActionButtonDemoState;
//   BottomTabItem(
//       {@required this.icon,
//       @required this.title,
//       @required this.floatingActionButtonDemoState});
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         if (title == "Center Docked") {
//           updateState(floatingActionButtonDemoState, FloatingActionButtonLocation.centerDocked);
//         } else if (title == "Center Float") {
//           updateState(floatingActionButtonDemoState, FloatingActionButtonLocation.centerFloat);
//         } else if (title == "End Float") {
//           updateState(floatingActionButtonDemoState, FloatingActionButtonLocation.endFloat);
//         } else {
//           updateState(floatingActionButtonDemoState, FloatingActionButtonLocation.endDocked);
//         }
//       },
//       child: Column(
//         children: <Widget>[
//           Icon(
//             icon,
//             color: Colors.white,
//           ),
//           Text(
//             title,
//             style: TextStyle(color: Colors.white),
//           )
//         ],
//       ),
//     );
//   }
// }
