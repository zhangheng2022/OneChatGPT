import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/state/theme.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SystemSetting extends StatefulWidget {
  const SystemSetting({super.key});

  @override
  State<SystemSetting> createState() => _SystemSettingState();
}

class _SystemSettingState extends State<SystemSetting> {
  late PackageInfo packageInfo;

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildClearCacheDialog();
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                  label: Text("清理"),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(18, 18, 0, 0),
                child: Text(
                  "其他",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildAboutDialog();
                    },
                  );
                },
                title: Text(
                  "关于我们",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AboutDialog _buildAboutDialog() {
    return AboutDialog(
      applicationIcon: Image.asset(
        "assets/logos/logo.png",
        height: 80,
        fit: BoxFit.cover,
      ),
      applicationName: packageInfo.appName,
      applicationVersion: packageInfo.version,
      applicationLegalese: "© 2024 OneChatGPT",
      children: [
        const SizedBox(height: 20),
        Text(
          "OneChatGPT 是一个开源的多模型 AI 聊天平台，集成了多个主流大语言模型，包括 OpenAI ChatGPT、Google Gemini、百度文心一言和智谱 ChatGLM。",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.code, size: 14),
            const SizedBox(width: 4),
            Text(
              "基于 Flutter 开发",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  AlertDialog _buildClearCacheDialog() {
    return AlertDialog(
      title: Text("清除缓存"),
      content: Text("确定要清除缓存吗？"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("取消"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("清除"),
        ),
      ],
    );
  }
}
