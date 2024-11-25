import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/navigation/navigation_menu.dart';
import 'package:jikjjang_app/navigation/recruiter_navigation_menu.dart';
import 'package:jikjjang_app/utils/theme/theme.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'Jikjjang App',
      themeMode: ThemeMode.system,
      theme: JAppTheme.lightTheme,
      darkTheme: JAppTheme.darkTheme,
      home: user == null
          ? const NavigationMenu()
          : (user.role == 'jobSeeker'
              ? const NavigationMenu()
              : const RecruiterNavigationMenu()),
    );
  }
}
