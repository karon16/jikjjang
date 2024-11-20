import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikjjang_app/data/providers/global_providers.dart';
import 'package:jikjjang_app/features/home/views/home.dart';

// Define a provider for managing the selected index

class NavigationMenu extends ConsumerWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the navigation index provider to get the current index
    final selectedIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: Theme.of(context).navigationBarTheme,
        child: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            ref.read(navigationIndexProvider.notifier).state = index;
          },
          destinations: [
            NavigationDestination(
                icon:
                    Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                label: 'Home'),
            NavigationDestination(
                icon:
                    Icon(selectedIndex == 1 ? Icons.work : Icons.work_outline),
                label: 'Jobs'),
            NavigationDestination(
                icon:
                    Icon(selectedIndex == 2 ? Icons.chat : Icons.chat_outlined),
                label: 'Forum'),
            NavigationDestination(
                icon: Icon(selectedIndex == 3
                    ? Icons.rocket_launch
                    : Icons.rocket_launch_outlined),
                label: 'Career'),
            NavigationDestination(
                icon: Icon(
                    selectedIndex == 4 ? Icons.person : Icons.person_outlined),
                label: 'Profile')
          ],
        ),
      ),
      body: _buildBody(selectedIndex),
    );
  }

  // This method returns different widgets based on the selected index
  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const Center(child: MyHomePage());
      case 1:
        return const Center(child: Text('Jobs Screen'));
      case 2:
        return const Center(child: Text('Forum Screen'));
      case 3:
        return const Center(child: Text('Career Screen'));
      case 4:
        return const Center(child: Text('Profile Screen'));
      default:
        return const Center(child: Text('Home Screen'));
    }
  }
}
