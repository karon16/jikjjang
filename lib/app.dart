import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/views/authentication_page.dart';
import 'package:jikjjang_app/features/job_seeker/home/views/home_screen.dart';
import 'package:jikjjang_app/features/job_seeker/jobs/views/jobs_screen.dart';
import 'package:jikjjang_app/features/job_seeker/profile/screens/profile_screen.dart';
import 'package:jikjjang_app/navigation/jobseeker_navigation_menu.dart';
import 'package:jikjjang_app/navigation/recruiter_navigation_menu.dart';
import 'package:jikjjang_app/utils/theme/theme.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    // Ensure that MaterialApp is always returned and properly handles user state
    return MaterialApp(
      title: 'Jikjjang App',
      themeMode: ThemeMode.system,
      theme: JAppTheme.lightTheme,
      darkTheme: JAppTheme.darkTheme,
      home: user == null
          ? const NavigationMenu() // Direct to login if no user
          : (user.role == 'jobSeeker'
              ? const NavigationMenu() // JobSeeker specific navigation
              : const RecruiterNavigationMenu()), // Recruiter specific navigation
      routes: {
        '/home': (context) => const MyHomePage(),
        '/jobs': (context) => const JobsScreen(),
        '/profile': (context) => const ProfileScreen(),
        // Additional routes can be added here
      },
    );
  }
}
