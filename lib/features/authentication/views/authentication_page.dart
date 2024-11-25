import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/features/authentication/views/personal%20authentication/personal_login_page.dart';
import 'package:jikjjang_app/features/authentication/views/corporate%20authentication/corporate_login_page.dart';
import 'package:jikjjang_app/utils/constants/colors.dart';
import 'package:jikjjang_app/utils/constants/enums.dart';

/// Provider to manage the current authentication mode (personal or corporate)
final authModeProvider = StateProvider<AuthMode>((ref) => AuthMode.personal);

class AuthenticationPage extends ConsumerWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authMode = ref.watch(authModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab(
                context: context,
                ref: ref,
                label: 'Personal Login',
                isActive: authMode == AuthMode.personal,
                onTap: () => ref.read(authModeProvider.notifier).state =
                    AuthMode.personal,
              ),
              // const SizedBox(width: 20),
              _buildTab(
                context: context,
                ref: ref,
                label: 'Corporate Login',
                isActive: authMode == AuthMode.corporate,
                onTap: () => ref.read(authModeProvider.notifier).state =
                    AuthMode.corporate,
              ),
            ],
          ),
          // const Divider(height: 20, thickness: 1),
          Expanded(
            child: authMode == AuthMode.personal
                ? PersonalLoginPage()
                : CorporateLoginPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive
                  ? Theme.of(context).primaryColor
                  : JAppColors.textSecondary,
              width: isActive ? 3.0 : 1.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isActive
                ? Theme.of(context).primaryColor
                : JAppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
