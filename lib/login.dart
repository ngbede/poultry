import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poultry/config/fieldtype.dart';
import 'package:poultry/provider/user_prov.dart';
import 'package:poultry/signup.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _signinFormkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
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
                    try {
                      final UserCredential _user =
                          await _auth.signInWithEmailAndPassword(
                        email:
                            Provider.of<UserProv>(context, listen: false).email,
                        password: Provider.of<UserProv>(context, listen: false)
                            .password,
                      );
                      if (_user != null) {
                        // TODO: navigate to app menu
                        print("Sign in successful");
                      }
                    } catch (e) {
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
    );
  }
}
