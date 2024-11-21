import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jikjjang_app/features/authentication/controllers/auth_providers.dart';

class AuthController extends StateNotifier<User?> {
  final Ref _ref;

  AuthController(this._ref) : super(null) {
    _ref.read(authRepositoryProvider).authStateChanges.listen((user) {
      state = user;
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    final user = await _ref
        .read(authRepositoryProvider)
        .signInWithEmail(email, password);
    state = user;
  }

  Future<void> signInWithGoogle() async {
    final user = await _ref.read(authRepositoryProvider).signInWithGoogle();
    state = user;
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String role,
    String? companyName,
    String? companyAddress,
  }) async {
    try {
      final userCredential = await _ref
          .read(authRepositoryProvider)
          .signUpWithEmail(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        await _ref.read(authRepositoryProvider).createUserInFirestore(
              userId: user.uid,
              email: email,
              name: name,
              role: role,
              companyName: companyName,
              companyAddress: companyAddress,
            );
        state = user;
      }
    } catch (e) {
      print("Error during sign up: $e");
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      final user = await _ref.read(authRepositoryProvider).signInWithGoogle();
      if (user != null) {
        // You can add user data to Firestore after successful Google sign-in
        await _ref.read(authRepositoryProvider).createUserInFirestore(
              userId: user.uid,
              email: user.email ?? '',
              name: user.displayName ?? '',
              role: 'jobSeeker', // Assuming job seeker role by default
            );
        state = user; // Update auth state
      }
    } catch (e) {
      print("Error during Google sign-up: $e");
    }
  }


  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
    state = null;
  }

  
}
