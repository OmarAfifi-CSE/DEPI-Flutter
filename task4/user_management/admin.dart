
import 'user.dart';

class Admin extends User {
  List<String> _privileges;
  Admin({
    required String id,
    required String email,
    required String password,
    required List<String> privileges,
  }) : _privileges = privileges,
       super(id: id, email: email, password: password);
  List<String> get privileges => _privileges;
  set privileges(List<String> privileges) => _privileges = privileges;
}