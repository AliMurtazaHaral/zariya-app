
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zariya/screens/person_dashboard/dashboard_screen.dart';

import '../../models/storage_model.dart';
import '../../models/user_model.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String url = "";
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {

      setState(() {
        loggedInUser = UserModel.fromMapRegsitration(value.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getImg(loggedInUser.profileImageReference.toString());

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Color(0xFF3eb489),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Container(
                  transform: Matrix4.translationValues(0, 50, 0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(height: 70),
                Text("${loggedInUser.fullName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Container(height: 15),
                Text("${loggedInUser.email}",
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Container(height: 25),
                Text("${loggedInUser.city}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Container(height: 35),
                Divider(height: 50),
                Container(height: 35),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0XFFec4d4d),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
                },
                child: const Text(
                  "Update Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImg(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('profileImage/')
        .child(s);
    url = await ref.getDownloadURL();
  }
}
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cityField = TextFormField(
      autofocus: false,
      controller: cityController,
      keyboardType: TextInputType.emailAddress,
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
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile'),
      ),
      body:SingleChildScrollView(
        child: (
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        children: [ Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.white,
                          child: MaterialButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              minWidth: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              onPressed: () async {
                                await _getFromGallery();
                              },

                              child: Column(children: [
                                imageFile==null? Icon(Icons.person, size: 150, color: Colors.black,) :ClipRRect(
                                  borderRadius: BorderRadius.circular(500.0),
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.width * 0.4,
                                    width: MediaQuery.of(context).size.height * 0.2,
                                  ),
                                ),

                              ],)
                          ),
                        ),],
                      ),),
                    const SizedBox(height: 10,),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: cityField,
                    ),
                    const SizedBox(
                      height: 10,
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
                    onPressed: () async{
                      await postDetailsToFirestore();
                    },
                    child: const Text(
                      "Update Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
        ),
        ),
    );
  }
  File? imageFile;
  XFile? pickedFile;
  _getFromGallery() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File('${pickedFile?.path}');
        StorageModel storageModel = StorageModel();
        storageModel.uploadProfileImage(pickedFile?.path, pickedFile?.name);
      });
    }
  }
  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // writing all the values

    userModel.city = cityController.text;
    userModel.profileImageReference = pickedFile?.name;
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toMapUpdateUser());
    Fluttertoast.showToast(msg: "Your account has been updated successfully");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard_Screen()));
  }
}
