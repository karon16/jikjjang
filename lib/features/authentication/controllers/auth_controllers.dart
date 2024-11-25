import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/features/authentication/models/auth_model.dart';

class AuthController extends StateNotifier<UserData?> {
  final Ref _ref;

  AuthController(this._ref) : super(null) {
    _ref.read(authRepositoryProvider).authStateChanges.listen((user) async {
      if (user != null) {
        final userData = await _fetchUserData(user.uid);
        state = userData;
      } else {
        state = null;
      }
    });
  }

  Future<UserData?> _fetchUserData(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get(const GetOptions(source: Source.server));
      if (doc.exists) {
        return UserData.fromFirestore(doc);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }
Future<void> signInWithEmail(String email, String password) async {
    try {
      final user = await _ref
          .read(authRepositoryProvider)
          .signInWithEmail(email, password);
      if (user != null) {
        final userData = await _fetchUserData(user.uid);
        state = userData;
        print("User connected");
      }
    } catch (e) {
      print(
          "Sign-in failed: ${e.runtimeType} - $e"); // Log the error type and message
      rethrow; // Optionally rethrow to handle higher-level errors
    }
  }


  Future<void> signInWithGoogle() async {
    final user = await _ref.read(authRepositoryProvider).signInWithGoogle();
    if (user != null) {
      final userData = await _fetchUserData(user.uid);
      state = userData;
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String role,
    String? companyName,
    String? companyAddress,
  }) async {
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
      final userData = await _fetchUserData(user.uid);
      state = userData;
    }
  }

  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
    state = null;
  }
}

