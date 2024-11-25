import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/features/authentication/views/authentication_page.dart';
import '../controllers/jobs_provider.dart';
import 'add_job_screen.dart';

class JobsScreen extends ConsumerWidget {
  final String companyID;

  const JobsScreen({required this.companyID, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(companyJobsProvider(companyID));
    final authController = ref.watch(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Company Job Postings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.signOut();
              if (context.mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationPage()));
              }
            },
          ),
        ],
      ),
      body: jobs.when(
        data: (jobList) => ListView.builder(
          itemCount: jobList.length,
          itemBuilder: (context, index) {
            final job = jobList[index];
            return ListTile(
              leading: job.jobImageUrl != null
                  ? Image.network(job.jobImageUrl!)
                  : const Icon(Icons.image_not_supported),
              title: Text(job.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Expires in: ${job.expiresAt.difference(DateTime.now()).inDays} days'),
                  Text('Applicants: ${job.applicants.length}'),
                ],
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddJobScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Job',
      ),
    );
  }
}
