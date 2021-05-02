import 'package:form_field_validator/form_field_validator.dart';
import 'package:poultry/config/enumvals.dart';

// COntains all form field validation messages to be used in inputfield
Map<FieldType, MultiValidator> validatorMsg = {
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
  FieldType.lastName: MultiValidator(
    [
      RequiredValidator(errorText: "last name is a required field"),
    ],
  ),
  FieldType.farmName: MultiValidator(
    [
      RequiredValidator(errorText: "farm name is a required field"),
    ],
  ),
  FieldType.address: MultiValidator(
    [
      RequiredValidator(errorText: "address is a required field"),
    ],
  ),
  FieldType.numberOfBroilers: MultiValidator(
    [
      RequiredValidator(errorText: "*required field"),
      RangeValidator(min: 0, max: 10000, errorText: "10,000 max")
    ],
  ),
  FieldType.numberOfLayers: MultiValidator(
    [
      RequiredValidator(errorText: "*required field"),
      RangeValidator(min: 0, max: 10000, errorText: "10,000 max")
    ],
  ),
  FieldType.lga: MultiValidator(
    [
      RequiredValidator(errorText: "LGA is a required field"),
    ],
  ),
};
