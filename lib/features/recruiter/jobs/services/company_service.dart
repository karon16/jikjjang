import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jikjjang_app/features/recruiter/jobs/models/company_model.dart';

class CompanyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch company by ID
  Future<Company?> getCompanyById(String companyID) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('companies').doc(companyID).get();

      if (snapshot.exists) {
        return Company.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching company: $e");
      return null;
    }
  }
}
