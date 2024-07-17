import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/common/log.dart';

class ScaffoldNavBar extends StatefulWidget {
  const ScaffoldNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldNavBar> createState() => _ScaffoldNavBarState();
}

class _ScaffoldNavBarState extends State<ScaffoldNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) => _toPageIndex(context, index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: widget.navigationShell.currentIndex,
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
      ),
    );
  }

  void _toPageIndex(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    Log.d('$index|${widget.navigationShell.currentIndex}');
  }
}
