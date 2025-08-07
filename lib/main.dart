import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/firebase_options.dart';
import 'package:first_app/gina_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();

  runApp(const GinaApp());
}
