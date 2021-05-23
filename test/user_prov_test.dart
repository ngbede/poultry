import 'package:poultry/config/enumvals.dart';
import 'package:poultry/providers/egg_prov.dart';
import 'package:test/test.dart';
import 'package:poultry/providers/user_prov.dart';

void main() {
  test("Test UserProv class...", () {
    UserProv user = UserProv();
    user.setFirstName("Emmanuel");
    user.setEmail("fake@gmail.com");
    user.setLastName("Sule");
    user.setPassword("password");
    user.setPhoneNumber("08012345678");
    user.setUserRole(UserType.farmer);
    expect(
      user.firstName,
      equals("Emmanuel"),
    );
    expect(
      user.lastname,
      equals("Sule"),
    );
    expect(
      user.email,
      equals("fake@gmail.com"),
    );
    expect(
      user.password,
      equals("password"),
    );
    expect(
      user.phoneNumber,
      equals("08012345678"),
    );
    expect(
      user.role,
      equals(UserType.farmer),
    );
  });
  test("Test EggProv class...", () {
    EggProv eggStock = EggProv();
    eggStock.setEggsCollected(20);
    expect(eggStock.totalEggs, equals(20));
    eggStock.setBadEggs(5);
    eggStock.setGoodEggs();
    expect(eggStock.totalGoodEggs, equals(15));
  });
}

// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:poultry/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
