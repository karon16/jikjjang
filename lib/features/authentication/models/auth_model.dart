import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String id;
  final String role;
  final String email;
  final String name;
  final String companyID;

  UserData({
    required this.id,
    required this.role,
    required this.email,
    required this.name,
    required this.companyID,
  });

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData(
      id: doc.id,
      role: data['role'] ?? 'unknown',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      companyID: data['companyID'] ?? '',
    );
  }
}
