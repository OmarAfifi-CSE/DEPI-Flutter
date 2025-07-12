// Object Oriented Programming - OOP
// Paradigm

// Object
// Encapsulation
// Inheritance - mixin
// Polymorphism
// Abstraction

// Class - Template ( actions, attr )

void main() {
  final business = BankAccount.business(
    id: 123,
    name: '123',
    accNumber: 123123,
  );

  // business.setBalance(100);

  business.balance = 10000;

  final son = Son();

  son.fly();
  son.work();
}

// Access Modifiers = Public, Private

class BankAccount {
  final int id;
  final String name;
  final int accNumber;
  double _balance;

  // Default Constructor
  BankAccount({
    required this.id,
    required this.name,
    required this.accNumber,
    double balance = 0,
  }) : _balance = balance;

  // Named Constructor
  BankAccount.business({
    required this.id,
    required this.name,
    required this.accNumber,
    double balance = 100_000,
  }) : _balance = balance;

  // setters
  void set balance(double b) {
    _balance = b;
  }

  // getters
  double get balance => _balance;

  void deposit() {}

  void withdraw() {}

  void transfer() {}
}

class Father {
  void work() {
    print('Father working');
  }

  void fly() {
    print('Father Flying');
  }
}

class Son extends Father {
  //overriding

  @override
  void fly() {
    super.fly();
    print('Son Flying');
  }

  // annotation
  @override
  void work() {
    super.work();
    print('Son Working');
  }
}
