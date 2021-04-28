import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poultry/config/fieldtype.dart';
import 'package:poultry/login.dart';
import 'package:poultry/provider/user_prov.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _signupFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _signupFormKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20),
                child: Text(
                  "Create your account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              InputField(
                name: "First name",
                keyboard: TextInputType.text,
                fieldType: FieldType.firstName,
                //onSaved: ,
              ),
              InputField(
                name: "Last name",
                keyboard: TextInputType.text,
                fieldType: FieldType.lastName,
              ),
              InputField(
                name: "Email address",
                keyboard: TextInputType.emailAddress,
                fieldType: FieldType.email,
              ),
              InputField(
                name: "Phone number",
                keyboard: TextInputType.phone,
                fieldType: FieldType.phone,
              ),
              InputField(
                name: "Password",
                iconVisible: true,
                keyboard: TextInputType.visiblePassword,
                fieldType: FieldType.password,
              ),
              // TODO: add spinner to button to indicate loading
              GestureDetector(
                onTap: () async {
                  print("${_signupFormKey.currentState.validate()}");
                  if (_signupFormKey.currentState.validate()) {
                    print("valid shit");
                    try {
                      final UserCredential _user =
                          await _auth.createUserWithEmailAndPassword(
                        email:
                            Provider.of<UserProv>(context, listen: false).email,
                        password: Provider.of<UserProv>(context, listen: false)
                            .password,
                      );
                      if (_user != null) {
                        print("Signup successful");
                        //TODO: Implement Firestore storage here and navigate to further onboarding for farm details
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
                        "Sign up",
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
                    "Already have an account?",
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
                          builder: (context) => Login(),
                        ),
                      );
                      print("Navigate to Log in Screen");
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
