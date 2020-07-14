import 'package:flutter/material.dart';
import 'package:todolist/services/auth.dart';
import 'package:todolist/widgets/widgets.dart';
import 'package:todolist/views/chatRooms.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  TextEditingController userNameText = new TextEditingController();
  TextEditingController emailText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();

  signInUpFunc() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }

    authMethods.signUp(emailText.text, passwordText.text).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
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
                                return value.isEmpty || value.length < 3
                                    ? "Error in username field"
                                    : null;
                              },
                              controller: userNameText,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration("Username"),
                            ),
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
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          signInUpFunc();
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
                            "Sign Up",
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
                          "Sign Up with Google",
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
                            "Already have a account? ",
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
                                "Sign In now",
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
