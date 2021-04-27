import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:poultry/config/fieldtype.dart';
import 'package:poultry/models/user.dart';
import 'package:poultry/provider/user_prov.dart';
import 'package:provider/provider.dart';

// TODO: fix autochecking of fields
class InputField extends StatefulWidget {
  final String name;
  final TextInputType keyboard;
  final Function onSaved;
  final FieldType fieldType;
  final bool iconVisible; // for the password field
  final int maxlen;
  InputField({
    @required this.name,
    @required this.keyboard,
    @required this.fieldType,
    this.onSaved,
    this.iconVisible = false,
    this.maxlen,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

bool _hidePassword = true;
Map<FieldType, MultiValidator> _validatorMsg = {
  FieldType.email: MultiValidator(
    [
      RequiredValidator(errorText: "email is a required field"),
      EmailValidator(errorText: "invalid email"),
    ],
  ),
  FieldType.password: MultiValidator(
    [
      RequiredValidator(errorText: "password is a required field"),
      MinLengthValidator(6,
          errorText: "password must be at least 6 digits long"),
    ],
  ),
  FieldType.phone: MultiValidator(
    [
      RequiredValidator(errorText: "phone number is a required field"),
      MinLengthValidator(11, errorText: "phone number must be 11 digits long"),
    ],
  ),
  FieldType.firstName: MultiValidator(
    [
      RequiredValidator(errorText: "first name is a required field"),
    ],
  ),
  FieldType.lastName: MultiValidator([
    RequiredValidator(errorText: "last name is a required field"),
  ]),
};

class _InputFieldState extends State<InputField> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.name,
              style: TextStyle(fontWeight: FontWeight.bold),
              //textAlign: TextAlign.left,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, top: 5, bottom: 20),
          child: TextFormField(
            controller: _controller,
            validator: _validatorMsg[widget.fieldType],
            onChanged: (value) {
              Provider.of<UserProv>(context, listen: false).getInfo();
              if (FieldType.firstName == widget.fieldType) {
                Provider.of<UserProv>(context, listen: false)
                    .setFirstName(value);
              } else if (FieldType.lastName == widget.fieldType) {
                Provider.of<UserProv>(context, listen: false)
                    .setLastName(value);
              } else if (FieldType.email == widget.fieldType) {
                Provider.of<UserProv>(context, listen: false).setEmail(value);
              } else if (FieldType.phone == widget.fieldType) {
                Provider.of<UserProv>(context, listen: false)
                    .setPhoneNumber(value);
              }
            }, // use on saved prop to trigger submission to firebase
            maxLength: FieldType.phone == widget.fieldType ? 11 : null,
            obscureText: widget.iconVisible ? _hidePassword : false,
            keyboardType: widget.keyboard,
            cursorColor: Colors.green,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelStyle: TextStyle(
                color: Color(0XFF777180),
                height: 0.8,
                fontSize: 20,
              ),
              suffixIcon: widget.iconVisible
                  ? GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _hidePassword = !_hidePassword;
                            print("Hide password: $_hidePassword");
                          },
                        );
                      },
                      child: _hidePassword
                          ? Icon(
                              FluentIcons.eye_hide_24_regular,
                              color: Colors.black,
                            )
                          : Icon(
                              FluentIcons.eye_show_24_regular,
                              color: Colors.teal,
                            ),
                    )
                  : null,
              fillColor: Color(0XFFEAE9EB),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
