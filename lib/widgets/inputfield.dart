import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/validatormsgs.dart';
import 'package:poultry/providers/farm_prov.dart';
import 'package:poultry/providers/user_prov.dart';
import 'package:provider/provider.dart';

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
            validator: validatorMsg[widget.fieldType],
            onChanged: (value) {
              //Provider.of<UserProv>(context, listen: false).getInfo();
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
              } else if (FieldType.password == widget.fieldType) {
                Provider.of<UserProv>(context, listen: false)
                    .setPassword(value);
              } else if (FieldType.farmName == widget.fieldType) {
                Provider.of<FarmProv>(context, listen: false)
                    .serFarmName(value);
              } else if (FieldType.address == widget.fieldType) {
                Provider.of<FarmProv>(context, listen: false).setAddress(value);
              } else if (FieldType.numberOfBroilers == widget.fieldType) {
                Provider.of<FarmProv>(context, listen: false).setBroilerCount(
                  value,
                );
              } else if (FieldType.numberOfLayers == widget.fieldType) {
                Provider.of<FarmProv>(context, listen: false).setLayerCount(
                  value,
                );
              } else if (FieldType.lga == widget.fieldType) {
                Provider.of<FarmProv>(context, listen: false).setLGA(
                  value,
                );
              }
            },
            maxLength: widget.maxlen,
            obscureText: widget.iconVisible ? _hidePassword : false,
            keyboardType: widget.keyboard,
            cursorColor: Colors.green,
            inputFormatters: (TextInputType.number == widget.keyboard)
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
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
