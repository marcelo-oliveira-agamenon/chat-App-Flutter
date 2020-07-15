import 'package:flutter/material.dart';
import 'package:todolist/helper/authenticate.dart';
import 'package:todolist/helper/helperFuncions.dart';
import 'package:todolist/views/chatRooms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn;
  @override
  void initState() {
    super.initState();
  }

  getLoggedInState() async {
    await HelperFuncions.getUserLoggedIn().then((value) {
      setState(() {
        userLoggedIn = value;
      });
    });
  }

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
      home: userLoggedIn != null
          ? userLoggedIn ? ChatRoom() : Authenticate()
          : Authenticate(),
    );
  }
}
