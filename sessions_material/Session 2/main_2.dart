// if condition

void main() {
  // Map

  // Key : Value
  Map<String, dynamic> data = {
    "name": "Mohamed",
    "age": 12,
    "address": "Giza",
    "gender": "Male",
    "followers": [
      {"name": "Ahmed", "age": 10},
      {"name": "ibrahem", "age": 110},
      {"name": "omar", "age": 190},
    ],
  };

  print(data["name"]);
  print(data["followers"]);

  print(data.values);
  print(data.keys);

  print(data.containsKey('Mohamed'));

  data.putIfAbsent("phone", () => "0121212");
  data.putIfAbsent("gender", () => "0121212");

  // data['gender'] = "Female";
  data.update("country", (val) => "Egypt", ifAbsent: () => "USA");

  data.forEach((key, val) {
    print("Key is : $key, Value is $val");
  });

  print(data);

  // Map = Object
  // Class = Object
  // (Compiled)

  // bool email = false;
  // bool phone = false;
  // bool password = false;

  // if ((phone || email) && password) {
  //   print('Welcome to our app');
  // } else {
  //   print('Please enter correct email or password');
  // }

  // String? name;

  // if (name != null && name.isNotEmpty) {
  //   print(name);
  // } else {
  //   name = "Anonymous";
  //   print(name);
  // }

  // Expression
  // name != null && name.isNotEmpty ? :

  // ternary if
  // name = name != null ? name : "Anonymous";

  // name = name ?? "Anonymous";

  // name ??= "Anonymous";

  // condition
  // switch case

  // const year = 1990;

  // // switch expression
  // bool male = true;

  // bool female = true;
  // // Guard Clause
  // final gen = switch (year) {
  //   >= 1990 when male && female => 'Gen A Male',
  //   >= 1990 when !male => 'Gen A Female',
  //   2000 => 'Gen Z',
  //   _ => 'I dont know',
  // };

  // const password = true;
  // const email = true;
  // const phone = true;

  // final isLogin = switch (password) {
  //   password when email || phone => "Login Success",
  //   _ => "Login failed",
  // };

  // print(gen);
  // String gen2;

  // switch (year) {
  //   case 1990:
  //     gen2 = ('Gen A');

  //   case 2000:
  //     gen2 = ('Gen Z');

  //   case 2010:
  //     gen2 = ('Gen Alpha');

  //   default:
  //     gen2 = ('I dont know');
  // }

  // for loop

  //    init    ; condition; counter
  // for (var i = 0; i <= 9; i++) {
  //   print(i);
  // }

  // condition

  // while () {}

  // Enviroments Production

  // Dev Enviroment

  // www.facebook.com
  // www.test.facebook.com --> Test Flavor
  // www.dev.facebook.com --> Dev Flavor

  // ternary if
  // condition ? true : false

  //              0           1
  // < > Annotation
  // List<String> name = ["Youssef", "Mohamed"]; // List of String
  // // name.clear();
  // name.first;
  // name.last;
  // name[name.length - 1];
  // name.isEmpty;
  // name.isNotEmpty;

  // name.insert(1, "Ibrahem");
  // name.add("Kareem");

  // name.addAll(["Omar", "Abdullah", "Ahmed"]);

  // print(name);

  // for (int i = 0; i < name.length; i++) {
  //   print(name[i]);
  // }

  // // for in
  // for (final item in name) print(item);

  // name.forEach((element) {
  //   print("My name is $element");
  // });

  // Type Safety
  List<List<int>> numbers = [
    [1, 2],
    [3, 4],
  ];

  // print(numbers[0].contains(1));

  // for (int i = 1; i <= 15; i++) {
  //   if (i % 15 == 0) {
  //     print('Fizz Buzz');
  //     continue;
  //   }

  //   if (i % 3 == 0) {
  //     print("Fizz");
  //     continue;
  //   }

  //   if (i % 5 == 0) {
  //     print('Buzz');
  //     continue;
  //   }

  //   print(i);
  // }
}


// Logical Operator
// AND bool && bool
// OR bool || bool
// NOT