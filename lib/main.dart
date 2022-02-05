import 'package:flutter/material.dart';
import 'package:to_do_app/pages/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.deepOrangeAccent)),
    home: const Home(),
  ));
}
