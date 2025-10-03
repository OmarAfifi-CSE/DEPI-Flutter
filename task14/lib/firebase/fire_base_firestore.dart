import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task14/models/user_model.dart';

class FireBaseFireStore {
  final fireBaseFireStore = FirebaseFirestore.instance;

  Future<void> addUser({required UserModel user}) async {
    final docRef = fireBaseFireStore.collection("users").doc(user.id);
    final docSnap = await docRef.get();

    if (!docSnap.exists) {
      await docRef.set(user.toJson());
    }
  }
}
