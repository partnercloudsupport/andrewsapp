import 'package:flutter/material.dart';
import 'package:taskist/rugs/models/job.dart';
// import 'package:taskist/rugs/models/jobpanel.dart';
import 'package:taskist/rugs/models/serviceItem.dart';
import 'package:taskist/rugs/page_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobModelCard extends StatelessWidget {
  final JobModel job;
  // final List serviceItemsList;

  JobModelCard(
      @required this.job,
      // @required this.serviceItemsList,
      );

  @override
  Widget build(BuildContext context) {
    RawMaterialButton _buildFavoriteButton() {
      return RawMaterialButton(
        constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
        elevation: 2.0,
        fillColor: Theme.of(context).buttonColor,
        shape: CircleBorder(),
      );
    }

        return new GestureDetector(
   child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            color: job.getColor(),
            child: new Container(
              width: 220.0,
              //height: 100.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 12.0),
                      child: Container(
                        child: Text(
                          job.customer.accountName,
                          // serviceItemMap.keys.elementAt(index),
                          style: TextStyle(
                            color: Colors.white,
                            
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 30.0, left: 15.0, right: 5.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 220.0,
                            child: ListView.builder(
                                //physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                             job.serviceItems.length,
                                    // serviceItemMap.values.elementAt(index).length,
                                itemBuilder: (BuildContext ctxt, int i) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                       job.serviceItems
                                    .elementAt(i)
                                                ['isDone']
                                            ? FontAwesomeIcons.checkCircle
                                            : FontAwesomeIcons.circle,
                                        color: 
                                   job.serviceItems
                                                .elementAt(i)
                                                ['isDone']
                                            ? Colors.white70
                                            : Colors.white,
                                        size: 14.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                      ),
                                      Flexible(
                                        child: Text(
                                        job.serviceItems
                                                .elementAt(i)
                                               ['name'],
                                          style: 
                                         job.serviceItems
                                                .elementAt(i)
                                                ['isDone']
                                              ? TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.white70,
                                                  fontSize: 17.0,
                                                )
                                              : TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.0,
                                                ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
