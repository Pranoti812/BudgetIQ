import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      throw e;
    }
  }

  Future<User?> signup(String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      throw e;
    }
  }
}
