import 'package:flutter/material.dart';

class ChatCustomInput extends StatelessWidget {
  const ChatCustomInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        height: 90,
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.source),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {},
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(hintText: 'qing'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
