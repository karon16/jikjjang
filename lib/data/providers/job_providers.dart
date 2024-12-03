// job_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/data/models/job_model.dart';
import 'package:jikjjang_app/data/services/job_service.dart';

final jobServiceProvider = Provider<JobService>((ref) => JobService());

// Fetch jobs for job seekers
final jobSeekersProvider = FutureProvider<List<Job>>((ref) async {
  final jobService = ref.watch(jobServiceProvider);
  return jobService.fetchJobsForJobSeekers();
});
