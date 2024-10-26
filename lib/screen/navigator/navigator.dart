import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/screen/navigator/akun_screen.dart';
import 'package:sims_ppob_andre/screen/navigator/home_screen.dart';
import 'package:sims_ppob_andre/screen/navigator/topup_screen.dart';
import 'package:sims_ppob_andre/screen/navigator/history_transaction_screen.dart';

class NavigatorPage extends StatefulWidget {
  final int id;
  const NavigatorPage({super.key, this.id = 0});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int bottomNavIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    TopupScreen(),
    TransactionScreen(),
    AkunScreen(),
  ];

  void onBarTapped(int index) {
    setState(() {
      bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    bottomNavIndex = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: pages[bottomNavIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavIndex,
        onTap: onBarTapped,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Top Up'),
          BottomNavigationBarItem(
              icon: Icon(Icons.money), label: 'Transaction'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
    );
  }
}
