import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  bool _showObscureText = false;
  // Object _form = {String mail: "", password: ""};

  Widget build(BuildContext context) {
    return Form(
      child: (Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.mail_outlined),
              labelText: '邮箱',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              return '请输入正确的邮箱地址';
            },
            onSaved: (val) {},
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: _showObscureText,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outlined),
              labelText: '密码',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  setState(() {
                    _showObscureText = !_showObscureText;
                  });
                },
              ),
            ),
            validator: (value) {
              return '请输入正确的邮箱地址';
            },
            onSaved: (val) {},
            onChanged: (value) {},
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              style: const ButtonStyle(),
              icon: const Icon(Icons.login),
              label: const Text("登录"),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          )
        ],
      )),
    );
  }
}
