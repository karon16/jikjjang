import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jikjjang_app/data/models/job_model.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/data/providers/categories_providers.dart';
import 'package:jikjjang_app/features/recruiter/jobs/controllers/company_provider.dart';
import 'package:jikjjang_app/features/recruiter/jobs/controllers/jobs_provider.dart';
import 'package:jikjjang_app/utils/helpers/helper_functions.dart';


class AddJobScreen extends ConsumerWidget {
  AddJobScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryRangeController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  File? selectedImage;


  final List<String> employmentTypes = ['Full-time', 'Part-time', 'Internship'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final companyAsyncValue = ref.watch(companyProvider(user!.companyID));

    final categoriesAsyncValue =
        ref.watch(categoriesProvider); // Fetch categories
    String selectedCategory = categoriesAsyncValue.maybeWhen(
      data: (categories) => categories.isNotEmpty ? categories.first : '',
      orElse: () => '',
    );

    String selectedEmploymentType = employmentTypes.first;
  
    return Scaffold(
      appBar: AppBar(title: const Text('Add Job')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Job Title'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: salaryRangeController,
                decoration: const InputDecoration(labelText: 'Salary Range'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: requirementsController,
                decoration: const InputDecoration(labelText: 'Requirements'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: daysController,
                decoration: const InputDecoration(labelText: 'Deadline (days)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              categoriesAsyncValue.when(
                data: (categories) => DropdownButtonFormField<String>(
                  value: selectedCategory.isNotEmpty ? selectedCategory : '',
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) selectedCategory = value;
                  },
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => Text('Failed to load categories: $err'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedEmploymentType,
                decoration: const InputDecoration(labelText: 'Employment Type'),
                items: employmentTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) selectedEmploymentType = value;
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _pickImage,
                child: const Text('Select Job Image'),
              ),
              const SizedBox(height: 20),
              companyAsyncValue.when(
                data: (company) {
                  if (company == null) {
                    return const Center(
                      child: Text('Company details not found.'),
                    );
                  }

                  return ElevatedButton(
                    onPressed: () async {
                      if (selectedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select an image')));
                        return;
                      }

                      // Upload the image
                      final helper = HelperFunctions();
                      final imageUrl = await helper.uploadImage(
                          selectedImage!, "job_images");

                      // Create new Job object
                      final newJob = Job(
                        jobID: DateTime.now().millisecondsSinceEpoch.toString(),
                        companyID: user.companyID,
                        companyLogoUrl: company.logoURL,
                        companyIndustry: company.industry,
                        companyName: company.companyName,
                        category: selectedCategory,
                        title: titleController.text,
                        description: descriptionController.text,
                        requirements: requirementsController.text.split(','),
                        location: locationController.text,
                        employmentType: selectedEmploymentType,
                        salaryRange: salaryRangeController.text,
                        createdAt: DateTime.now(),
                        expiresAt: DateTime.now().add(
                            Duration(days: int.parse(daysController.text))),
                        postedBy: user.id,
                        applicants: [],
                        jobImageUrl: imageUrl,
                      );

                      // Add job using the provider
                      ref.read(addJobProvider).call(newJob);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Job added successfully!')),
                      );

                      // Clear form
                      titleController.clear();
                      descriptionController.clear();
                      locationController.clear();
                      salaryRangeController.clear();
                      requirementsController.clear();
                      daysController.clear();

                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                    child: const Text('Add Job'),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
