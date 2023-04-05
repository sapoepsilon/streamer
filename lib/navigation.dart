import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:streamer/home.dart';
import 'package:streamer/pages/Songs_List.dart';
import 'package:streamer/settings.dart';
import 'package:streamer/subsonic/subsonic.dart';

class Navigation extends StatefulWidget {
  final SubsonicContext subSonicContext;

  const Navigation({super.key, required this.subSonicContext});

  @override
  State<Navigation> createState() => _Navigation();
}

class _Navigation extends State<Navigation> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _children(SubsonicContext context, int index) {
    List<Widget> children = [
      SongsList(subSonicContext: context),
      Home(subSonicContext: context),
      Container(),
      const SettingsPage(),

      // Augusto please add your settings page here
    ];
    return children[index];
  }

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _children(widget.subSonicContext, _selectedTab),
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color.fromARGB(150, 155, 40, 175),
                currentIndex: _selectedTab,
                onTap: (index) => _changeTab(index),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.blue,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: "Search"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Account"),
                ],
              ))),
    );
  }
}
