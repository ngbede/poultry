import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/screens/layout.dart';
import 'package:poultry/screens/onboarding_ui/login.dart';
import 'package:poultry/providers/user_prov.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/toast.dart';
import 'package:poultry/widgets/user_role_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class Signup extends StatelessWidget {
  final _signupFormKey = GlobalKey<FormState>();
  final Map<UserType, String> _roleStr = {
    UserType.farmer: "farmer",
    UserType.distributor: "distributor"
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Form(
              key: _signupFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, top: 20),
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
                    maxlen: 11,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "User Role",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      //textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserRole(
                        name: "Farmer",
                        valueProp: UserType.farmer,
                      ),
                      UserRole(
                        name: "Distributor",
                        valueProp: UserType.distributor,
                      ),
                    ],
                  ),
                  InputField(
                    name: "Password",
                    iconVisible: true,
                    keyboard: TextInputType.visiblePassword,
                    fieldType: FieldType.password,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // print("${_signupFormKey.currentState.validate()}");
                      if (_signupFormKey.currentState.validate()) {
                        final _progress = ProgressHUD.of(context);
                        _progress.showWithText("Creating account...");
                        try {
                          final UserCredential _user =
                              await auth.createUserWithEmailAndPassword(
                            email: Provider.of<UserProv>(context, listen: false)
                                .email,
                            password:
                                Provider.of<UserProv>(context, listen: false)
                                    .password,
                          );
                          if (_user != null) {
                            await store
                                .collection("users")
                                .doc(auth.currentUser.uid)
                                .set(
                              {
                                "email": Provider.of<UserProv>(
                                  context,
                                  listen: false,
                                ).email,
                                "userId": _user.user.uid,
                                "firstName": Provider.of<UserProv>(
                                  context,
                                  listen: false,
                                ).firstName,
                                "lastName": Provider.of<UserProv>(
                                  context,
                                  listen: false,
                                ).lastname,
                                "userRole": _roleStr[Provider.of<UserProv>(
                                        context,
                                        listen: false)
                                    .role],
                                "phoneNumber": Provider.of<UserProv>(
                                  context,
                                  listen: false,
                                ).phoneNumber,
                              },
                            );
                            _progress.dismiss();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Layout(),
                              ),
                            );
                            print("Signup successful");
                          }
                        } on FirebaseAuthException catch (e) {
                          _progress.dismiss();
                          toaster(e.code);
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Card(
                        color: Color(0XFF35D4C0),
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
        ),
      ),
    );
  }
}
