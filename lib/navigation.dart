import 'package:flutter/material.dart';
import 'package:streamer/pages/Songs_List.dart';

class Navigation extends StatefulWidget {
  final subSonicContext;

  const Navigation({super.key, required this.subSonicContext});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State {
  int _selectedTab = 0;

  // LOOK AT ME MA I'M A LITTLE TROUBLEMAKER THAT WILL RUIN YOUR LIFE UNLESS YOU LOOK AT ME!!!
  // We need to figure out how to pass information from the login screen to here and then to the available pages.
  List _pages = [
    SongsList(
      // This ctx variable is empty, figure out how to pass the value from the login screen to here and then through here.
      subSonicContext: ctx,
    )
  ];

  static var ctx;

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
