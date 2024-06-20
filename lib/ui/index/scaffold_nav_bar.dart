import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavBar extends StatelessWidget {
  const ScaffoldNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) => _toPageIndex(index, context),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _currentPageIndex(context),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.ballot),
              icon: Icon(Icons.ballot_outlined),
              label: '对话',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: '我的',
            ),
          ],
        ));
  }

  static int _currentPageIndex(BuildContext context) {
    final String path = GoRouterState.of(context).fullPath.toString();
    int index = 0;
    switch (path) {
      case '/home':
        index = 0;
      case '/person':
        index = 1;
    }
    return index;
  }

  void _toPageIndex(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed('home');
      case 1:
        context.goNamed('person');
    }
  }
}
