
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:zariya/screens/person_dashboard/compaign_form.dart';
import 'package:zariya/screens/person_dashboard/drawer/navigation_drawer_screen.dart';
import 'package:zariya/screens/person_dashboard/home_screen.dart';
import 'package:zariya/screens/person_dashboard/inbox_screen.dart';
import 'package:zariya/screens/person_dashboard/setting_screen.dart';

class DonorDashboardScreen extends StatefulWidget {
  const DonorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DonorDashboardScreen> createState() => _DonorDashboardScreenState();
}

class _DonorDashboardScreenState extends State<DonorDashboardScreen> {

  @override
  int _currentIndex = 0;
  int _counter = 0;

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    InboxScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.green,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Color(0xffffffff),
            textAlign: TextAlign.center,
          ),

          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Inbox'),
            activeColor: Color(0xffffffff),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Color(0xffffffff),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
