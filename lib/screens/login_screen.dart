
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zariya/screens/person_dashboard/dashboard_screen.dart';
import 'package:zariya/screens/person_dashboard/home_screen.dart';
import 'package:zariya/screens/signup_screen.dart';

import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
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
    final emailField = TextFormField(
      autofocus: false,
      controller: userNameController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        userNameController.text = value!;
      },
      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        fillColor: Color(0XFFffffff),
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF0DF5E3)),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: " Email",
        prefixIcon: Icon(Icons.email,color: Colors.grey,),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),

      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: isHidden,
      onSaved: (value) {
        passwordController.text = value!;
      },

      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF0DF5E3)),
        ),
        fillColor: Color(0XFFffffff),
        filled: true,
        prefixIcon: const Icon(Icons.lock,color: Colors.grey,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: " Password",
        suffix: InkWell(

          onTap: togglePasswordView,
          child: Icon(
            isHidden ? Icons.visibility
                : Icons.visibility_off,color: Colors.grey,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xFF3eb489),
      appBar: AppBar(
        backgroundColor: Color(0xFF3eb489),
        title: Text('LOGIN HERE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*.15,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('ZARIYA',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.1,
                ),
                Padding(padding: EdgeInsets.only(left: 20,right: 20),
                  child: emailField,),
                const SizedBox(
                  height: 10,
                ),
                Padding(padding: EdgeInsets.only(left: 20,right: 20),
                  child: passwordField,),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPasswordScreen()));
                },
                child: const Text('Forget Password?    ',style: TextStyle(
                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15
                ),),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0XFFec4d4d),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                onPressed: () {
                  signIn(userNameController.text, passwordController.text);
                },
                child: const Text(
                  "LOGIN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 50,),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text('Signup',style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15
                    ),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  // login function
  void signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
      Fluttertoast.showToast(msg: "Login Successful"),
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen())),
    })
        .catchError((e) {
      Fluttertoast.showToast(msg: "Login is not successful");
    });
  }
}
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final emailController = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;


  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter Email Here",
        hintStyle: const TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF3eb489),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3eb489),
        title: const Align(
          alignment: Alignment.center,
          child: Text("Reset Password"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'ZARIYA!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Forget Password!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
            ),

            Padding(padding: EdgeInsets.only(left: 20,right: 20),
            child: emailField,),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0XFFec4d4d),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                onPressed: () async{
                  await resetPassword(emailController.text);
                },
                //SelectCategoryScreen()
                child: const Text(
                  "Forget Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    if (emailController.text.isNotEmpty) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    } else {
      Fluttertoast.showToast(msg: "You have entered wrong email");
    }
  }

  void resetPasswordLink() {
    resetPassword(emailController.text);
  }
}