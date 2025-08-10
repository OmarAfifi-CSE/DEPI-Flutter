void main() {
  // int
  // int? nullable - integer
  int? x;
  int z = 5;

  if (z > 1) {
    x = 1;
  }

  // Smart
  final y = x! + 5;

  print(y);

  String? name = "Youssef";

  //        if null
  String fName = name ?? 'Anonymous';

  // if null assign
  name ??= "Anonymous";

  print(name);

  // Null
  // Null-Safety
}
