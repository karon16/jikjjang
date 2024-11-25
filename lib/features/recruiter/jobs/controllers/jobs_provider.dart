import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/jobs_service.dart';
import '../models/job_model.dart';

final jobsServiceProvider = Provider((ref) => JobsService());

final recruiterJobsProvider =
    FutureProvider.family<List<Job>, String>((ref, recruiterID) {
  final jobsService = ref.watch(jobsServiceProvider);
  return jobsService.getJobsByRecruiter(recruiterID);
});

final companyJobsProvider =
    FutureProvider.family<List<Job>, String>((ref, companyID) {
  final jobsService = ref.watch(jobsServiceProvider);
  return jobsService.getJobsByCompany(companyID);
});

final addJobProvider = Provider((ref) {
  final jobsService = ref.watch(jobsServiceProvider);
  return (Job job) => jobsService.addJob(job);
});
