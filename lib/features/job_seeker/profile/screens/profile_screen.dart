import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/common/widgets/appbar/appbar.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/features/authentication/views/authentication_page.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        JAppBar(
          showBackArrow: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await authController.signOut();
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationPage()),
                  );
                }
              },
            ),
          ],
          // bottom: null,
        ),
        const Text('Profile Page')
      ],
    )));
  }
}
