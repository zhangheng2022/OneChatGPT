import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool _hideObscureText = true;
  final _form = Map.from({'emali': '', 'password': ''});
  final GlobalKey _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  Future<void> _onSubmit(context) async {
    if (!(_formKey.currentState as FormState).validate()) return;
    try {
      setState(() => _isLoading = true);
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _form['email'],
        password: _form['password'],
      );
      print(user);
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            content: Text('账号或密码不正确')),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
              if (value!.isEmpty) return "请输入邮箱";
              if (!Validator.validatorEmail(value)) return "请输入正确的邮箱";
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
            },
            onChanged: (val) {
              setState(() {
                _form['password'] = val;
              });
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              icon: _isLoading ? loading(context) : const Icon(Icons.login),
              label: const Text("登录"),
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
