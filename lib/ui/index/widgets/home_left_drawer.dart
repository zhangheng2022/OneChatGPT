import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:one_chatgpt_flutter/database/chat_record.dart';
import 'package:one_chatgpt_flutter/database/database.dart';
import 'package:provider/provider.dart';

class HomeLeftDrawer extends StatefulWidget {
  const HomeLeftDrawer({super.key});

  @override
  HomeLeftDrawerState createState() => HomeLeftDrawerState();
}

class HomeLeftDrawerState extends State<HomeLeftDrawer> {
  late AppDatabase _database;

  Stream<List<ChatRecordData>> _chatList = Stream<List<ChatRecordData>>.empty();

  bool _editShow = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _database = Provider.of<AppDatabase>(context);
    _chatList = _database.managers.chatRecord.watch();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> deleteChat(int id) async {
    try {
      await _database.transaction(() async {
        await _database.managers.chatRecord
            .filter((f) => f.id.equals(id))
            .delete();
        await _database.managers.chatRecordDetail
            .filter((f) => f.chatId.equals(id))
            .delete();
      });
    } catch (e) {
      debugPrint('Error deleting chat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取状态栏高度
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // 获取安全区域
    final safePadding = MediaQuery.of(context).padding;
    return Drawer(
      semanticLabel: "对话历史",
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: statusBarHeight + safePadding.top),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "对话历史",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _editShow = !_editShow;
                    });
                  },
                  icon: Icon(Icons.edit_note),
                )
              ],
            ),
            Expanded(
              child: StreamBuilder<List<ChatRecordData>>(
                stream: _chatList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const EmptyState();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Card.filled(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: ListTile(
                            title: Text(
                              snapshot.data![index].title,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Text(
                              DateFormat("MM-dd HH:mm:ss").format(
                                snapshot.data![index].updatedAt,
                              ),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 12,
                              ),
                            ),
                            onTap: () {
                              context.goNamed(
                                'chat',
                                pathParameters: {
                                  'chatId': snapshot.data![index].id.toString()
                                },
                              );
                            },
                            trailing: _editShow
                                ? IconButton(
                                    onPressed: () {
                                      deleteChat(snapshot.data![index].id);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/not_message.png",
            height: 200,
            fit: BoxFit.cover,
          ),
          Text(
            '暂无对话历史',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
