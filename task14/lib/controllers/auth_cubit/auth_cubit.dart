import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task14/firebase/fire_base_auth.dart';
import 'package:task14/firebase/fire_base_firestore.dart';
import 'package:task14/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  FireBaseAuth fireBaseAuth = FireBaseAuth();
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthGoogleLoading());
      UserCredential userCredential = await fireBaseAuth.signInWithGoogle();

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
      );

      await fireBaseFireStore.addUser(user: user);

      emit(AuthGoogleSuccess());
    } catch (e) {
      emit(AuthGoogleFailure("Error happened"));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthSignOutLoading());
      await fireBaseAuth.signOut();
      emit(AuthSignOutSuccess());
    } catch (e) {
      emit(AuthSignOutFailure("Error happened"));
    }
  }
}
