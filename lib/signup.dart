import 'package:flutter/material.dart';
import 'package:poultry/config/fieldtype.dart';
import 'package:poultry/login.dart';
import 'package:poultry/widgets/inputfield.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formkey,
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
                fieldType: FieldType.name,
              ),
              InputField(
                name: "Last name",
                keyboard: TextInputType.text,
                fieldType: FieldType.name,
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
              Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}
