import 'package:flutter/material.dart';
import 'package:taskist/model/workorder.dart';
// import 'package:taskist/model/currentOrderpanel.dart';
import 'package:taskist/model/serviceItem.dart';
import 'package:taskist/shop/page_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkorderCard extends StatelessWidget {
  final Workorder currentOrder;
  WorkorderCard(
    @required this.currentOrder,
  );

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: Padding(
            padding: EdgeInsets.only(bottom: 80.0),
            child: new Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border:
                      new Border.all(color: Colors.green.shade900, width: 2)),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: new Container(
                  width: 220.0,
                  //height: 100.0,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 5.0),
                          child: Container(
                            child: Text(
                              (currentOrder.customer.accountName != null)
                                  ? currentOrder.customer.accountName
                                  : currentOrder.customer.lastName,
                              // serviceItemMap.keys.elementAt(index),
                              style: TextStyle(
                                color: Colors.green.shade900,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 1.0, right: 1.0),
                                  color: Colors.green.shade900,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        (currentOrder.serviceItems.length > 0)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: 30.0, left: 15.0, right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 220.0,
                                      child: ListView.builder(
                                          //physics: const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              currentOrder.serviceItems.length,
                                          // serviceItemMap.values.elementAt(index).length,
                                          itemBuilder:
                                              (BuildContext ctxt, int i) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                (currentOrder.serviceItems
                                                            .elementAt(i) !=
                                                        null)
                                                    ? Icon(
                                                        currentOrder
                                                                .serviceItems
                                                                .elementAt(i)
                                                                .isDone
                                                            ? FontAwesomeIcons
                                                                .checkCircle
                                                            : FontAwesomeIcons
                                                                .circle,
                                                        color: currentOrder
                                                                .serviceItems
                                                                .elementAt(i)
                                                                .isDone
                                                            ? Colors.white70
                                                            : Colors.white,
                                                        size: 14.0,
                                                      )
                                                    : Container(height: 4),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                ),
                                                (currentOrder.serviceItems
                                                            .elementAt(i) !=
                                                        null)
                                                    ? Flexible(
                                                        child: Text(
                                                          currentOrder
                                                              .serviceItems
                                                              .elementAt(i)
                                                              .serviceName,
                                                          style: currentOrder
                                                                  .serviceItems
                                                                  .elementAt(i)
                                                                  .isDone
                                                              ? TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  color: Colors
                                                                      .white70,
                                                                  fontSize:
                                                                      17.0,
                                                                )
                                                              : TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      17.0,
                                                                ),
                                                        ),
                                                      )
                                                    : Container(height: 4),
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: 30.0, left: 15.0, right: 5.0),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
