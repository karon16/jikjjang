// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/data/repositories/auth_repository.dart';
import 'package:jikjjang_app/features/authentication/controllers/auth_controllers.dart';
import 'package:jikjjang_app/features/authentication/models/auth_model.dart';


// AuthRepository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// AuthController Provider
final authControllerProvider = StateNotifierProvider<AuthController, UserData?>(
  (ref) => AuthController(ref),
);
