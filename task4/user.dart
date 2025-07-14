
class User{
  String? _id;
  String? _email;
  String? _password;

  User(this._id, this._email, this._password);
  String? get id => _id;
  String? get email => _email;
  String? get password => _password;
  set id(String? id) => _id = id;
  set email(String? email) => _email = email;
  set password(String? password) => _password = password;

  @override
  String toString() {
    return 'User{id: $_id, email: $_email, password: $_password}';
  }

}