import 'package:admin_msar/firebase_options.dart';
import 'package:admin_msar/src/core/app/app.dart';
import 'package:admin_msar/src/core/di/injector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupInjector();
  runApp(const AdminMsarApp());
}
