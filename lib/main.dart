import 'package:flutter/material.dart';
import 'package:to_do_app/pages/home.dart';
import 'package:to_do_app/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.deepOrangeAccent)),
    initialRoute: '/',
    routes: {
      '/': (context) => const MainScreen(),
      '/todo': (context) => const Home(),
    },
  ));
}
