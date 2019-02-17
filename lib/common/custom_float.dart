import 'package:flutter/material.dart';
import 'uidata.dart';

class CustomFloat extends StatelessWidget {
  final IconData icon;
  final Widget builder;
  final VoidCallback qrCallback;
  final isMini;

  CustomFloat({this.icon, this.builder, this.qrCallback, this.isMini = false});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.antiAlias,
      mini: isMini,
      onPressed: qrCallback,
      child: Ink(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.blue.shade900, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),

        // gradient: new LinearGradient(colors: Colors.blue.shade900)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              icon,
              size: 37,
              color: Colors.blue.shade900,
            ),
            builder != null
                ? Positioned(
                    right: 7.0,
                    top: 7.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: builder,
                      radius: 10.0,
                    ),
                  )
                : Container(),
            // builder
          ],
        ),
      ),
    );
  }
}
