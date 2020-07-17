import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/helper/helperFuncions.dart';
import 'package:todolist/services/auth.dart';
import 'package:todolist/services/database.dart';
import 'package:todolist/views/chatRooms.dart';
import 'package:todolist/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();
  bool isLoading = false;
  QuerySnapshot querySnap;

  signin() {
    if (formKey.currentState.validate()) {
      HelperFuncions.saveEmail(emailText.text);
      databaseMethods.getUserByUserEmail(emailText.text).then((value) {
        querySnap = value;
        HelperFuncions.saveUsername(querySnap.documents[0].data["name"]);
      });

      setState(() {
        isLoading = true;
      });

      authMethods.signIn(emailText.text, passwordText.text).then((value) {
        if (value != null) {
          HelperFuncions.saveUserLoggedIn(true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 90,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty || !value.contains("@")
                              ? "Error in email field"
                              : null;
                        },
                        controller: emailText,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration("Email"),
                      ),
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty || value.length < 6
                              ? "Error in password field"
                              : null;
                        },
                        obscureText: true,
                        controller: passwordText,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: simpleTextFieldStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    signin();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC),
                      ]),
                    ),
                    child: Text(
                      "Sign In",
                      style: mediumTextFieldStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have a account? ",
                      style: mediumTextFieldStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
