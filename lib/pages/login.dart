import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                if (settingsController.themeMode == ThemeMode.dark) {
                  settingsController.updateThemeMode(ThemeMode.light);
                } else {
                  settingsController.updateThemeMode(ThemeMode.dark);
                }
                setState(() {});
              },
              child: Text('ToggleTheme'))
        ],
      ),
    );
  }
}
