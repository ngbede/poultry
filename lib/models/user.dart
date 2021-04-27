class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;

  User({this.firstName, this.lastName, this.email, this.phoneNumber});

  @override
  String toString() {
    return "Lastname: $lastName\nFirstName: $firstName\nEmail: $email\nPhone Number: $phoneNumber";
  }
}
