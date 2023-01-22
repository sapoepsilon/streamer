import 'package:flutter/services.dart';
import 'package:flutter/material.dart'
    show
        Alignment,
        AlwaysScrollableScrollPhysics,
        AnnotatedRegion,
        BorderRadius,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Color,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        GestureDetector,
        Icon,
        Icons,
        InputBorder,
        InputDecoration,
        MainAxisAlignment,
        Offset,
        RadialGradient,
        RoundedRectangleBorder,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        Stack,
        State,
        StatefulWidget,
        Text,
        TextField,
        TextInputType,
        TextStyle,
        Widget;

class login extends StatefulWidget {
  @override
  _login createState() => _login();
}

Widget server() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // Text(
      //   "Server",
      //   style: TextStyle(
      //       color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      // ),
      // SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, .5),
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.search, color: Color(0xFFA51C1C)),
              hintText: "123.456.789.123",
              hintStyle: TextStyle(color: Color.fromARGB(156, 255, 255, 255))),
        ),
      )
    ],
  );
}

Widget password() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // Text(
      //   "Password",
      //   style: TextStyle(
      //       color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      // ),
      // SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, .5),
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.lock, color: Color(0xFFA51C1C)),
              hintText: "Password",
              hintStyle: TextStyle(color: Color.fromARGB(156, 255, 255, 255))),
        ),
      )
    ],
  );
}

Widget name() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // Text(
      //   "Name",
      //   style: TextStyle(
      //       color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      // ),
      // SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, .5),
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon:
                  Icon(Icons.perm_contact_cal, color: Color(0xFFA51C1C)),
              hintText: "Name",
              hintStyle: TextStyle(color: Color.fromARGB(156, 255, 255, 255))),
        ),
      )
    ],
  );
}

Widget username() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // Text(
      //   "UserName",
      //   style: TextStyle(
      //       color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      // ),
      // SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.498),
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.supervised_user_circle_rounded,
                  color: Color(0xFFA51C1C)),
              hintText: "UserName",
              hintStyle: TextStyle(color: Color.fromARGB(156, 255, 255, 255))),
        ),
      )
    ],
  );
}

Widget conect() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => print("Login Pressed"),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(80, 60),
          backgroundColor: Colors.purple.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45))),
      child: Text(
        "Conect",
        style: TextStyle(
          color: Color.fromARGB(222, 24, 167, 214),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

class _login extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //       // begin: Alignment.topCenter,
                    //       // end: Alignment.bottomCenter,
                    //       colors: [
                    //     Color.fromRGBO(81, 226, 209, 0.39),
                    //     Color.fromRGBO(81, 226, 209, 0.39),
                    //     Color.fromRGBO(81, 226, 209, 0.39),
                    //     Color.fromRGBO(81, 226, 209, 0.39),
                    //     Color.fromRGBO(81, 226, 209, 0.39),
                    //   ]
                    // )
                    gradient: RadialGradient(
                  colors: [
                    Colors.teal,
                    Colors.black,
                  ],
                  radius: .8,
                )),
                child: SingleChildScrollView(
                  // physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Streamer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 130),
                      server(),
                      SizedBox(height: 20),
                      name(),
                      SizedBox(height: 20),
                      username(),
                      SizedBox(height: 20),
                      password(),
                      SizedBox(height: 70),
                      conect()
                      // buildforgotPassBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
