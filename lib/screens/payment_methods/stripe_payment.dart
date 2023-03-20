import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;
import 'package:zariya/screens/person_dashboard/dashboard_screen.dart';
import 'package:zariya/screens/person_dashboard/rate_donation_screen.dart';

import '../../models/user_model.dart';


class StripePayment extends StatefulWidget {
  StripePayment({Key? key,required this.uId,required this.raisedAmount}) : super(key: key);
  String? raisedAmount;
  String? uId;
  @override
  State<StripePayment> createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {
  Map<String, dynamic>? paymentIntent;
  TextEditingController paymentController = TextEditingController();
  int total = 0;
  @override
  Widget build(BuildContext context) {
    final paymentField = TextFormField(
      autofocus: false,
      controller: paymentController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        paymentController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        border: UnderlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter Amount",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: paymentField,
            ),
            
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Color(0XFFec4d4d),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                minWidth: MediaQuery.of(context).size.width * 0.3,
                onPressed: () async{
                  print("pressed");

                  await makePayment();
                  total = int.parse(paymentController.text) + int.parse(widget.raisedAmount.toString());
                  await postDetailsToFirestore();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RateScreen(uniId: widget.uId)));
                },
                child: const Text(
                  "Make Payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(

                      color: Colors.white,
                      fontWeight: FontWeight.normal),

                ),),
            ),
          ],
        )
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(paymentController.text, 'Pkr');
      //Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Ali Murtaza')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }
  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // writing all the values

    userModel.raisedAmount = total.toString();

    await firebaseFirestore
        .collection("campaign")
        .doc(widget.uId)
        .update(userModel.toRaisedAmount());

  }
  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
      ).then((value){
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green,),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;

      }).onError((error, stackTrace){
        print('Error is:--->$error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51LfUARDwLhA5VoPRDxnbj9uoqfXrzLF3LNB8SruISPK7mObpnWmyDa1bUDU4sueko30iSfIB3Tgu99QMngsmsEZd00PLOBUklC',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100 ;
    return calculatedAmout.toString();
  }

}
