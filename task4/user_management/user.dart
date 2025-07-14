
class User{
  final String _id;
  String _email;
  String _password;

  User({required String id, required String email, required String password}) :
        _id = id,
        _email = email,
        _password = password;

  String get id => _id;
  String get email => _email;
  String get password => _password;
  set email(String email) => _email = email;
  set password(String password) => _password = password;

  @override
  String toString() {
    return 'User{id: $_id, email: $_email, password: $_password}';
  }

}