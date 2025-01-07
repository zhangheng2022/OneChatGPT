import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';

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
  bool _isCanPop = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _isCanPop,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        debugPrint('didPop: $didPop, result: $result');
        if (!didPop) {
          SmartDialog.showToast('再按一次退出');
          setState(() {
            _isCanPop = true;
          });
          Timer(const Duration(seconds: 2), () {
            setState(() {
              _isCanPop = false;
            });
          });
        }
      },
      child: Scaffold(
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
      ),
    );
  }

  void _toPageIndex(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
