import 'package:flutter/material.dart';
import 'package:taskist/model/account.dart';
import '../model/asset.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;
  // final List serviceItemsList;

  AssetCard(
    @required this.asset,
    // @required this.serviceItemsList,
  );

  makeListTile(asset) {
    ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
          // child: CircleAvatar(
          //     radius: 35.0, backgroundImage: NetworkImage(asset.image)),
        ),
        title: Text(
          "Introduction to Driving",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(" Intermediate", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        // child: Card(
        //     elevation: 8.0,
        //     margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      // child: Icon(Icons.autorenew, color: Colors.white),
                      child: CircleAvatar(
                          radius: 35.0,
                          backgroundImage: NetworkImage(asset.image)),
                    ),
                    title: Text(
                      asset.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(asset.serial,
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 30.0))

                // elevation: 2.0,
                // child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.stretch,
                //         children: <Widget>[
                //           Row(
                //             children: <Widget>[
                //               CircleAvatar(
                //                   radius: 35.0,
                //                   backgroundImage: NetworkImage(asset.image)),
                //               Text(
                //                 (asset != null &&
                //                         asset.assetTag != null &&
                //                         asset.id != null)
                //                     ? asset.assetTag + ' ' + asset.id.toString()
                //                     : "shit not here",
                //                 style: TextStyle(
                //                     color: Colors.blue,
                //                     fontWeight: FontWeight.w700,
                //                     fontSize: 20.0),
                //               ),
                //               SizedBox(
                //                 height: 10.0,
                //               ),
                //               Text(asset.category.toString()),
                //               SizedBox(
                //                 height: 10.0,
                //               ),
                //               Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                   children: <Widget>[
                //                     // Text(  widget.newJob.asset.address.streetAddress + widget.newJob.asset.address.city + widget.newJob.asset.address.state + widget.newJob.asset.address.zipcode),
                //                     // (asset.address.pretty != null)
                //                     // ? Text(asset.address.pretty)
                //                     Text(
                //                       "asdf",
                //                       style: TextStyle(
                //                           color: Colors.blue.shade800,
                //                           fontWeight: FontWeight.w700,
                //                           fontSize: 15.0),
                //                     ),
                //                     Text(
                //                       "Due 02/25/2019",
                //                       style: TextStyle(
                //                           color: Colors.orange.shade800,
                //                           fontWeight: FontWeight.w700,
                //                           fontSize: 15.0),
                //                     )
                //                   ])
                //             ],
                //           )
                //           // ]
                //         ]))));
                )));
  }
}
