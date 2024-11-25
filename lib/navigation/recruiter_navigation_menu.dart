import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/data/providers/global_providers.dart';
import 'package:jikjjang_app/features/authentication/controllers/auth_controllers.dart';
import 'package:jikjjang_app/features/authentication/models/auth_model.dart';
import 'package:jikjjang_app/features/authentication/providers/auth_providers.dart';
import 'package:jikjjang_app/features/authentication/views/authentication_page.dart';
import 'package:jikjjang_app/features/recruiter/jobs/views/jobs_screen.dart';
// import 'package:jikjjang_app/features/job_recruiter/views/dashboard/dashboard_screen.dart';
// import 'package:jikjjang_app/features/job_recruiter/views/job_listings/job_listings_screen.dart';
// import 'package:jikjjang_app/features/job_recruiter/views/candidates/candidates_screen.dart';
// import 'package:jikjjang_app/features/job_recruiter/views/messages/messages_screen.dart';
// import 'package:jikjjang_app/features/job_recruiter/views/profile/profile_screen.dart';

class RecruiterNavigationMenu extends ConsumerWidget {
  const RecruiterNavigationMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the navigation index provider for the recruiter
    final selectedIndex = ref.watch(navigationIndexProvider);
    final user = ref.watch(authControllerProvider);

    if (user == null) {
      return const AuthenticationPage();
    }

    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: Theme.of(context).navigationBarTheme,
        child: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            if (index == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthenticationPage()));
            } else {
              ref.read(navigationIndexProvider.notifier).state = index;
            }
          },
          destinations: [
            NavigationDestination(
                icon: Icon(selectedIndex == 0
                    ? Icons.dashboard
                    : Icons.dashboard_outlined),
                label: 'Dashboard'),
            NavigationDestination(
                icon:
                    Icon(selectedIndex == 1 ? Icons.work : Icons.work_outline),
                label: 'Jobs'),
            NavigationDestination(
                icon: Icon(
                    selectedIndex == 2 ? Icons.people : Icons.people_outline),
                label: 'Candidates'),
            NavigationDestination(
                icon: Icon(selectedIndex == 3
                    ? Icons.message
                    : Icons.message_outlined),
                label: 'Messages'),
            NavigationDestination(
                icon: Icon(
                    selectedIndex == 4 ? Icons.person : Icons.person_outlined),
                label: 'Profile'),
          ],
        ),
      ),
      body: _buildBody(selectedIndex, user),
    );
  }

  // Build body content based on selected index
  Widget _buildBody(int index, UserData user) {
    switch (index) {
      case 0:
        return const Center(child: Text('Dashboard'));
      case 1:
        return JobsScreen(
          companyID: user.companyID,
        );
      case 2:
        return const Center(child: Text('Candidates'));
      case 3:
        return const Center(child: Text('Messages'));
      case 4:
        return const Center(child: Text('Profile'));
      default:
        return const Center(child: Text('Dashboard'));
    }
  }
}
