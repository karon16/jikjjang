// job_service.dart
import 'package:jikjjang_app/data/models/job_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetching all jobs for job seekers
  Future<List<Job>> fetchJobsForJobSeekers() async {
    try {
      final querySnapshot = await _firestore.collection('jobs').get();
      final jobs = querySnapshot.docs.map((doc) {
        return Job.fromMap(doc.data());
      }).toList();
      return jobs;
    } catch (e) {
      throw Exception('Failed to fetch jobs: $e');
    }
  }
}
