import 'dart:io';
import 'expenses_logic.dart';

void main() {
  ExpensesLogic expensesLogic = ExpensesLogic();
  while (true) {
    print(
      "=== Expense Tracker ===\n"
      "1. Add Expense\n"
      "2. View All Expenses\n"
      "3. View Expenses By Category\n"
      "4. View Expenses Statistics\n"
      "5. Exit\n"
      "Enter your choice (1-5): ",
    );
    final choice = int.tryParse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        expensesLogic.addExpense(expensesLogic.expenses);
        break;
      case 2:
        expensesLogic.viewAllExpenses(expensesLogic.expenses);
        break;
      case 3:
        expensesLogic.viewExpensesByCategory();
        break;
      case 4:
        expensesLogic.showStatistics();
        break;
      case 5:
        print("Program finished. bye!");
        return;
      default:
        print("Invalid choice. Please choose a number from 1 to 5.\n");
        break;
    }
  }
}
