import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterEmail extends StatefulWidget {
  const RegisterEmail({super.key});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  bool _hideObscureText = true;
  bool _hideRepeatObscureText = true;
  final _form = Map.from({'emali': '', 'password': ''});
  final GlobalKey _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  Future<void> _onSubmit(context) async {
    if (!(_formKey.currentState as FormState).validate()) return;
    try {
      setState(() => _isLoading = true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _form['email'],
        password: _form['password'],
      );
      _showDialog(context);
    } on FirebaseAuthException catch (err) {
      log(err.code, level: 1);
      String errMessage = "";
      if (err.code == 'email-already-in-use') {
        errMessage = "该邮箱的帐户已存在";
      } else if (err.code == 'weak-password') {
        errMessage = "您的密码太简单了，请重新输入";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            content: Text(errMessage)),
      );
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          content: Text('系统错误，请稍后再试'),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: (Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.mail_outlined),
              labelText: '邮箱',
              border: OutlineInputBorder(),
              hintText: "请输入邮箱",
            ),
            validator: (value) {
              if (value!.isEmpty) return "请输入邮箱";
              if (!Validator.validatorEmail(value)) return "请输入正确的邮箱";
              return null;
            },
            onChanged: (val) {
              setState(() {
                _form['email'] = val;
              });
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: _hideObscureText,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outlined),
              labelText: '密码',
              border: const OutlineInputBorder(),
              hintText: "请输入密码",
              helperText: "最少6位，包括至少1个字母，1个数字",
              suffixIcon: _form['password']!.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          _hideObscureText = !_hideObscureText;
                        });
                      },
                    )
                  : null,
            ),
            validator: (value) {
              if (value!.isEmpty) return "请输入密码";
              if (!Validator.validatorPassword(value)) return "请输入正确的密码";
              return null;
            },
            onChanged: (val) {
              setState(() {
                _form['password'] = val;
              });
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: _hideRepeatObscureText,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outlined),
              labelText: '密码',
              border: const OutlineInputBorder(),
              hintText: "请再次输入密码",
              helperText: "请再次输入密码",
              suffixIcon: _form['password']!.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          _hideRepeatObscureText = !_hideRepeatObscureText;
                        });
                      },
                    )
                  : null,
            ),
            validator: (value) {
              if (value!.isEmpty) return "请输入密码";
              if (value != _form['password']) return "两次输入密码不一致";
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              icon: _isLoading ? loading(context) : const Icon(Icons.add),
              label: const Text("注册"),
              onPressed: () {
                if (!_isLoading) _onSubmit(context);
              },
            ),
          )
        ],
      )),
    );
  }
}

Widget loading(BuildContext context) {
  return const SizedBox(
    width: 24,
    height: 24,
    child: CircularProgressIndicator(color: Colors.white),
  );
}

Future<void> _showDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '恭喜您，注册成功',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: SingleChildScrollView(
          child: Icon(
            Icons.check_circle,
            size: 120,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: <Widget>[
          FilledButton.tonal(
            child: const Text('返回'),
            onPressed: () {
              Navigator.of(context)
                ..pop()
                ..pop();
            },
          ),
        ],
      );
    },
  );
}
