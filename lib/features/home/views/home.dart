import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/controllers/auth_providers.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final currentIndex = 0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Jikjjang'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.signOut();
              // Optionally, navigate to the login screen after signing out
            },
          ),
        ],
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello Jikjjang',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

    );
  }
}
