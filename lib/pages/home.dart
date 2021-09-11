import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/pages/login.dart';
import 'package:flutter_template/utils/navigator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Switch(
                value: settingsController.themeMode == ThemeMode.dark,
                onChanged: (z) {
                  if (settingsController.themeMode == ThemeMode.dark) {
                    settingsController.updateThemeMode(ThemeMode.light);
                  } else {
                    settingsController.updateThemeMode(ThemeMode.dark);
                  }
                }),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'something',
              onPressed: () async {
                navigate(context, const LoginPage());
              },
              tooltip: 'Navigate',
              child: const Icon(Icons.navigate_next),
            ),
          ],
        ));
  }
}
