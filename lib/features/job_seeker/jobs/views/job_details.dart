import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/common/widgets/appbar/appbar.dart';
import 'package:jikjjang_app/data/models/job_model.dart';
import 'package:jikjjang_app/data/providers/job_providers.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/utils/constants/sizes.dart';

class JobDetailPage extends ConsumerWidget {
  final Job job;

  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobService = ref.watch(jobServiceProvider);
    final currentUser = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: const JAppBar(
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(JSizes.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Info Section
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    job.companyLogoUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: JSizes.paddingSM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.companyName,
                        style: const TextStyle(
                          fontSize: JSizes.font16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${job.location} - ${job.employmentType}',
                        style: const TextStyle(
                          fontSize: JSizes.font14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: JSizes.paddingMD),

            // Job Description
            Text(
              job.description,
              style: const TextStyle(fontSize: JSizes.font14),
            ),
            const SizedBox(height: JSizes.paddingMD),

            // Job Image (Optional)
            if (job.jobImageUrl != null)
              Image.network(
                job.jobImageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            const SizedBox(height: JSizes.paddingMD),

            // Requirements Section
            const Text(
              'Requirements',
              style: TextStyle(
                fontSize: JSizes.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...job.requirements.map((requirement) => Padding(
                  padding: const EdgeInsets.only(top: JSizes.paddingSM),
                  child: Text(
                    '- $requirement',
                    style: const TextStyle(fontSize: JSizes.font14),
                  ),
                )),
            const SizedBox(height: JSizes.paddingMD),

            // Salary
            Text(
              'Salary: ${job.salaryRange ?? "Not specified"}',
              style: const TextStyle(
                fontSize: JSizes.font14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: JSizes.paddingLG),

            // Apply Button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    if (currentUser != null) {
                      await jobService.addApplicant(
                        jobID: job.jobID,
                        applicantID: currentUser.id,
                        name: currentUser.name,
                        email: currentUser.email,
                        companyName: job.companyName,
                        jobTitle: job.title,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Application submitted successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('You need to be logged in to apply.')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to apply: $e')),
                    );
                  }
                },
                child: const Text('Apply Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
