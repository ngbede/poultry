import 'dart:math' as math;

// This is our custom ID generator used in creation of orders
String generateID() {
  final _random = math.Random();
  final List<String> _alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ];
  String id = "";
  for (int i = 0; i < 5; i++) {
    _alphabets.shuffle();
    if (i < 2) {
      id += _alphabets[_random.nextInt(52)];
    } else {
      id += _random.nextInt(10).toString();
    }
  }
  return id.toString();
}
