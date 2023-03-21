// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:streamer/helpers/custom_models/credentials_model.dart';
import 'package:streamer/helpers/globals.dart';
import 'package:streamer/helpers/helpers.dart';
import 'package:streamer/pages/songs_list.dart';
import 'package:streamer/subsonic/context.dart';
import 'package:streamer/subsonic/requests/ping.dart';
import 'package:streamer/subsonic/response.dart';
import 'package:streamer/utils/shared_preferences.dart';

import 'playlist.dart';

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
  bool shouldSaveCredentials = false;
  List<Credentials> savedCredentials = [];

  @override
  void initState() {
    super.initState();
    initCredentials();
  }

  void initCredentials() async {
    await checkCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    final screenSize = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return PlatformScaffold(
      material: (context, platform) {
        return MaterialScaffoldData(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.menu),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          endDrawer: Drawer(
            backgroundColor: const Color.fromARGB(100, 0, 0, 0),
            child: DrawerHeader(
              child: ListView.builder(
                  itemCount: savedCredentials.length,
                  itemBuilder: (context, index) {
                    return Text(savedCredentials[index].name);
                  }),
            ),
          ),
        );
      },
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
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PlatformText(
                      "Streamer",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.15,
                    ),
                    field(isTablet, screenSize, _server,
                        "http://192.168.0.34:4533", _getServerValueText),
                    textFieldSpacer(screenSize),
                    field(
                        isTablet, screenSize, _name, "Name", _getNameValueText),
                    textFieldSpacer(screenSize),
                    field(isTablet, screenSize, _username, "Username",
                        _getUsernameValueText),
                    textFieldSpacer(screenSize),
                    field(isTablet, screenSize, _password, "Password",
                        _getPasswordValueText, true),
                    textFieldSpacer(screenSize),
                    rememberMe(isTablet, screenSize),
                    connect(isTablet, screenSize)
                    // buildforgotPassBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkCredentials() async {
    if (await getBool(isLoggedInKey)) {
      savedCredentials = await getCredentials() ?? [];
      for (var element in savedCredentials) {
        setState(() {
          _name = element.name;
          _username = element.username;
          _password = element.password;
          _server = element.server;
        });
      }
      debugPrint(_name);
      debugPrint(_username);
      debugPrint(_password);
      _connectToServer();
    }
  }

  void _connectToServer() async {
    // ignore: unused_local_variable
    debugPrint("server: $_server");
    String errorMessage = "";
    final ctx = SubsonicContext(
        serverId: "Docker",
        name: _name,
        endpoint: Uri.parse(_server),
        user: _username,
        pass: _password);

    var pong = await Ping().run(ctx).catchError((err) {
      debugPrint('error: network issue? $err');
      errorMessage = err.toString();
      return Future.value(SubsonicResponse(
        ResponseStatus.failed,
        "Network issue",
        '',
      ));
    });

    if (pong.status == ResponseStatus.ok) {
      saveCredentials(Credentials(
          name: _name,
          username: _username,
          password: _password,
          server: _server));
      // ignore: todo
      // TODO: move methods with context out of Async method
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(platformPageRoute(
          builder: (context) => SongsList(subSonicContext: ctx),
          // ignore: todo
          context: context)); //TODO: do not use Navigator in async method
    } else {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, errorMessage);
    }
  }

  void _getServerValueText(String value) {
    setState(() {
      _server = value;
    });
  }

  void _getNameValueText(String value) {
    setState(() {
      _name = value;
    });
  }

  void _getUsernameValueText(String value) {
    setState(() {
      _username = value;
    });
  }

  void _getPasswordValueText(String value) {
    setState(() {
      _password = value;
    });
  }

  Widget field(bool isTablet, Size screenSize, String userValue, hintText,
      Function function,
      [bool? isPassword]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: isTablet ? 500 : screenSize.width * 0.8,
            decoration: loginTextFieldBackground(),
            child: PlatformTextFormField(
              initialValue: userValue,
              material: (context, platform) {
                return MaterialTextFormFieldData(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                );
              },
              obscureText: isPassword ?? false,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                function(value);
              },
              hintText: hintText,
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  Widget connect(bool isTablet, Size screenSize) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: isTablet ? 500 : screenSize.width * 0.8,
      child: PlatformElevatedButton(
        material: (context, platform) {
          return MaterialElevatedButtonData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              fixedSize: const Size(80, 60),
            ),
          );
        },
        onPressed: _connectToServer,
        child: const Text(
          "Connect",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textFieldSpacer(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.05,
    );
  }

  Widget rememberMe(bool isTablet, Size screenSize) {
    return SizedBox(
      height: 20,
      width: isTablet ? 500 : screenSize.width * 0.8,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        const Text(
          "Remember Me",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        PlatformSwitch(
          value: shouldSaveCredentials,
          onChanged: (value) {
            setState(() {
              shouldSaveCredentials = value;
              saveUser(isLoggedInKey, shouldSaveCredentials);
              if (shouldSaveCredentials) {
                saveCredentials(Credentials(
                    name: _name,
                    username: _username,
                    password: _password,
                    server: _server));
              }
            });
          },
        ),
      ]),
    );
  }
}
