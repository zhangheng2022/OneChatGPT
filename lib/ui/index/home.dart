import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_chatgpt_flutter/database/chat_record.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:one_chatgpt_flutter/ui/index/widgets/home_left_drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AppDatabase _database;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _database = Provider.of<AppDatabase>(context);
  }

  Future<void> addChat(PresetEnum preset, String title) async {
    try {
      debugPrint('addChat');
      final chatId = await _database.managers.chatRecord
          .create((row) => row(preset: preset));
      if (!mounted) return;
      context.goNamed(
        'chat',
        queryParameters: {'chatId': chatId.toString()},
      );
    } catch (e) {
      debugPrint('Error adding chat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("对话"),
      ),
      drawer: HomeLeftDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 20),
                Image.asset(
                  "assets/images/pet.gif",
                  height: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Hi，快来和我聊天吧！',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
                    ),
                  ),
                )
              ],
            ),
            Card(
              margin: EdgeInsets.zero,
              child: Container(
                padding: EdgeInsets.all(10),
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  children: [
                    InkWell(
                      onTap: () => addChat(PresetEnum.createImage, '生成图片'),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset("assets/icons/image.png"),
                            ),
                          ),
                          Text('生成图片'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SmartDialog.showToast(
                          "暂未开放",
                          alignment: Alignment.center,
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset("assets/icons/document.png"),
                            ),
                          ),
                          Text('解析文档'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: FilledButton.icon(
                onPressed: () => addChat(PresetEnum.chat, '聊一聊'),
                icon: Icon(Icons.question_answer),
                label: Text(
                  "聊一聊",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.zcoolKuaiLe().fontFamily,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
