// OOP
// 1. Object
// 2. Encapsulation
// 3. Inheritance
// 4. Abstraction
// 5. Polymorphism

// Encapsulation
//      Getters & Setters

// Inheritance

// Abstraction

// Implicit Interface
// class Chess {
//   void move() {
//     print('Moving');
//   }

//   int x = 0;
//   int y = 0;
// }

// class Elephant implements Chess {
//   @override
//   int x = 1;

//   @override
//   int y = 5;

//   @override
//   void move() {
//     print('Elephant Moving');
//   }
// }

// void main() {
//   Chess c1 = Chess();
//   Elephant e1 = Elephant();

//   print(c1.x);
//   print(e1.x);

//   c1.move();
//   e1.move();
// }

// No Implementation
// abstract class Human {
//   void work();

//   void sleep();

//   void drink();

//   void fly();
// }

// interface class Human {}

// class Mohamed implements Human {
//   @override
//   void drink() {
//     // TODO: implement drink
//   }

//   @override
//   void sleep() {
//     // TODO: implement sleep
//   }

//   @override
//   void work() {
//     // TODO: implement work
//   }

//   @override
//   void fly() {
//     // TODO: implement fly
//   }
// }

// class Adam implements Human {
//   @override
//   void drink() {
//     // TODO: implement drink
//   }

//   @override
//   void sleep() {
//     // TODO: implement sleep
//   }

//   @override
//   void work() {
//     // TODO: implement work
//   }

//   @override
//   void fly() {
//     // TODO: implement fly
//   }
// }

// abstract interface class Chess {
//   void move();
// }

// class Horse implements Chess {

//   @override
//   void move() {

//   }
// }

// abstract class Widget {
//   void createElement();
// }

// abstract class StatelessWidget implements Widget {
//   void build();

//   void createElement() {}
// }

// class Todo extends StatelessWidget {
//   @override
//   void build() {
//     // TODO: implement build
//   }
// }

// abstract class Human {
//   void fly();
// }

// class Adam extends Human {
//   @override
//   void fly() {
//     // TODO: implement fly
//   }
// }

// // explicit interface
// abstract interface class Chess {}

// // implicit interface
// class A {}

// class B implements A {}

// Polymorphism
import 'extension.dart';

abstract class Chess {
  String? name;

  void move();
}

class Elephant implements Chess {
  @override
  String? name = 'Elephant';

  @override
  void move() {
    print('$name is moving');
  }
}

class Horse implements Chess {
  String? name = 'Horse';

  @override
  void move() {
    print('$name is moving');
  }
}

class King implements Chess {
  String? name = 'King';

  @override
  void move() {
    print('$name is moving');
  }
}

// void main() {
//   Chess e = Elephant();

//   // Everything is an object
//   print(e.name);

//   bool isStr = "Mohamed" is String;
//   print(isStr);

//   whatIsYourName(King());
//   whatIsYourName(Horse());
//   whatIsYourName(Elephant());
// }

// void whatIsYourName(Chess chess) {
// print("I am the ${chess.name}");
// chess.move();

// if (chess is Elephant) {
//   print("Iam the Elephant");
// } else if (chess is Horse) {
//   print("Iam the Horse");
// } else if (chess is King) {
//   print("Iam the King");
// }
// }

// class StatelessWidget {}

// abstract class FlowButton extends StatelessWidget {}

// class ButtonA extends FlowButton {}

// class ButtonB extends FlowButton {}

// mixin
// extensions

class Human {
  void work() {}

  void eat() {}
}

mixin HumanActions {
  void fly() {
    print('fly HumanActions One');
  }

  void sleep() {
    print('Sleeeping HumanActions One');
  }
}

mixin HumanActions2 {
  void fire() {
    print('fire HumanActions Two');
  }

  void kill() {
    print('kill HumanActions Two');
  }

  void sleep() {
    print('sleep HumanActions Two');
  }
}

// class Adam extends Human with HumanActions2, HumanActions {}

class Adam {}

// Collisions

// mixin
//    1. don't want to implement
//    2. extend
//    3. Named as an Action
//    4. can't be instantiated

mixin Actions on Adam {
  String name = "Adam";

  int age = 12;

  void printing() {}
}

// void main() {
//   Adam().info();
// }

mixin Calculations {
  void sum() {}

  void multiply() {}
}

mixin Alerts on Colors {
  void successAlert() {}

  void failedAlert() {}
}

class StatelessWidget {}

// class HomeWidget extends StatelessWidget with Alerts {
//   void build() {
//     successAlert();
//     failedAlert();
//   }
// }

mixin Colors {
  String color1 = "Color1";
}

// -------------------------------------

extension on Adam {
  void info() {
    print('My name is Adam');
  }
}

bool isEmail(String val) {
  if (val.contains("@")) {
    return true;
  } else {
    return false;
  }
}

void main() {
  // final isEmailVar = isEmail("youssef@gmail.com");
  bool x = "youssef@gmail.com".isEmail;
  final isPassword = "123123".isPassword;
}

