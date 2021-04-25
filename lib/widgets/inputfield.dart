import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:poultry/config/fieldtype.dart';

class InputField extends StatefulWidget {
  final String name;
  final TextInputType keyboard;
  final FieldType fieldType;
  final bool iconVisible; // for the password field
  final int maxlen;
  InputField({
    @required this.name,
    @required this.keyboard,
    @required this.fieldType,
    this.iconVisible = false,
    this.maxlen,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

bool _hidePassword = true;
Map<FieldType, String> _validatorMsg = {
  FieldType.email: "invalid email",
  FieldType.password: "password must contain at least 6 characters",
  FieldType.phone: "invalid phone number",
  FieldType.name: "* required field"
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
            validator: RequiredValidator(
              errorText: _validatorMsg[widget.fieldType],
            ),
            obscureText: widget.iconVisible ? _hidePassword : false,
            keyboardType: widget.keyboard,
            cursorColor: Colors.green,
            decoration: InputDecoration(
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
