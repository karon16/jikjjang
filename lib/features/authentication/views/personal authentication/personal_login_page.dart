import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/common/widgets/login/social_media_login_row.dart';
import 'package:jikjjang_app/features/authentication/controllers/auth_providers.dart';
import 'package:jikjjang_app/features/authentication/views/personal%20authentication/personal_signup_page.dart';
import 'package:jikjjang_app/navigation_menu.dart';
import 'package:jikjjang_app/utils/constants/image_strings.dart';
import 'package:jikjjang_app/utils/constants/text_strings.dart';

class PersonalLoginPage extends ConsumerWidget {
  PersonalLoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final user = ref.watch(authControllerProvider);

    // Track navigation status to avoid multiple navigations
    final isNavigating = ValueNotifier(false);

    // Check user state and navigate if logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null && !isNavigating.value) {
        isNavigating.value = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationMenu()),
        );
      }
    });

    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo
              Image.asset(JImage_strings.jikjjangLogo, width: 200),
              const SizedBox(height: 30),
              // Welcome message
              Text(
                JTextStrings.loginWelcome,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                JTextStrings.loginWelcomeBody,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              // Email text field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.person_outline, color: theme.iconTheme.color),
                  labelText: 'Email address or userID',
                ),
              ),
              const SizedBox(height: 16),
              // Password text field
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.lock_outline, color: theme.iconTheme.color),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Login button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!isNavigating.value) {
                      isNavigating.value =
                          true; // Set flag to prevent double taps
                      await authController.signInWithEmail(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      isNavigating.value = false; // Reset flag after operation
                    }
                  },
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(height: 8),
              // Additional links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Forgot my password',
                        style: theme.textTheme.bodySmall),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersonalSignupPage()),
                      );
                    },
                    child: Text('Create an account',
                        style: theme.textTheme.bodySmall),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Text('Or login with',
                  style:
                      theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
              const SizedBox(height: 5),
              SocialMediaLoginRow(
                onGoogleSignInOrSignUP: () async {
                  if (!isNavigating.value) {
                    isNavigating.value = true;
                    await authController.signInWithGoogle();
                    isNavigating.value = false;
                  }
                },
                onNaverSignInOrSignUP: () {
                  // Handle Naver sign-in
                },
                onKakaoSignInOrSignUP: () {
                  // Handle Kakao sign-in
                },
                onFacebookSignInOrSignUP: () {
                  // Handle Facebook sign-in
                },
                onAppleSignInOrSignUP: () {
                  // Handle Apple sign-in
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
