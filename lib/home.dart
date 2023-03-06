// ignore_for_file: invalid_return_type_for_catch_error, prefer_typing_uninitialized_variables, unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:streamer/pages/Songs_List.dart';
import 'package:streamer/player.dart';
import 'package:streamer/search.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.subSonicContext});

  final subSonicContext;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _buildBottomNavigationBar(),
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.teal,
              Colors.black,
            ],
            radius: 0.8,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                // ignore: prefer_const_constructors
                offset: Offset(0, 150),
                // ignore: prefer_const_constructors
                child: Text(
                  "Hello ",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                // ignore: prefer_const_constructors
                offset: Offset(0, 155),
                // ignore: prefer_const_constructors
                child: Text(
                  "What do you want to listen today?",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            //Search bar here(Delete after actually having one)
            Container(
              alignment: Alignment.center,
              child: Transform.translate(
                // ignore: prefer_const_constructors
                offset: Offset(0, 220),
                // ignore: prefer_const_constructors
                child: Text(
                  "Search bar here ",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //Album Slide here(Delete after actually having one)
            Container(
              alignment: Alignment.center,
              child: Transform.translate(
                // ignore: prefer_const_constructors
                offset: Offset(0, 260),
                // ignore: prefer_const_constructors
                child: Text(
                  "Album slide",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // buildforgotPassBtn(),
          ],
        ),
      ),
    );
  }

  BottomAppBar _buildBottomNavigationBar() {
    return BottomAppBar(
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 40,
            ),
            //color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
              size: 40,
            ),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(platformPageRoute(
                  builder: (context) => SongsList(subSonicContext: widget.subSonicContext),
                  // ignore: todo
                  context: context));
            },
            icon: Icon(
              isCupertino(context) ? CupertinoIcons.heart : Icons.hearing_sharp,
              color: Colors.white,
              size: 40,
            ),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outlined,
              color: Colors.white,
              size: 40,
            ),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
