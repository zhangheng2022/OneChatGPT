import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:window_manager/window_manager.dart';

class GlobalWindow extends StatefulWidget {
  const GlobalWindow({super.key, required this.child});

  final Widget child;
  @override
  State<GlobalWindow> createState() => _GlobalWindow();
}

class _GlobalWindow extends State<GlobalWindow> with WindowListener {
  void _init() async {
    // 添加此行以覆盖默认关闭处理程序
    await windowManager.setPreventClose(true);
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  Future<void> onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (!isPreventClose) return;
    await windowManager.hide();
    // SmartDialog.show(
    //   alignment: Alignment.center,
    //   usePenetrate: true,
    //   clickMaskDismiss: true,
    //   useSystem: true,
    //   builder: (context) {
    //     return Container(
    //       width: 80,
    //       height: 80,
    //       color: Colors.green,
    //     );
    //   },
    // );
    // bool? confirmed = await showDialog<bool>(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('确认退出？'),
    //       content: const Text('确定要退出当前账号吗？'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {},
    //           child: const Text('取消'),
    //         ),
    //         TextButton(
    //           onPressed: () {},
    //           child: Text(
    //             '确定',
    //             style: TextStyle(color: Theme.of(context).colorScheme.error),
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );

    // if (confirmed == true) {
    //   await windowManager.destroy();
    // }
  }
}
