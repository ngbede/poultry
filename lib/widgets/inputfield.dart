import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/validatormsgs.dart';
import 'package:poultry/providers/birds_prov.dart';
import 'package:poultry/providers/farm_prov.dart';
import 'package:poultry/providers/order_prov.dart';
import 'package:poultry/providers/price_prov.dart';
import 'package:poultry/providers/user_prov.dart';
import 'package:poultry/providers/egg_prov.dart';
import 'package:provider/provider.dart';

class InputField extends StatefulWidget {
  final String name;
  final TextInputType keyboard;
  final Function onSaved;
  final bool validateField;
  final FieldType fieldType;
  final bool iconVisible; // for the password field
  final int maxlen;
  final double fontSize;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;
  final int maxLine;
  InputField({
    this.name,
    @required this.keyboard,
    @required this.fieldType,
    this.onSaved,
    this.validateField = true,
    this.iconVisible = false,
    this.maxlen,
    this.leftPadding = 20.0,
    this.rightPadding = 20.0,
    this.bottomPadding = 20.0,
    this.topPadding = 5.0,
    this.fontSize,
    this.maxLine = 1,
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
        widget.fieldType == FieldType.eggsCollected ||
                widget.fieldType == FieldType.badEggs ||
                widget.fieldType == FieldType.batchQuantity ||
                widget.fieldType == FieldType.batchName ||
                widget.fieldType == FieldType.deadBirds ||
                widget.fieldType == FieldType.comment
            ? SizedBox(
                height: 0,
              )
            : Padding(
                padding: EdgeInsets.only(
                  left: widget.leftPadding,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: widget.fontSize),
                    //textAlign: TextAlign.left,
                  ),
                ),
              ),
        Padding(
          padding: EdgeInsets.only(
            left: widget.leftPadding,
            right: widget.rightPadding,
            top: widget.topPadding,
            bottom: widget.bottomPadding,
          ),
          child: TextFormField(
            // autofocus: true,
            controller: _controller,
            validator: widget.validateField
                ? MultiValidator(
                    errorMessages(widget.fieldType, widget.name.toLowerCase()),
                  )
                : null,
            onChanged: (value) {
              if (FieldType.name == widget.fieldType) {
                Provider.of<UserProv>(context, listen: false).setName(value);
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
              } else if (FieldType.eggsCollected == widget.fieldType) {
                if (value.isEmpty) {
                  Provider.of<EggProv>(context, listen: false).setEggsCollected(
                    0,
                  );
                  Provider.of<EggProv>(context, listen: false).setGoodEggs();
                } else {
                  Provider.of<EggProv>(context, listen: false).setEggsCollected(
                    int.tryParse(value),
                  );
                  Provider.of<EggProv>(context, listen: false).setGoodEggs();
                }
              } else if (FieldType.badEggs == widget.fieldType) {
                if (value.isEmpty) {
                  Provider.of<EggProv>(context, listen: false).setBadEggs(0);
                  Provider.of<EggProv>(context, listen: false).setGoodEggs();
                } else {
                  Provider.of<EggProv>(context, listen: false).setBadEggs(
                    int.tryParse(value),
                  );
                  Provider.of<EggProv>(context, listen: false).setGoodEggs();
                }
              } else if (FieldType.batchName == widget.fieldType) {
                Provider.of<BirdsProv>(context, listen: false)
                    .setBatchName(value);
              } else if (FieldType.batchQuantity == widget.fieldType) {
                Provider.of<BirdsProv>(context, listen: false).setQuantity(
                  int.tryParse(value),
                );
              } else if (FieldType.customerName == widget.fieldType) {
                Provider.of<OrderProv>(context, listen: false)
                    .setCustomerName(value);
              } else if (FieldType.customerAddress == widget.fieldType) {
                Provider.of<OrderProv>(context, listen: false)
                    .setCustomerAddress(value);
              } else if (FieldType.customerContact == widget.fieldType) {
                Provider.of<OrderProv>(context, listen: false)
                    .setCustomerContact(value);
              } else if (FieldType.crateOfEggPrice == widget.fieldType) {
                if (value.isEmpty) {
                  Provider.of<PriceProv>(context, listen: false)
                      .setCrateOfEggPrice(0);
                } else {
                  Provider.of<PriceProv>(context, listen: false)
                      .setCrateOfEggPrice(
                    double.tryParse(value),
                  );
                }
              } else if (FieldType.chickenPrice == widget.fieldType) {
                if (value.isEmpty) {
                  Provider.of<PriceProv>(context, listen: false)
                      .setChickenPrice(0);
                } else {
                  Provider.of<PriceProv>(context, listen: false)
                      .setChickenPrice(
                    double.tryParse(value),
                  );
                }
              } else if (FieldType.deadBirds == widget.fieldType) {
                if (value.isEmpty) {
                  Provider.of<BirdsProv>(context, listen: false)
                      .setDeadBirds(0);
                } else {
                  Provider.of<BirdsProv>(context, listen: false).setDeadBirds(
                    int.tryParse(value),
                  );
                }
                Provider.of<BirdsProv>(context, listen: false).setBirdsAlive();
              } else if (FieldType.comment == widget.fieldType) {
                Provider.of<BirdsProv>(context, listen: false)
                    .setComment(value);
              }
            },
            maxLength: widget.maxlen,
            maxLines: widget.maxLine,
            obscureText: widget.iconVisible ? _hidePassword : false,
            keyboardType: widget.keyboard,
            cursorColor: widget.fieldType == FieldType.badEggs
                ? Colors.red
                : Colors.green,
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
                              color: Color(0XFF35D4C0),
                            ),
                    )
                  : null,
              fillColor: Color(0XFFEAE9EB),
              filled: true,
              focusedBorder: widget.fieldType == FieldType.eggsCollected ||
                      widget.fieldType == FieldType.badEggs ||
                      widget.fieldType == FieldType.batchQuantity ||
                      widget.fieldType == FieldType.batchName ||
                      widget.fieldType == FieldType.deadBirds
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.fieldType == FieldType.badEggs ||
                                widget.fieldType == FieldType.deadBirds
                            ? Colors.red
                            : Colors.green,
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFF35D4C0),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
