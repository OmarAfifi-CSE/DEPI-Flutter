import 'dart:io';

List<Map> books = [
  {"isbn": "0", 'title': "Book1", "rating": 7.4},
  {"isbn": "1", 'title': "Book2", "rating": 4.8},
  {"isbn": "2", 'title': "Book3", "rating": 9.2},
];

List<Map> reviews = [
  {"isbn": "0", 'reviewer': "Omar", 'text': 'Good Book'},
  {"isbn": "1", 'reviewer': "Ahmed", 'text': "Didn't like it"},
  {"isbn": "2", 'reviewer': "Ali", 'text': 'Very comprehensive and detailed.'},
];

void addOrUpdateBook() {
  print("Enter Book ISBN: ");
  String isbn = stdin.readLineSync()!;

  Map? foundBook;
  for (var book in books) {
    if (book["isbn"] == isbn) {
      foundBook = book;
      break;
    }
  }

  if (foundBook != null) {
    // --- Update Book ---
    print(
      "Book found. Add new details.\n"
      "Enter new title (current: ${foundBook['title']}): ",
    );
    String newTitle = stdin.readLineSync()!;
    print("Enter new rating (current: ${foundBook['rating']}): ");
    double? newRating;
    while (newRating == null || newRating < 0) {
      print("Enter book rating (0-10): ");
      double? value = double.tryParse(stdin.readLineSync()!);
      if (value != null && value >= 0 && value <= 10) {
        newRating = value;
      } else {
        print("Invalid rating. Please enter a number from 0 to 10.");
      }
    }
    foundBook['title'] = newTitle;
    foundBook['rating'] = newRating;
    print(foundBook);
    print("✅ Book updated successfully!");
  } else {
    // --- Add New Book ---
    print("Book not found. Let's add it.");
    print("Enter book title: ");
    String title = stdin.readLineSync()!;

    double? rating;
    while (rating == null || rating < 0) {
      print("Enter book rating (0-10): ");
      double? value = double.tryParse(stdin.readLineSync()!);
      if (value != null && value >= 0 && value <= 10) {
        rating = value;
      } else {
        print("Invalid rating. Please enter a number from 0 to 10");
      }
    }

    books.add({"isbn": isbn, 'title': title, 'rating': rating});
    print(books.last);
    print("✅ Book added successfully!");
  }
}

void viewBookReviews() {
  print("Enter book ISBN: ");
  String isbn = stdin.readLineSync()!;

  print("--- Reviews for ISBN $isbn ---");
  bool foundReviews = false;
  for (var review in reviews) {
    if (review["isbn"] == isbn) {
      print("Reviewer: ${review['reviewer']}");
      print("Review: ${review['text']}");
      print("---------------------------------------------");
      foundReviews = true;
    }
  }

  if (!foundReviews) {
    print("No reviews found for this book.");
  }
}

void getBookRecommendations() {
  print("Enter book ISBN: ");
  String isbn = stdin.readLineSync()!;

  Map? foundBook;
  for (var book in books) {
    if (book["isbn"] == isbn) {
      foundBook = book;
      break;
    }
  }

  if (foundBook == null) {
    print("Book couldn't be found.");
    return;
  }

  double rating = foundBook['rating'] as double;
  var recommendation = switch (rating) {
    < 5 => "Not Recommended",
    >= 5 && < 8 => "Recommended",
    >= 8 => "Highly Recommended",
    _ => "Not Rated",
  };

  print("'${foundBook['title']}' is " + recommendation);
}

void main() {
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
        addOrUpdateBook();
        break;
      case '2':
        viewBookReviews();
        break;
      case '3':
        getBookRecommendations();
        break;
      case '4':
        print(books);
        break;
      case '5':
        print(reviews);
        break;
      case '6':
        print("Program finished, bye!");
        return;
      default:
        print("Invalid choice. Please choose a number from 1 to 4");
    }
  }
}
