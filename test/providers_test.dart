import 'package:poultry/config/enumvals.dart';
import 'package:poultry/providers/birds_prov.dart';
import 'package:poultry/providers/egg_prov.dart';
import 'package:poultry/providers/order_prov.dart';
import 'package:poultry/providers/price_prov.dart';
import 'package:test/test.dart';
import 'package:poultry/providers/user_prov.dart';

void main() {
  group(
    "Testing provider classes...",
    () {
      test("\nUserProv class tests", () {
        UserProv user = UserProv();
        user.setName("Emmanuel");
        user.setEmail("fake@gmail.com");
        user.setPassword("password");
        user.setPhoneNumber("08012345678");
        user.setUserRole(UserType.farmer);
        expect(
          user.name,
          equals("Emmanuel"),
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
      test(
        "\nEggProv class tests",
        () {
          EggProv eggStock = EggProv();
          eggStock.setEggsCollected(20);
          expect(eggStock.totalEggs, equals(20));
          eggStock.setBadEggs(5);
          eggStock.setGoodEggs();
          expect(eggStock.totalGoodEggs, equals(15));
        },
      );

      test("\nBirdProv class tests", () {
        BirdsProv birdBatch = BirdsProv();
        birdBatch.setBatchName("Batch 2");
        birdBatch.setBirdType("Layers");
        birdBatch.setDay("20");
        birdBatch.setMonth("February");
        birdBatch.setYear("2021");
        birdBatch.setNumberOfbatches(2);
        birdBatch.setQuantity(50);
        birdBatch.setStartDate("20/02/2021");
        expect(birdBatch.batchCount, equals(2));
        expect(birdBatch.birdBatchName, equals("Batch 2"));
        expect(birdBatch.birdType, equals("Layers"));
        expect(birdBatch.startDate, equals("20/02/2021"));
        expect(birdBatch.startDay, equals("20"));
        expect(birdBatch.startMonth, equals("February"));
        expect(birdBatch.startYear, equals("2021"));
        expect(birdBatch.batchQuantity, equals(50));
        birdBatch.resetValues();
        expect(birdBatch.birdBatchName, equals(""));
        expect(birdBatch.birdType, equals("Broiler"));
        expect(birdBatch.startDate, equals(""));
        expect(birdBatch.startDay, equals("1"));
        expect(birdBatch.startMonth, equals("January"));
        expect(birdBatch.startYear, equals("2021"));
        expect(birdBatch.batchQuantity, equals(0));
      });

      test("\nPriceProv class tests", () {
        PriceProv prices = PriceProv();
        prices.setChickenPrice(3500);
        prices.setCrateOfEggPrice(900);
        expect(prices.chickenPrice, 3500);
        expect(prices.cratePrice, 900);
      });

      test("\nOrderProv class tests", () {
        OrderProv order = OrderProv();
        order.setCustomerName("Joseph Aminu");
        order.setCustomerAddress("No3. Classic Estate");
        order.setCustomerContact(("09012345678"));
        for (int i = 0; i < 3; i++) {
          order.addCratesOfEggs();
          order.addChicken();
        }
        expect(order.chickenCount, 3);
        expect(order.cratesOfEggsCount, 3);
        order.subtractChicken();
        order.subtractCratesOfEggs();
        expect(order.chickenCount, 2);
        expect(order.cratesOfEggsCount, 2);
        // order.calculateTotalPrice();
        // expect(order.totalPrice, equals(order.totalPrice));
        // double currentEggPrice = prefs.getDouble("crateOfEggUnitPrice");
        // double currentCratePrice = prefs.getDouble("chickenUnitPrice");
      });
    },
  );
}
