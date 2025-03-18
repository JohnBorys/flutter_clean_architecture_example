import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_example/core/services/injection_container.dart';
import 'package:flutter_clean_architecture_example/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
