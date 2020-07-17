import 'package:flutter/material.dart';
import 'package:todolist/helper/authenticate.dart';
import 'package:todolist/helper/constants.dart';
import 'package:todolist/helper/helperFuncions.dart';
import 'package:todolist/services/auth.dart';
import 'package:todolist/services/database.dart';
import 'package:todolist/views/conversation.dart';
import 'package:todolist/views/searchScreen.dart';
import 'package:todolist/widgets/widgets.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  Widget chatRoomStreamBuilder() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    username: snapshot.data.documents[index].data["chatRoomId"]
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFuncions.getUsername();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatRoomStreamBuilder(),
      appBar: AppBar(
        title: Text("asdsas"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authenticate(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
        },
        child: Icon(
          Icons.search,
        ),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String username;
  final String chatRoomId;
  ChatRoomsTile({this.username, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConversationScreen(
                chatRoomId: chatRoomId,
              ),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${username.substring(0, 1).toUpperCase()}",
                style: mediumTextFieldStyle(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                username,
                style: mediumTextFieldStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
