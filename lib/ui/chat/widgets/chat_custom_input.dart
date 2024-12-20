import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

typedef OnMessageTapCallback = void Function(Message message);
typedef OnMessageSendCallback = void Function(String text);
typedef OnAttachmentTapCallback = VoidCallback;

class ChatCustomInput extends StatefulWidget {
  const ChatCustomInput({super.key});

  @override
  State<ChatCustomInput> createState() => _ChatCustomInputState();
}

class _ChatCustomInputState extends State<ChatCustomInput> {
  final GlobalKey _inputKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateInputHeight());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      context.read<OnMessageSendCallback?>()?.call(text);
      _textController.clear();
    }
  }

  void _updateInputHeight() {
    // final renderBox =
    //     _inputKey.currentContext?.findRenderObject() as RenderBox?;
    // if (renderBox != null) {
    //   context
    //       .read<ChatInputHeightNotifier>()
    //       .updateHeight(renderBox.size.height);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final onAttachmentTap = context.read<OnAttachmentTapCallback?>();
    return Positioned(
      key: _inputKey,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            label: Text("停止生成"),
            icon: Icon(Icons.stop_circle),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              children: [
                if (onAttachmentTap != null) ...[
                  IconButton(
                    icon: Icon(Icons.source),
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: onAttachmentTap,
                  ),
                ],
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    textInputAction: TextInputAction.send,
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: '输入你的问题或需求',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Text(
              "AI也可能犯错，请谨慎判断",
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
