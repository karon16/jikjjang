import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository(FirebaseAuth instance,
      {FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();
        

  Future<User?> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;

    // After signing in with Google, create the user in Firestore if not already created
    if (user != null) {
      await createUserInFirestore(
        userId: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
        role: 'jobSeeker', // Default role for Google users
      );
    }

    return user;
  }

  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserInFirestore({
    required String userId,
    required String email,
    required String name,
    required String role,
    String? companyName,
    String? companyAddress,
  }) async {
    await _firestore.collection('Users').doc(userId).set({
      'userID': userId,
      'email': email,
      'name': name,
      'role': role,
      'companyID': role == 'jobRecruiter' ? userId : null,
    });

    // If role is recruiter, create company document
    if (role == 'jobRecruiter' &&
        companyName != null &&
        companyAddress != null) {
      await _firestore.collection('Companies').doc(userId).set({
        'companyID': userId,
        'companyName': companyName,
        'companyAddress': companyAddress,
        'createdBy': userId,
      });
    }
  }


  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut(); // Reset the user state
    } catch (e) {
      print("Error during sign out: $e");
    }
  }


 

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
