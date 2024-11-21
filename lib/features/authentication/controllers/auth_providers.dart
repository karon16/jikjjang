import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/data/repositories/auth_repository.dart';
import 'package:jikjjang_app/features/authentication/controllers/auth_controllers.dart';
import 'package:jikjjang_app/utils/constants/enums.dart';

// Provider for AuthRepository with FirebaseAuth dependency
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

// Provider to manage authentication state through AuthController
final authControllerProvider =
    StateNotifierProvider<AuthController, User?>((ref) {
  return AuthController(ref);
});

final authModeProvider = StateProvider<AuthMode>((ref) {
  return AuthMode.personal;
});
