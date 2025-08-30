import 'package:firebase_auth/firebase_auth.dart';
import 'package:workin/models/user_model.dart';

abstract class FirebaseAuthService {
  static final FirebaseAuth _instance = FirebaseAuth.instance;
  static User? user;
  static UserModel? currentUser;

  static Future<void> signInViaEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = response.user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signUpViaEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = response.user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      await _instance.signOut();
      user = null;
    } catch (e) {
      rethrow;
    }
  }

  static Stream<User?> getAuthStream() {
    return _instance.authStateChanges();
  }
}
