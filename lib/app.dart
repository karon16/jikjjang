import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/views/login_page.dart';
// import 'package:jikjjang_app/features/home/views/home.dart';
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
      home: LoginPage(),
    );
  }
}
