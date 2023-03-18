import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/database.dart';
import '../chat/views/conversationScreen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> admin =
  FirebaseFirestore.instance.collection('admin').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoomAndStartConversation(String userName, String myName,String uid,String uid2) {
    List<String> users = [myName, userName];
    String chatRoomId = getChatRoomId(uid, uid2);
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationScreen(
          chatRoomId: chatRoomId, myName: myName, userName: userName, currentU: user!.uid,),
      ),
    );
  }
  bool flag = true;
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
      appBar: AppBar(
        title: Text('Inbox'),
        backgroundColor: Color(0xFF3eb489),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: MediaQuery.of(context).size.height * 1,
                  child: StreamBuilder(
                    stream: admin,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Expanded(
                          child: streamSnapshot.data?.docs.length != 0
                              ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: streamSnapshot.data?.docs.length,
                            itemBuilder:
                                (ctx, index) =>
                            Container(

                              decoration: BoxDecoration(
                                color: Color(0xFF3eb489),
                                border: Border.all(
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(
                                    10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF3eb489),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(3, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(bottom: 30),
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${streamSnapshot.data?.docs[index]['username']}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontSize:
                                        15),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .height *
                                        .02,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .08,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          createChatRoomAndStartConversation(
                                              streamSnapshot.data?.docs[index]
                                              [
                                              'username'],
                                              loggedInUser
                                                  .fullName
                                                  .toString(),'${streamSnapshot.data?.docs[index].id}',user!.uid);
                                        },
                                        child:
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0XFFec4d4d),
                                              borderRadius:
                                              BorderRadius.circular(10.0)),
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              16.0,
                                              vertical:
                                              16.0),
                                          child: const Text(
                                              'Message',
                                              style: TextStyle(
                                                  color: Color(0xFFffffff),
                                                  fontSize: 10)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .02,
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            )
                          )
                              : const Text(
                            'No results found',
                            style: TextStyle(fontSize: 24,color: Colors.cyan),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
