import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/controllers/auth_providers.dart';

class JikjjangSignup extends ConsumerWidget {
  const JikjjangSignup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define the controllers for text fields
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final phoneController = TextEditingController();
    final codeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        centerTitle: false,
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
                    controller: phoneController, // Added controller
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Request Confirmation"),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Code Confirmation + Confirm Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: codeController, // Added controller
                    decoration: const InputDecoration(
                      labelText: "Code Confirmation",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Confirm"),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // ID Field
            TextField(
              controller: nameController, // Added controller
              decoration: const InputDecoration(
                labelText: "Enter your ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Name Field
            TextField(
              controller: nameController, // Added controller
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Email Field
            TextField(
              controller: emailController, // Added controller
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password Field
            TextField(
              controller: passwordController, // Added controller
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Confirm Password Field
            TextField(
              controller: confirmPasswordController, // Added controller
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Checkbox for Agreement
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Expanded(
                  child: Text("I agree to the Confidential Policy"),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Create Account Button
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                // Role is hardcoded here as `jobSeeker`, but you can make it dynamic
                const role = 'jobSeeker';

                // Call signup logic
                try {
                  await ref
                      .read(authControllerProvider.notifier)
                      .signUpWithEmail(
                        email: email,
                        password: password,
                        name: name,
                        role: role,
                      );
                  // Navigate to another page after signup success
                } catch (e) {
                  // Handle errors
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signup failed: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Create Account"),
            )
          ],
        ),
      ),
    );
  }
}
