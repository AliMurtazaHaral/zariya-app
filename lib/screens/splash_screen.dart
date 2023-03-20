import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zariya/screens/login_screen.dart';
import 'package:zariya/screens/select_category_screen.dart';
import 'package:zariya/screens/signup_screen.dart';
import 'person_dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isHidden = true;
  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3eb489),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Image(
              image: AssetImage("assets/splashImage.PNG"),
              fit: BoxFit.fill,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'We Need to Change Our Society',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'we know who you serve, how you help, and what impact you make.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0XFFec4d4d),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCategoryScreen()));
                },
                //SelectCategoryScreen()
                child: const Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
