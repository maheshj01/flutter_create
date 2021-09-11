import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/pages/home.dart';
import 'package:flutter_template/utils/settings_controller.dart';
import 'constants/constants.dart' show APP_TITLE;

/// Settings are exposed globally to access from anywhere

late SettingsController settingsController;
void main() {
  settingsController = SettingsController();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: APP_TITLE,
            debugShowCheckedModeBanner: kDebugMode,
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            home: const MyHomePage(title: 'Flutter Template'),
          );
        });
  }
}
