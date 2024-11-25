import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/features/recruiter/jobs/controllers/jobs_provider.dart';
import 'package:jikjjang_app/features/recruiter/jobs/models/job_model.dart';

class AddJobScreen extends ConsumerWidget {
  AddJobScreen({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryRangeController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  File? selectedImage;

  final List<String> categories = [
    'Tech & IT',
    'Education',
    'Finance',
    'Health'
  ];
  final List<String> employmentTypes = ['Full-time', 'Part-time', 'Internship'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('job_images/${DateTime.now().millisecondsSinceEpoch}');
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    String selectedCategory = categories.first;
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
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: salaryRangeController,
                decoration: const InputDecoration(labelText: 'Salary Range'),
              ),
              TextField(
                controller: requirementsController,
                decoration: const InputDecoration(labelText: 'Requirements'),
                maxLines: 3,
              ),
              TextField(
                controller: daysController,
                decoration: const InputDecoration(labelText: 'Deadline (days)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
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
              ElevatedButton(
                onPressed: () async {
                  if (selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select an image')));
                    return;
                  }

                  final imageUrl = await _uploadImage(selectedImage!);

                  final newJob = Job(
                    jobID: DateTime.now().millisecondsSinceEpoch.toString(),
                    companyID: user!.companyID,
                    category: selectedCategory,
                    title: titleController.text,
                    description: descriptionController.text,
                    requirements: requirementsController.text.split(','),
                    location: locationController.text,
                    employmentType: selectedEmploymentType,
                    salaryRange: salaryRangeController.text,
                    createdAt: DateTime.now(),
                    expiresAt: DateTime.now()
                        .add(Duration(days: int.parse(daysController.text))),
                    postedBy: user.id,
                    applicants: [],
                    jobImageUrl: imageUrl,
                  );

                  // Add job using the provider.
                  ref.read(addJobProvider).call(newJob);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job added successfully!')),
                  );

                  // Clear the form after submission.
                  titleController.clear();
                  descriptionController.clear();
                  locationController.clear();
                  salaryRangeController.clear();
                  requirementsController.clear();
                  daysController.clear();

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
