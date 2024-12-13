import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:one_chatgpt_flutter/state/theme.dart';
import 'package:provider/provider.dart';

class SystemSetting extends StatefulWidget {
  const SystemSetting({super.key});

  @override
  State<SystemSetting> createState() => _SystemSettingState();
}

class _SystemSettingState extends State<SystemSetting> {
  @override
  Widget build(BuildContext context) {
    String currentThemeKey = context.watch<ThemeProvider>().currentThemeKey;

    return Scaffold(
      appBar: AppBar(
        title: Text("系统设置"),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(18, 18, 0, 0),
                child: Text(
                  "通用",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                title: Text(
                  "主题设置",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: SegmentedButton(
                  showSelectedIcon: true,
                  style: ButtonStyle(iconSize: WidgetStatePropertyAll(14)),
                  segments: [
                    ButtonSegment(
                      value: "system",
                      icon: Icon(Icons.settings_brightness),
                      label: Text(
                        "系统",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    ButtonSegment(
                      value: "light",
                      icon: Icon(Icons.light_mode),
                      label: Text(
                        "亮色",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    ButtonSegment(
                      value: "dark",
                      icon: Icon(Icons.dark_mode),
                      label: Text(
                        "暗黑",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                  selected: {currentThemeKey},
                  onSelectionChanged: (selected) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .updateTheme(selected.first);
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "清除缓存",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: FilledButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.error),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  label: Text("清理"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
