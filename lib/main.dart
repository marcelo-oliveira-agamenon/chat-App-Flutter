import 'package:flutter/material.dart';
import 'package:todolist/helper/authenticate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff145C9E),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xff1F1F1f),
      ),
      home: Authenticate(),
    );
  }
}
