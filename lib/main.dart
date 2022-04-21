import 'package:flutter/material.dart';
import 'package:shohay/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); //constructor

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shohay',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const Welcome(),
    );
  }
}
