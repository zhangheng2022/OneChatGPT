import 'package:flutter/material.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});
  @override
  State<Userinfo> createState() => _Userinfo();
}

class _Userinfo extends State<Userinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        actions: [
          TextButton.icon(
            onPressed: () {},
            label: Text("保存"),
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
