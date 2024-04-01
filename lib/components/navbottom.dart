import 'package:flutter/material.dart';
import 'package:posyandu_app/home/dashboard_page.dart';
import 'package:posyandu_app/home/userprofile.dart';
import 'package:posyandu_app/home/education.dart';
import 'package:posyandu_app/home/grafik.dart';
import 'package:posyandu_app/home/imunisasi.dart';
import 'package:posyandu_app/model/user.dart';

class NavigationButtom extends StatefulWidget {
  final User user;

  const NavigationButtom({super.key, required this.user});

  @override
  State<NavigationButtom> createState() => _NavigationButtomState();
}

class _NavigationButtomState extends State<NavigationButtom> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = <Widget>[
      DashboardPage(user: widget.user),
      Education(user: widget.user,),
      Grafik(user: widget.user),
      Imunisasi(user: widget.user),
      Profile(user: widget.user),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F6ECD),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _buildNavBarItem(Icons.home, "Home", 0),
            _buildNavBarItem(Icons.article, "Artikel", 1),
            _buildNavBarItem(Icons.insert_chart, "Grafik", 2),
            _buildNavBarItem(Icons.medical_services, "Imunisasi", 3),
            _buildNavBarItem(Icons.person_2_rounded, "Profile", 4),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF0F6ECD),
          unselectedItemColor: const Color(0xFF0F6ECD),
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFF0F6ECD) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 25,
          color: _selectedIndex == index ? Colors.white : const Color(0xFF0F6ECD),
        ),
      ),
      label: label,
    );
  }
}