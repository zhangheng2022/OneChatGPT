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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.source),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {},
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '输入你的问题或需求',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
