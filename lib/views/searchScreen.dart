import 'package:flutter/material.dart';
import 'package:todolist/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextField(),
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
