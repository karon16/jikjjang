import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/common/widgets/login/social_media_login_row.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/features/authentication/views/personal%20authentication/jikjjang_signup.dart';

class PersonalSignupPage extends ConsumerWidget {
  const PersonalSignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text('Login with',
                  style:
                      theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
              const SizedBox(height: 5),
              SocialMediaLoginRow(
                onGoogleSignInOrSignUP: () async {
                  await authController
                      .signInWithGoogle(); // Sign up with Google
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Makes the button span the full width
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JikjjangSignup()),
                    );
                  },
                  child: const Text("Or signup with Jikjjang"),
                ),
              ),
            ],
          )),
    );
  }
}
