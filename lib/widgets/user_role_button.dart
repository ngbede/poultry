import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/providers/user_prov.dart';
import 'package:provider/provider.dart';

class UserRole extends StatelessWidget {
  final String name;
  final valueProp;
  UserRole({
    @required this.name,
    @required this.valueProp,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text(name),
        leading: Radio<UserType>(
          value: valueProp,
          activeColor: Color(0XFF35D4C0),
          groupValue: Provider.of<UserProv>(context).role,
          onChanged: (UserType value) {
            Provider.of<UserProv>(context, listen: false).setUserRole(
              value,
            );
          },
        ),
      ),
    );
  }
}
