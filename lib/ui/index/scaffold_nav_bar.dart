import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavBar extends StatefulWidget {
  const ScaffoldNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<ScaffoldNavBar> createState() => _ScaffoldNavBarState();
}

class _ScaffoldNavBarState extends State<ScaffoldNavBar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持页面状态
  @override
  Widget build(BuildContext context) {
    super.build(context); // 需要调用super.build(context)
    return Scaffold(
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.grey[100],
          onDestinationSelected: (int index) => _toPageIndex(index, context),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: _currentPageIndex(context),
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
    int index = 0; // Default to the first tab
    if (path.startsWith('/person')) {
      // Check if the path starts with '/person'
      index = 1; // Set to the second tab if true
    }
    return index; // Return the determined index
  }

  void _toPageIndex(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed('home');
        break; // Add break to prevent fall-through
      case 1:
        context.goNamed('person');
        break; // Add break to prevent fall-through
    }
  }
}
