class Expenses {
  String? _description;
  double? _amount;
  String? _category;
  DateTime? _date;

  String? get description => _description;

  double? get amount => _amount;

  String? get category => _category;

  DateTime? get date => _date;

  set description(String? value) {
    _description = value;
  }

  set amount(double? value) {
    if (value != null && value > 0) {
      _amount = value;
    }
  }

  set category(String? value) {
    _category = value;
  }

  set date(DateTime? value) {
    _date = value;
  }

  @override
  String toString() {
    return 'Expense: {description: $_description, amount: $_amount, category: $_category, date: $_date}';
  }
}
