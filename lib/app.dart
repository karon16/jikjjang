import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/views/authentication_page.dart';

import 'package:jikjjang_app/navigation_menu.dart';
import 'package:jikjjang_app/utils/theme/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: JAppTheme.lightTheme,
      darkTheme: JAppTheme.darkTheme,
      // Set the initial route to NavigationMenu
      initialRoute: '/',
      // Define named routes
      routes: {
        '/': (context) => const NavigationMenu(),
        '/login': (context) => const AuthenticationPage(),
        '/home': (context) => const NavigationMenu(),
      },
    );
  }
}
