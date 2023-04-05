import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:streamer/utils/service_locator.dart';
import 'audio_handler.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => PlatformApp(
        cupertino: (context, platform) {
          return CupertinoAppData(
            theme: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(),
            ),
          );
        },
        material: (context, platform) {
          return MaterialAppData(
             theme: ThemeData(
             primarySwatch: Colors.blue,
              scaffoldBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
    ),
          );
        },
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Platform Widgets',
        home: const Login(),
      ),
    );
  }
}
