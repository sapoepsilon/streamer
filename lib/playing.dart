import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    Icons.arrow_back,
                  )),
              Text("Now Playing"),
              IconButton(onPressed: (() {}), icon: Icon(Icons.favorite)),
              IconButton(onPressed: (() {}), icon: Icon(Icons.menu))
            ],
          ),
        ],
      ),
    );
  }
}
