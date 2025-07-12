import 'dart:io';

import 'expenses.dart';

class ExpensesLogic {
  List<Expenses> expenses = [];

  /// Get all the details from the user: description, amount and category.
  ///
  /// Make sure the amount is valid, and then add the new expense to expenses list.
  void addExpense(List<Expenses> expenses) {
    Expenses expense = Expenses();

    print("\nEnter description: ");
    expense.description = stdin.readLineSync();

    while (expense.amount == null || expense.amount! < 0) {
      print("Enter positive amount: ");
      double? amount = double.tryParse(stdin.readLineSync()!);
      if (amount != null && amount > 0) {
        expense.amount = amount;
      } else {
        print("Invalid amount. Please enter a positive number.");
      }
    }
    print(
      "Select category (1-4): \n"
      "1. Food\n"
      "2. Transportation\n"
      "3. Entertainment\n"
      "4. Other",
    );

    int? category = int.tryParse(stdin.readLineSync()!);
    switch (category) {
      case 1:
        expense.category = "Food";
        break;
      case 2:
        expense.category = "Transportation";
        break;
      case 3:
        expense.category = "Entertainment";
        break;
      default:
        expense.category = "Other";
        break;
    }
    expense.date = DateTime.now();

    expenses.add(expense);
    print("✅ Expense added!\n");
  }

  /// Check if the list is empty, otherwise print all expenses.
  void viewAllExpenses(List<Expenses> expenses) {
    if (expenses.isEmpty) {
      print("No expenses recorded yet.\n");
      return;
    }
    print("\n--- All Expenses ---");
    for (var expense in expenses) {
      print(expense.toString());
    }
  }

  /// Ask user to pick a category, then find all the expenses that match and display only those ones.
  void viewExpensesByCategory() {
    if (expenses.isEmpty) {
      print("No expenses recorded yet.");
      return;
    }
    print(
      "1. Food\n"
      "2. Transportation\n"
      "3. Entertainment\n"
      "4. Other\n"
      "Choose a category (1-4): ",
    );
    final choice = int.tryParse(stdin.readLineSync()!);
    final category;
    switch (choice) {
      case 1:
        category = "Food";
        break;
      case 2:
        category = "Transportation";
        break;
      case 3:
        category = "Entertainment";
        break;
      default:
        category = "Other";
        break;
    }
    final filteredExpenses = expenses
        .where((e) => e.category == category)
        .toList();
    if (filteredExpenses.isEmpty) {
      print("No expenses found for category '$category'.");
      return;
    }
    print("--- Expenses in Category: $category ---");
    for (final expense in filteredExpenses) {
      print(expense.toString());
    }
  }

  /// Calculate and print the total spent, the average, and which expense is the highest.
  void showStatistics() {
    if (expenses.isEmpty) {
      print("No expenses recorded yet.");
      return;
    }
    double totalSpending = 0;
    double max = 0;
    for (Expenses i in expenses) {
      totalSpending += i.amount!;
      if (i.amount! > max) {
        max = i.amount!;
      }
    }
    final averageExpense = totalSpending / expenses.length;
    final highestExpense = max;

    print("--- Spending Statistics ---");
    print("Total Expenses: ${expenses.length}");
    print("Total Spending: \$${totalSpending.toStringAsFixed(2)}");
    print("Average Expense: \$${averageExpense.toStringAsFixed(2)}");
    print("Highest Expense: \$$highestExpense");
    print("-------------------------");
  }
}
