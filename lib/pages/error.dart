import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  const ErrorPage({super.key, this.errorMessage = "Error 404 not found"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            child: const Text('Go Home'), onPressed: () => context.go('/')),
      ),
    );
  }
}
