
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zariya/screens/login_screen.dart';
import 'package:zariya/screens/ngo_signup_screen.dart';
import 'package:zariya/screens/signup_screen.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({Key? key}) : super(key: key);
  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}
class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ZARIYA',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0XFF000000)),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Text(
                    'Login As',
                    style:
                    TextStyle(fontSize: 30, color: Color(0XFF000000)),
                  ),
                ),
                const SizedBox(height: 10),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 230),
                          child: GestureDetector(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xb00d4d79),
                                    radius: 60,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 55, // Image radius
                                      child: Image.asset(
                                        'assets/ngoLogo.png',
                                        height: 400,
                                      ),
                                    ),),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                    child: Text(
                                      'NGO',
                                      style: TextStyle(fontSize: 18, color: Color(0XFF000000)),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupNGOScreen()));
                              }),
                        ),
                        Text(''),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(''),
                        Padding(
                          padding: EdgeInsets.only(left: 170, top: 20),
                          child: GestureDetector(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xb00d4d79),
                                    radius: 60,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 55, // Image radius
                                      child: Image.asset(
                                        'assets/donorLogo.png',
                                        height: 90,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                    child: Text(
                                      'Donor',
                                      style: TextStyle(fontSize: 18, color: Color(0XFF000000)),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {

                              }),
                        ),
                        Text(''),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 250),
                          child: GestureDetector(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xb00d4d79),
                                  radius: 60,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 55, // Image radius
                                    child: Image.asset(
                                      'assets/personLogo.png',
                                      height: 80,
                                    ),
                                  ),),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                  child: Text(
                                    'Person',
                                    style: TextStyle(fontSize: 18, color: Color(0XFF000000)),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()));
                            },
                          ),
                        ),
                        Text(''),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
