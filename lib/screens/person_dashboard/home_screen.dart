import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zariya/screens/payment_methods/stripe_payment.dart';
import 'package:zariya/screens/person_dashboard/donation_campaign_screen.dart';

import '../../models/user_model.dart';
import 'compaign_form.dart';
import 'drawer/navigation_drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  String url = "";
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
    return Scaffold(
      drawer: NavigationDrawer(),
      backgroundColor: const Color(0xFFFBFBFB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello, ${loggedInUser.fullName}',
                  style: TextStyle(
                    color: Color(0xFF3eb489),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextFormField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(15),
                            width: 18,
                            child: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      image: AssetImage("assets/compaign.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
                      const Text(
                        '  Do you want to launch \n  your own compaign?',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox( height: MediaQuery.of(context).size.height * 0.04,),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF3eb489),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          minWidth: MediaQuery.of(context).size.width * 0.4,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Compaign_Form_Screen()));
                          },
                          //SelectCategoryScreen()
                          child: const Text(
                            "Start Campaign",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      image: AssetImage("assets/donate.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
                      const Text(
                        '   Donate Now',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox( height: MediaQuery.of(context).size.height * 0.05,),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF3eb489),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                          onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> const DonationCampaignScreen()));
                          },
                          //SelectCategoryScreen()
                          child: const Text(
                            "Donate",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
                child: const Text("Categories",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFE5F2F0),
                              //Color(0xFFFDEFE5),
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: const Image(
                                  color: Color(0xFF229DA3),
                                  //Color(0xFFF89706),
                                  image: AssetImage(
                                    "assets/all.png",
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        const Text("All",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.05,
                    ),

                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFE5F2F0),
                              //Color(0xFFE6F0FA),
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: GestureDetector(
                              onTap: (){
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 9.0 , left: 5.0 , right: 5.0),
                                child: Image(
                                    color: Color(0xFF229DA3),
                                    //Color(0xFF3391E9),
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/education.png",
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        const Text("Education",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.05,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFE5F2F0),
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: const Image(
                                  color: Color(0xFF229DA3),
                                  image: AssetImage(
                                    "assets/family.png",
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text("Family",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.05,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            )


          ],
        ),
      ),
    );
  }
}
