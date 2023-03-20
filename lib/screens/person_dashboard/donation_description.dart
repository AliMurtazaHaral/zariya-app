import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zariya/screens/payment_methods/stripe_payment.dart';

class DonationDescription extends StatefulWidget {
  DonationDescription({Key? key,required this.uId, required this.description,required this.raisedAmount}) : super(key: key);
  String? description;
  String? raisedAmount;
  String? uId;
  @override
  State<DonationDescription> createState() => _DonationDescriptionState();
}

class _DonationDescriptionState extends State<DonationDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Text("Description: ${widget.description}")),
            SizedBox(
              height: MediaQuery.of(context).size.height*.01,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0XFFec4d4d),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                minWidth: MediaQuery.of(context).size.width * 0.7,
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StripePayment(uId:widget.uId,raisedAmount: widget.raisedAmount)));
                },
                child: const Text(
                  "Donate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.02,
            ),
          ],
        ),
      ),
    );
  }
}
