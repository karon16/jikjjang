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
      throw Exception(' Failed to fetch jobs: $e');
    }
  }

  Future<void> addApplicant({
    required String jobID,
    required String applicantID,
    required String name,
    required String email,
    required String companyName,
    required String jobTitle,
  }) async {
    try {
      final jobRef = _firestore.collection('jobs').doc(jobID);
      final userRef = _firestore.collection('users').doc(applicantID);

      await _firestore.runTransaction((transaction) async {
        // Fetch both documents first
        final jobSnapshot = await transaction.get(jobRef);
        final userSnapshot = await transaction.get(userRef);

        if (!jobSnapshot.exists) {
          throw Exception("Job does not exist");
        }

        if (!userSnapshot.exists) {
          throw Exception("User does not exist");
        }

        // Update the job's applicants array
        final currentApplicants = List<Map<String, dynamic>>.from(
          jobSnapshot.data()?['applicants'] ?? [],
        );

        currentApplicants.add({
          'applicantID': applicantID,
          'name': name,
          'email': email,
        });

        // Update the user's applications array
        final currentApplications = List<Map<String, dynamic>>.from(
          userSnapshot.data()?['applications'] ?? [],
        );

        currentApplications.add({
          'jobID': jobID,
          'companyName': companyName,
          'jobTitle': jobTitle,
          // 'appliedAt': FieldValue.serverTimestamp(),
        });

        // Perform all updates after all reads
        transaction.update(jobRef, {'applicants': currentApplicants});
        transaction.update(userRef, {'applications': currentApplications});
      });
    } catch (e) {
      throw Exception('Failed to add applicant: $e');
    }
  }

  Future<List<Job>> searchJobs(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection('jobs')
          .where('title_lower', isGreaterThanOrEqualTo: query.toLowerCase())
          .where('title_lower',
              isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
          .get();

      final jobs = querySnapshot.docs.map((doc) {
        return Job.fromMap(doc.data());
      }).toList();

      return jobs;
    } catch (e) {
      throw Exception('Failed to search jobs: $e');
    }
  }



}
