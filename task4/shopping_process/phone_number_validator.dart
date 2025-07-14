extension EgyptianPhoneNumberValidator on String {
  bool get isEgyptianPhoneNumber =>
      RegExp(r'^(010|011|012|015)\d{8}$').hasMatch(this);
}
