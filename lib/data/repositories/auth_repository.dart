import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

Future<User?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error signing in: $e");
      return null; // Handle the error properly
    }
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

    if (user != null) {
      // Ensure user data is created in Firestore
      await createUserInFirestore(
        userId: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
        role: 'jobSeeker',
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
    final userDoc = _firestore.collection('users').doc(userId);
    final userExists = (await userDoc.get()).exists;

    if (!userExists) {
      await userDoc.set({
        'userID': userId,
        'email': email,
        'name': name,
        'role': role,
        'profileInfo': {
          'profileImageURL': null,
          'bio': '',
          'experience': [],
          'skills': [],
        },
        'preferences': role == 'jobSeeker'
            ? {
                'preferredJobCategories': [],
                'locationPreference': '',
                'language': '',
              }
            : null,
        'companyID': role == 'jobRecruiter' ? userId : null,
      });

      if (role == 'jobRecruiter' &&
          companyName != null &&
          companyAddress != null) {
        await _firestore.collection('companies').doc(userId).set({
          'companyID': userId,
          'companyName': companyName,
          'companyAddress': companyAddress,
          'createdBy': userId,
          'description': '',
          'recruiters': [],
          'industry': '',
          'logoURL': '',
        });
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
