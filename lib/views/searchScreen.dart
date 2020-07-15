import 'package:flutter/material.dart';
import 'package:todolist/services/database.dart';
import 'package:todolist/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchText = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnap;

  Widget searchList() {
    return searchSnap != null
        ? ListView.builder(
            itemCount: searchSnap.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                username: searchSnap.documents[index].data["name"],
                email: searchSnap.documents[index].data["email"],
              );
            },
          )
        : Container();
  }

  initSearch() {
    databaseMethods.getUserByUsername(searchText.text).then((val) {
      setState(() {
        searchSnap = val;
      });
    });
  }

  createChatRoom(String username) {
    List<String> users = [searchText.text, username];
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Color(0x54FFFFFFF),
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initSearch();
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0x36FFFFFF),
                            const Color(0x0FFFFFFF)
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String username;
  final String email;

  SearchTile({this.email, this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                username,
                style: simpleTextFieldStyle(),
              ),
              Text(
                email,
                style: simpleTextFieldStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Message",
                style: mediumTextFieldStyle(),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
