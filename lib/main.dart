import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_create/pages/error.dart';
import 'package:flutter_create/pages/home.dart';
import 'package:flutter_create/pages/login.dart';
import 'package:flutter_create/pages/product_detail.dart';
import 'package:flutter_create/pages/themes/themes.dart';
import 'package:flutter_create/utils/settings_service.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'constants/constants.dart' show appTitle;

/// Settings are exposed globally to access from anywhere

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  Settings.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const MyHomePage(
              title: 'My Home Page',
            ),
          ),
        ),
        GoRoute(
            path: '/product/:id',
            pageBuilder: (BuildContext context, GoRouterState state) {
              final id = state.pathParameters['id'];
              return MaterialPage<void>(
                key: state.pageKey,
                child: ProductDetail(
                  id: id!,
                ),
              );
            }),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: LoginPage(),
          ),
        ),
      ],
      errorPageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage<void>(
          key: state.pageKey,
          child: ErrorPage(errorMessage: state.error.toString()),
        );
      });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Settings(),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            title: appTitle,
            debugShowCheckedModeBanner: kDebugMode,
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],
            theme: AppTheme.lightThemeData,
            darkTheme: AppTheme.darkThemeData,
            themeMode: Settings.getTheme,
            // home: const MyHomePage(title: 'Flutter Template'),
            routeInformationParser: _router.routeInformationParser,
            routeInformationProvider: _router.routeInformationProvider,
            routerDelegate: _router.routerDelegate,
          );
        });
  }
}
