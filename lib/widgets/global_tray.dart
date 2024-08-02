import 'dart:io';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class GlobalTray extends StatefulWidget {
  const GlobalTray({super.key, required this.child});

  final Widget child;
  @override
  State<GlobalTray> createState() => _GlobalTray();
}

class _GlobalTray extends State<GlobalTray> with TrayListener {
  @override
  void initState() {
    trayManager.addListener(this);
    super.initState();
    _init();
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  Future<void> _init() async {
    await trayManager.setIcon(
      Platform.isWindows ? 'assets/logos/logo.ico' : 'assets/logos/logo.png',
    );
    Menu menu = Menu(
      items: [
        MenuItem(
          key: 'app_close',
          label: '退出',
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  @override
  void onTrayIconMouseDown() {
    windowManager.show();
  }

  @override
  void onTrayIconRightMouseDown() {
    // do something
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseUp() {
    // do something
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    Log.i(menuItem.key);
    if (menuItem.key == 'app_close') {
      _appClose();
    }
  }

  Future<void> _appClose() async {
    await windowManager.setPreventClose(false);
    await windowManager.close();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
