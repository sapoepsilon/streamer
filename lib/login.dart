import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamer/Home.dart';
import 'package:streamer/helpers/helpers.dart';
import 'package:streamer/model/nowPlayingResponse.dart';
import 'package:xml2json/xml2json.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String _name = "";
  String _server = "";
  String _username = "";
  String _password = "";
  bool isRemeberMe = false;
  SharedPreferences? _prefs;

  @override
  void initState() {
    loadPrefs();
    super.initState();
  }

  loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs!.getBool("check") == true) {
      setState(() {
        isRemeberMe = true;
        _name = _prefs!.getString("_name")!;
        _server = _prefs!.getString("_server")!;
        _username = _prefs!.getString("_username")!;
        _password = _prefs!.getString("_password")!;
      });
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openEndDrawer();
        },
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      endDrawer: Drawer(backgroundColor: Color.fromARGB(100, 0, 0, 0),
        child: ListView(children: [
          DrawerHeader(
              child: Image.network(
                  "https://avatars.githubusercontent.com/u/108163041?s=96&v=4"))
        ]),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                  colors: [
                    Colors.teal,
                    Colors.black,
                  ],
                  radius: .8,
                )),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Streamer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 130),
                      rememberMe(),
                      const SizedBox(height: 15),
                      server(),
                      const SizedBox(height: 20),
                      name(),
                      const SizedBox(height: 20),
                      username(),
                      const SizedBox(height: 20),
                      password(),
                      const SizedBox(height: 70),
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

  Widget rememberMe() {
    return Container(
      height: 20,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Theme(
          data: ThemeData(
            unselectedWidgetColor: Color.fromARGB(115, 0, 0, 0),
          ),
          child: Checkbox(
            value: isRemeberMe,
            checkColor: Colors.red,
            activeColor: Color.fromARGB(115, 0, 0, 0),
            onChanged: (value) {
              setState(() {
                isRemeberMe = value!;
                _prefs!.setBool("check", value);
                if (isRemeberMe) {
                  _prefs!.setString("_name", _name);
                  _prefs!.setString("_server", _server);
                  _prefs!.setString("_username", _username);
                  _prefs!.setString("_password", _password);
                }
              });
            },
          ),
        ),
        Text(
          "Remember Me",
          style: TextStyle(
              color: Color.fromARGB(115, 0, 0, 0), fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }

  Widget server() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.datetime,
            onChanged: (value) {
              setState(() {
                _server = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: loginTextDecoration("123.456.789.123"),
          ),
        )
      ],
    );
  }

  Widget password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: loginTextDecoration("Password"),
          ),
        )
      ],
    );
  }

  Widget name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: loginTextDecoration("Name")),
        )
      ],
    );
  }

  Widget username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginTextFieldBackground(),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: loginTextDecoration("Username"),
          ),
        )
      ],
    );
  }

  Widget conect() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _connectToServer,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(80, 60),
            backgroundColor: Colors.purple.shade900,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45))),
        child: const Text(
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

  void _connectToServer() async {
    String random = generateRandomString(7);
    String token = makeToken(_password, random);

    print("Name: $_name");
    print("Server: $_server");
    print("Username: $_username");
    print("Password: $_password");

    const id = 'ab';

    late final folder;
    try {
      folder = await http.get(Uri.parse(
          'http://$_server/rest/getNowPlaying.view?u=$_username&t=$token&s=$random&v=1.61.0&c=streamer'));
    } catch (e) {
      print("Error connecting: $e");
    }

    print("request: ${folder.request}");
    print("Server response: ${folder.request}");

    if (folder.statusCode == 200) {
      final Xml2Json xml2json = Xml2Json();
      xml2json.parse(utf8.decode(folder.bodyBytes));
      final json = xml2json.toGData();
      final nowPlayingResponse = json;
      final NowPlaying nowPlaying = nowPlayingFromJson(nowPlayingResponse);
      debugPrint(nowPlaying.toString());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Home(nowPlaying: nowPlaying)));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load data');
    }
  }
}
