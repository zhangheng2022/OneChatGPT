import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/utils/validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterEmail extends StatefulWidget {
  const RegisterEmail({super.key});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  final supabase = Supabase.instance.client;
  final GlobalKey _formKey = GlobalKey<FormState>();

  bool _hideObscureText = true;
  bool _hideRepeatObscureText = true;

  String _userEmail = "";
  String _userPassword = "";

  bool _isLoading = false;

  Future<void> _onSubmit(context) async {
    if (!(_formKey.currentState as FormState).validate()) return;
    try {
      setState(() => _isLoading = true);
      await supabase.auth.signUp(
        email: _userEmail,
        password: _userPassword,
      );
      _showDialog(context);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          content: Text('注册失败，请检查邮箱'),
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
              helperText: "请输入邮箱",
            ),
            validator: (value) {
              if (value!.isEmpty) return "请输入邮箱";
              if (!Validator.validatorEmail(value)) return "请输入正确的邮箱";
              return null;
            },
            onChanged: (val) {
              setState(() {
                _userEmail = val;
              });
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: _hideObscureText,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outlined),
              labelText: '密码',
              border: const OutlineInputBorder(),
              hintText: "请输入密码",
              helperText: "最少6位，包括至少1个字母，1个数字",
              suffixIcon: _userPassword.isNotEmpty
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
                _userPassword = val;
              });
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: _hideRepeatObscureText,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outlined),
              labelText: '密码',
              border: const OutlineInputBorder(),
              hintText: "请再次输入密码",
              helperText: "请再次输入密码",
              suffixIcon: _userPassword.isNotEmpty
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
              if (value != _userPassword) return "两次输入密码不一致";
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
          '注册成功',
          textAlign: TextAlign.center,
        ),
        icon: Icon(
          Icons.check_circle,
          size: 80,
          color: Theme.of(context).primaryColor,
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: const SizedBox(
          child: Text(
            '下一步，请前往邮箱激活',
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          FilledButton(
            child: const Text('返回登录'),
            onPressed: () {
              context
                ..pop()
                ..pop();
            },
          ),
        ],
      );
    },
  );
}
