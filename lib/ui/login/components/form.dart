import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: (Column(
        children: [
          TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: '邮箱',
                  prefixIcon: Icon(Icons.mail),
                  enabledBorder: InputBorder.none),
              validator: (value) {
                return '请输入正确的邮箱地址';
              },
              onSaved: (val) {}),
          TextFormField(
              decoration: const InputDecoration(labelText: '密码'),
              validator: (value) {
                return '请输入正确的邮箱地址';
              },
              onSaved: (val) {}),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("立即注册"), Text("忘记密码？")])
        ],
      )),
    );
  }
}
