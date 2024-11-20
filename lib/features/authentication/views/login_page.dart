import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/controllers/auth_providers.dart';
import 'package:jikjjang_app/features/home/views/home.dart';
import 'package:jikjjang_app/navigation_menu.dart';
import 'package:jikjjang_app/utils/constants/image_strings.dart';
import 'package:jikjjang_app/utils/constants/text_strings.dart';
// Assuming your theme is imported here

class LoginPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final user = ref.watch(authControllerProvider);

    if (user != null) {
      return const NavigationMenu();
    }

    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Empty space or margin at the top
              const SizedBox(height: 50), // Add some space at the top

              const SizedBox(height: 20),
              // Login tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Personal login',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Corporate login',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 40),
              // Logo
              Image.asset(JImage_strings.jikjjangLogo, width: 200),
              const SizedBox(height: 30),
              // Welcome message
              Text(
                '${JTextStrings.loginWelcome}',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '${JTextStrings.loginWelcomeBody}',
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
              Container(
                width: double.infinity, // Makes the button span the full width
                child: ElevatedButton(
                  onPressed: () async {
                    await authController.signInWithEmail(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                  },
                  child: Text("Login"),
                ),
              ),
              const SizedBox(height: 8),
              // Additional links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child:
                        Text('Forgot my ID', style: theme.textTheme.bodySmall),
                  ),
                  const Text('|'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Forgot my password',
                        style: theme.textTheme.bodySmall),
                  ),
                  const Text('|'),
                  TextButton(
                    onPressed: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await authController.signInWithGoogle();
                    },
                    icon: SizedBox(
                      width: 46,
                      height: 46,
                      child: Image.asset('assets/logos/search.png'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 46,
                      height: 46,
                      child: Image.asset('assets/logos/naver.png'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 46,
                      height: 46,
                      child: Image.asset('assets/logos/kakao-talk.png'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 46,
                      height: 46,
                      child: Image.asset('assets/logos/facebook.png'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 46,
                      height: 46,
                      child: Image.asset('assets/logos/apple.png'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
