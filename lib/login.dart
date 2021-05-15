import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/providers/user_prov.dart';
import 'package:poultry/signup.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'config/firebase.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _signinFormkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          barrierEnabled: true,
          child: Builder(
            builder: (context) => Form(
              key: _signinFormkey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      bottom: 20.0,
                      top: 20.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login to your account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  InputField(
                    name: "Email",
                    keyboard: TextInputType.emailAddress,
                    fieldType: FieldType.email,
                  ),
                  InputField(
                    name: "Password",
                    keyboard: TextInputType.visiblePassword,
                    iconVisible: true,
                    fieldType: FieldType.password,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_signinFormkey.currentState.validate()) {
                        final _progress = ProgressHUD.of(context);
                        _progress.showWithText("Logging in...");
                        await Future.delayed(
                            Duration(seconds: 5)); // simulate progress
                        try {
                          final UserCredential _user =
                              await auth.signInWithEmailAndPassword(
                            email: Provider.of<UserProv>(context, listen: false)
                                .email,
                            password:
                                Provider.of<UserProv>(context, listen: false)
                                    .password,
                          );
                          if (_user != null) {
                            // TODO: navigate to app menu
                            _progress.dismiss();
                            print("Sign in successful");
                          }
                        } on FirebaseAuthException catch (e) {
                          _progress.dismiss();
                          Fluttertoast.showToast(
                            msg: "${e.code}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.teal,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Card(
                        color: Colors.green[400],
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Are you a new user?",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup(),
                            ),
                          );
                          print("Navigate to Sign up Screen");
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
