import 'package:flutter/material.dart';
import 'package:realtime_tutorial/pages/analytics_page.dart';
import 'package:realtime_tutorial/pages/food_page.dart';
import 'package:realtime_tutorial/pages/home_page.dart';
import 'package:realtime_tutorial/pages/prediction_page.dart';
import 'package:realtime_tutorial/pages/profile_page.dart';
import 'package:realtime_tutorial/pages/sample_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    HomePage(),
    // AnalyticsPage(),
    AnalyticsPage(),
    // SamplePage(),
    PredictionPage(),
    ProfilePage()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: IndexedStack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          )
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar() {
    return Container(
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.clear,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black],
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xfffafafa),
        selectedFontSize: 12,
        selectedItemColor: Color(0xffee5050),
        unselectedItemColor: Colors.grey.shade700,
        //showSelectedLabels: false,
        //showUnselectedLabels: false,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: "Analytics"),
          BottomNavigationBarItem(
              icon: Icon(Icons.lens_blur_sharp), label: "Prediction"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile")
        ],

        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
