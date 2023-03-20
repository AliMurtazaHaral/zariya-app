import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zariya/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/user_model.dart';

class SignupDonorScreen extends StatefulWidget {
  const SignupDonorScreen({Key? key}) : super(key: key);
  @override
  State<SignupDonorScreen> createState() => _SignupDonorScreenState();
}

class _SignupDonorScreenState extends State<SignupDonorScreen> {
  TextEditingController donoremailController = TextEditingController();
  TextEditingController donornameController = TextEditingController();
  TextEditingController donortypeController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController foodamountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String _dropdown = 'Indivdual';
  bool isHidden = true;
  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final donoremailfield = TextFormField(
      autofocus: false,
      controller: donoremailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        donoremailController.text = value!;
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
        prefixIcon: Icon(
          Icons.email,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    final donornamefield = TextFormField(
      autofocus: false,
      controller: donornameController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        donornameController.text = value!;
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
        hintText: " Name",
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    final dropdownField = Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20),
      child: DropdownButton(
        hint: Text(
          _dropdown,
          style: TextStyle(color: Colors.black),
        ),
        isExpanded: true,
        iconSize: 30.0,
        style: TextStyle(color: Colors.black),
        items: ['Indivdual', 'Restaurant', 'Marquee'].map(
              (val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          },
        ).toList(),
        onChanged: (val) {
          setState(
                () {
              _dropdown = val.toString();
            },
          );
        },
      ),
    );

    final phonenumberField = TextFormField(
      autofocus: false,
      controller: phonenumberController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        phonenumberController.text = value!;
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
        hintText: " Phone-no",
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    final cityfield = TextFormField(
      autofocus: false,
      controller: cityController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        cityController.text = value!;
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
        hintText: " City",
        prefixIcon: Icon(
          Icons.location_city,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    final addressfield = TextFormField(
      autofocus: false,
      controller: addressController,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) {
        addressController.text = value!;
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
        hintText: " Address",
        prefixIcon: Icon(
          Icons.location_city,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    final foodamountField = TextFormField(
      autofocus: false,
      controller: foodamountController,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) {
        foodamountController.text = value!;
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
        hintText: " Food Amount",
        prefixIcon: Icon(
          Icons.emoji_food_beverage,
          color: Colors.grey,
        ),
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
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: " Password",
        suffix: InkWell(
          onTap: togglePasswordView,
          child: Icon(
            isHidden ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      obscureText: isHidden,
      onSaved: (value) {
        confirmPasswordController.text = value!;
      },
      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF0DF5E3)),
        ),
        fillColor: Color(0XFFffffff),
        filled: true,
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: " Password",
        suffix: InkWell(
          onTap: togglePasswordView,
          child: Icon(
            isHidden ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
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
        title: Text(
          'SIGNUP HERE',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      'Create Your Account',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(80),
                        color: Colors.white,
                        child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            minWidth: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.2,
                            onPressed: () async {
                              _getFromGallery();
                            },
                            child: Column(
                              children: [
                                imageFile == null
                                    ? Icon(
                                  Icons.person,
                                  size: 150,
                                  color: Colors.black,
                                )
                                    : ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(500.0),
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.4,
                                    width: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.2,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: donornamefield,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: donoremailfield,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: dropdownField,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: phonenumberField,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: cityfield,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: addressfield,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: foodamountField,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: passwordField,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: confirmPasswordField,
                ),
              ],
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
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    signUp(donoremailController.text, passwordController.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please match your password fields");
                  }
                },
                child: const Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

//Get from gallery
  File? imageFile;
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // writing all the values

    userModel.email = donoremailController.text;
    userModel.phoneNumber = phonenumberController.text;
    userModel.donortype = _dropdown;
    userModel.address = addressController.text;
    userModel.foodamount = foodamountController.text;
    userModel.password = passwordController.text;
    userModel.city = cityController.text;
    userModel.fullName = donornameController.text;
    await firebaseFirestore
        .collection("donors")
        .doc(user?.uid)
        .set(userModel.toMapDonor());
    Fluttertoast.showToast(msg: "Your account has been created successfully");
  }

  void signUp(String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}