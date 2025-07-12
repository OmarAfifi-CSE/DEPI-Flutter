extension FormattedString on String {
  bool get isEmail {
    if (this.contains("@")) return true;
    return false;
  }

  bool get isPassword {
    if (this.contains("1")) return true;
    return false;
  }
}


