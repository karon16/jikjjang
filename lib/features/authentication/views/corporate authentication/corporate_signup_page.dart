import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/utils/helpers/helper_functions.dart';

class CorporateSignup extends ConsumerWidget {
  const CorporateSignup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controllers for each field
    final phoneController = TextEditingController();
    final codeController = TextEditingController();
    final userIdController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final companyRegController = TextEditingController();
    final companyNameController = TextEditingController();
    final companyAddressController = TextEditingController();
    final detailedAddressController = TextEditingController();
    final companyLogoController = TextEditingController();
    final companyDescriptionController = TextEditingController();
    final companyIndustryController = TextEditingController();
    File? _companyLogo;

    bool isAgreementChecked = false;


    Future<void> pickCompanyLogo() async {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _companyLogo = File(pickedFile.path);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Corporate Sign-Up"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Phone Number + Request Confirmation
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Logic to send confirmation code
                  },
                  child: const Text("Request Confirmation"),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            

            // Code Confirmation
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: codeController,
                    decoration: const InputDecoration(
                      labelText: "Code Confirmation",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Logic to confirm code
                  },
                  child: const Text("Confirm"),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // User ID
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(
                labelText: "User ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Corporate Email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Corporate Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Confirm Password
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Company Registration Number
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: companyRegController,
                    decoration: const InputDecoration(
                      labelText: "Company Registration Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Logic to verify company registration
                  },
                  child: const Text("Verify"),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Company Name
            TextField(
              controller: companyNameController,
              decoration: const InputDecoration(
                labelText: "Company Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Company Logo
            GestureDetector(
              onTap: pickCompanyLogo,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: _companyLogo == null
                    ? const Icon(Icons.camera_alt)
                    : Image.file(File(_companyLogo!.path)),
              ),
            ),
            const SizedBox(height: 16.0),

            // Company Description
            TextField(
              controller: companyDescriptionController,
              decoration: const InputDecoration(
                labelText: "Company Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: companyIndustryController,
              decoration: const InputDecoration(
                  labelText: "Company Industry", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16.0),


            // Company Address with Search
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: companyAddressController,
                    decoration: const InputDecoration(
                      labelText: "Company Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Logic to search address
                  },
                  child: const Text("Search Address"),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Detailed Address
            TextField(
              controller: detailedAddressController,
              decoration: const InputDecoration(
                labelText: "Detailed Address",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Agreement Checkbox
            Row(
              children: [
                Checkbox(
                  value: isAgreementChecked,
                  onChanged: (value) {
                    isAgreementChecked = value!;
                  },
                ),
                const Expanded(
                  child: Text("I agree to the confidentiality conditions."),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Sign-Up Button
            ElevatedButton(
              onPressed: () async {
                // Collect data and call the sign-up logic
                final userId = userIdController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                final companyName = companyNameController.text.trim();
                final companyAddress = companyAddressController.text.trim();
                companyLogoController.text.trim();
                final companyDescription =
                    companyDescriptionController.text.trim();
                final companyIndustry = companyIndustryController.text.trim();

                final helper = HelperFunctions();
                final imageUrl =
                    await helper.uploadImage(_companyLogo!, 'company_images');

                if (isAgreementChecked) {
                  // Call signup logic with recruiter role
                  try {
                    await ref
                        .read(authControllerProvider.notifier)
                        .signUpWithEmail(
                          email: email,
                          password: password,
                          name: userId,
                          role: 'jobRecruiter',
                          companyName: companyName,
                          companyAddress: companyAddress,
                          companyLogo: imageUrl,
                          companyDescription: companyDescription,
                          companyIndustry: companyIndustry,

                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup successful!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signup failed: $e')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
