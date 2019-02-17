import 'package:flutter/material.dart';
import 'package:taskist/model/account.dart';

class CustomerCard extends StatelessWidget {
  final Account customer;
  // final List serviceItemsList;

  CustomerCard(
    @required this.customer,
    // @required this.serviceItemsList,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                customer.firstName + ' ' + customer.lastName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(customer.phones.first.toString()),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Text(  widget.newJob.customer.address.streetAddress + widget.newJob.customer.address.city + widget.newJob.customer.address.state + widget.newJob.customer.address.zipcode),
                  (customer.address.pretty != null)
                      ? Text(customer.address.pretty)
                      : Text(
                          "Due 02/25/2019",
                          style: TextStyle(
                              color: Colors.orange.shade800,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
