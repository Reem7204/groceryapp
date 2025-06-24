import 'package:flutter/material.dart';
import 'package:groceryapp/Home.dart';
import 'package:groceryapp/cart.dart';

class Bottomnotification extends StatefulWidget {
  const Bottomnotification({super.key});

  @override
  State<Bottomnotification> createState() => _BottomnotificationState();
}

class _BottomnotificationState extends State<Bottomnotification> {
  int _selectedIndex = 0;
  final screens = [Home(),Cart()];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label:''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label:'')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        ),
    );
  }
}