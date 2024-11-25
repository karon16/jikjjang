import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_model.dart';

class JobsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addJob(Job job) async {
    await _firestore.collection('jobs').doc(job.jobID).set(job.toMap());
  }

  Future<List<Job>> getJobsByRecruiter(String recruiterID) async {
    final querySnapshot = await _firestore
        .collection('jobs')
        .where('postedBy', isEqualTo: recruiterID)
        .get();

    return querySnapshot.docs
        .map((doc) => Job.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Job>> getJobsByCompany(String companyID) async {
    final querySnapshot = await _firestore
        .collection('jobs')
        .where('companyID', isEqualTo: companyID)
        .get();

    return querySnapshot.docs
        .map((doc) => Job.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
