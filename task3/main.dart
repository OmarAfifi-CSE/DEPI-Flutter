import 'dart:io';

import 'book_manager.dart';

void main() {
  BookManager bookManager = new BookManager();
  while (true) {
    print(
      "--- Book & Review Menu ---\n"
      "1. Add or Update a Book\n"
      "2. View Specific Book Reviews\n"
      "3. Get Book Recommendations\n"
      "4. View All Books\n"
      "5. View All Reviews\n"
      "6. Exit\n"
      "Enter your choice: ",
    );
    String choice = stdin.readLineSync()!;
    switch (choice) {
      case '1':
        bookManager.addOrUpdateBook();
        break;
      case '2':
        bookManager.viewBookReviews();
        break;
      case '3':
        bookManager.getBookRecommendations();
        break;
      case '4':
        print(bookManager.books);
        break;
      case '5':
        print(bookManager.reviews);
        break;
      case '6':
        print("Program finished, bye!");
        return;
      default:
        print("Invalid choice. Please choose a number from 1 to 6");
    }
  }
}
