import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:zariya/screens/person_dashboard/donation_description.dart';
import '../../models/user_model.dart';
import '../payment_methods/stripe_payment.dart';

class DonationCampaignScreen extends StatefulWidget {
  const DonationCampaignScreen({Key? key}) : super(key: key);

  @override
  State<DonationCampaignScreen> createState() => _DonationCampaignScreenState();
}

class _DonationCampaignScreenState extends State<DonationCampaignScreen> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
      FirebaseFirestore.instance.collection('campaign').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
      FirebaseFirestore.instance.collection('campaign').snapshots();

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
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(''),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: MediaQuery.of(context).size.height * 1,
                    child: StreamBuilder(
                      stream: foundMechanic,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        List<Widget> Data = [];
                        var image_2;
                        final product = streamSnapshot.data?.docs;
                        return product?.length != 0
                            ? SingleChildScrollView(
                              child: Column(children: [
                                for (var data in product!)
                                  FutureBuilder<String>(
                                      future: getImg(
                                          data["campaignImageReference"]),
                                      builder: (_, imageSnapshot) {
                                        final imageUrl = imageSnapshot.data;
                                        return imageUrl != null
                                            ? data['status'] == 'approved'
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal:
                                                                    0),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .9,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: const Color(
                                                              0xFF3eb489),
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      10)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                  0xFF3eb489),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset: Offset(
                                                                  0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child:
                                                            GestureDetector(
                                                          onTap: () {},
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 0,
                                                                      right:
                                                                          0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black),
                                                                      borderRadius:
                                                                          BorderRadius.circular(1.0),
                                                                    ),
                                                                    child:
                                                                        Image(
                                                                      image: NetworkImage(
                                                                          imageUrl),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          MediaQuery.of(context).size.height *
                                                                              .3,
                                                                      width: MediaQuery.of(context).size.width *
                                                                          .8,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        "${data['campaignName']}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15),
                                                                      )),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  Text(
                                                                    "total Amount: ${data['targetAmount']}",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  RatingBar
                                                                      .builder(
                                                                    itemSize:
                                                                        15,
                                                                    initialRating:
                                                                        double.parse(
                                                                            data['rating']),
                                                                    minRating:
                                                                        1,
                                                                    direction:
                                                                        Axis.horizontal,
                                                                    allowHalfRating:
                                                                        false,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding:
                                                                        EdgeInsets.symmetric(
                                                                            horizontal: 0),
                                                                    itemBuilder:
                                                                        (context, _) =>
                                                                            Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (rating) {
                                                                      setState(
                                                                          () {});
                                                                      print(
                                                                          rating);
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  Text(
                                                                    "Raised Amount: ${data['raisedAmount']}",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  Material(
                                                                    elevation:
                                                                        5,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: const Color(
                                                                        0XFFec4d4d),
                                                                    child:
                                                                        MaterialButton(
                                                                      padding: const EdgeInsets.fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      minWidth:
                                                                          MediaQuery.of(context).size.width *
                                                                              0.7,
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => DonationDescription(description: data['description'], raisedAmount: data['raisedAmount'], uId: data.id)));
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "View Details",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .02,
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Divider(
                                                        height: 1,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox()
                                            : const SizedBox();
                                      }),
                          SizedBox(
                              height: MediaQuery.of(context).size.height*.2,
                          )
                              ]),
                            )
                            : SizedBox(
                                height: 1000,
                              );
                      },
                    ),
                  ),
                ],
              )),
        ],
      )),
    );
  }

  String url = "";
  Future<String> getImg(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('campaignImage/')
        .child(s);
    url = await ref.getDownloadURL();
    return await ref.getDownloadURL();
  }

  void _runFilter1() {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
        FirebaseFirestore.instance.collection('users').snapshots();
    // we use the toLowerCase() method to make it case-insensitive
    results = FirebaseFirestore.instance
        .collection('users')
        .where('profession'.toString(), isEqualTo: "Mechanic")
        .snapshots();
  }

  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
        FirebaseFirestore.instance.collection('users').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allMechanic;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('users')
          .where('category'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      foundMechanic = results;
    });
  }
}
