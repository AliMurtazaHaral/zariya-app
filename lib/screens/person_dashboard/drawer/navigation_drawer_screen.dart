
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:zariya/screens/person_dashboard/home_screen.dart';
import 'package:zariya/screens/person_dashboard/inbox_screen.dart';
import '../../../models/user_model.dart';
import '../../splash_screen.dart';
import 'drawer_item.dart';
class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
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
    return Drawer(
      child: Material(
        color:Color(0xFF3eb489),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(context),
              const SizedBox(height: 40,),
              const Divider(thickness: 1, height: 10, color: Colors.grey,),
              const SizedBox(height: 40,),
              DrawerItem(
                name: 'Home',
                icon: Icons.home,
                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen())),
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Profile',
                  icon: Icons.account_box_rounded,
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const InboxScreen()));
                  }
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Donation History',
                  icon: Icons.payments,
                  onPressed: ()=> {

                  }
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Payment Details',
                  icon: Icons.favorite_outline,
                  onPressed: ()=> onItemPressed(context, index: 3)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Help',
                  icon: Icons.settings,
                  onPressed: (){

                  }
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  onPressed: ()async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}){
    Navigator.pop(context);

    switch(index){
      case 4:
        Navigator.pushNamed(context, "/riderSetting");
        break;
    }
  }

  Widget headerWidget(BuildContext context) {


    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loggedInUser.fullName.toString(), style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(height: 10,),
            SizedBox(width: MediaQuery.of(context).size.width*0.4,
              child: Text(loggedInUser.email.toString(), maxLines: 2,
                  softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.white)),
            ),

          ],
        )
      ],
    );

  }
  getImg(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('profileImages/')
        .child(s);

    setState(() async{
      url = await ref.getDownloadURL();
    });
  }
}



