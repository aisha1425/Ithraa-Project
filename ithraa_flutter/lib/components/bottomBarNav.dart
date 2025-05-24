import 'package:flutter/material.dart';
import 'package:ithraa/Forms.dart';
import 'package:ithraa/Offers.dart';
import 'package:ithraa/accomondations.dart';
import 'package:ithraa/business/homeLocale.dart';
import 'package:ithraa/home.dart';
import 'package:ithraa/jobs.dart';
import 'package:ithraa/offersAndDiscounts.dart';
import 'package:ithraa/profile.dart';
import 'package:ithraa/transportation.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBarNav extends StatefulWidget {
  BottomBarNav({super.key});

  @override
  State<BottomBarNav> createState() => _BottomBarNavState();
}

class _BottomBarNavState extends State<BottomBarNav> {
  @override
  void initState() {
    super.initState();
    loadUserType();
  }

  String type = '';
  String businessType = '';

  void loadUserType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.containsKey("email")) {
        type = sharedPreferences.getString("type")!;
      }
      if (sharedPreferences.containsKey("businessType")) {
        businessType = sharedPreferences.getString("businessType")!;
      }
      print(type);
      print(businessType);
    });
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  NavBarStyle _navBarStyle = NavBarStyle.style6;

  List<Widget> _buildScreens() {
    return [
      (type == 'Student') ? Home() : HomeLocale(),
      if (businessType == "Accomindation Agent")
        Accomindations(type: 'Local Business'),
      if (businessType == "Transport Agent")
        Transportation(type: 'Local Business'),
      if (type == 'Student') Forms(),
      if (type == 'Student') OffersAndDiscount(),
      if (businessType == "Offers Provider") OffersAndDiscount(type: type),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey.shade400,
      ),
      if (businessType == "Transport Agent" ||
          businessType == "Accomindation Agent" ||
          type == "Student")
        PersistentBottomNavBarItem(
          icon: Icon((businessType == "Accomindation Agent")
              ? Icons.business
              : (businessType == "Transport Agent")
                  ? Icons.directions_bus_filled_sharp
                  : Icons.chat),
          title: (businessType == "Accomindation Agent")
              ? 'Accomindate'
              : (businessType == "Transport Agent")
                  ? 'Transport'
                  : 'Forms',
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey.shade400,
        ),
      if (type == 'Student' || businessType == "Offers Provider")
        PersistentBottomNavBarItem(
          icon: Icon(
              (type == 'Student') ? Icons.favorite : Icons.local_offer_sharp),
          title: 'Offers',
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey.shade400,
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: 'Profile',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey.shade400,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.blue.shade600,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: _navBarStyle,
      ),
    );
  }
}
