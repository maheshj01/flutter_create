// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../env/env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: .env
final class _Env {
  static const List<int> _enviedkeymyEnvironmentVariable = <int>[
    3938881308,
    318714186,
    372146411,
    2434717720,
    2997693663,
  ];

  static const List<int> _envieddatamyEnvironmentVariable = <int>[
    3938881386,
    318714155,
    372146311,
    2434717805,
    2997693626,
  ];

  static final String myEnvironmentVariable = String.fromCharCodes(
    List<int>.generate(
      _envieddatamyEnvironmentVariable.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddatamyEnvironmentVariable[i] ^ _enviedkeymyEnvironmentVariable[i]),
  );
}
