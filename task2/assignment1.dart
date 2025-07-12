void main() {
  List<Map> students = [
    {
      "name": "Omar",
      "age": 21,
      "grades": {"arabic": 90, "math": 95, "science": 92},
    },
    {
      "name": "Ahmed",
      "age": 15,
      "grades": {"arabic": 85, "math": 88, "science": 95},
    },
    {
      "name": "Ali",
      "age": 21,
      "grades": {"arabic": 92, "math": 95, "science": 88},
    },
  ];
  students.add({
    "name": "Mohamed",
    "age": 21,
    "grades": {"arabic": 91, "math": 92, "science": 96},
  });

  students.addAll([
    {
      "name": "Hamdi",
      "age": 21,
      "grades": {"arabic": 79, "math": 82, "science": 86},
    },
    {
      "name": "Adel",
      "age": 21,
      "grades": {"arabic": 82, "math": 88, "science": 86},
    },
  ]);

  students.replaceRange(0, 1, [
    {
      "name": "Bob",
      "age": 21,
      "grades": {"arabic": 85, "math": 82, "science": 90},
    },
  ]);
  print(students);
  double sum = 0;
  double avg = 0;
  students.forEach((student) {
    student["grades"].forEach((key, val) {
      sum += val;
    });
    avg = sum / student["grades"].length;
    print("Average grades for ${student["name"]} is $avg");
    sum = 0;
  });
}
