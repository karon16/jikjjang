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

  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
    state = null;
  }
}
