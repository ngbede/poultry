class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
  });

  @override
  String toString() {
    return "Lastname: $lastName\nFirstName: $firstName\nEmail: $email\nPhone Number: $phoneNumber";
  }
}
