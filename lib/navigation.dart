import 'package:flutter/material.dart';
import 'package:streamer/home.dart';
import 'package:streamer/songs_list.dart';
import 'package:streamer/playlist.dart';
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
      PlaylistList(ctx: context),
      Home(subSonicContext: context),
      // Augusto please add your settings page here
    ];
    if (index < 3) {
      return children[index];
    } else {
      return children[0];
    }
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue,
        items: const [
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
