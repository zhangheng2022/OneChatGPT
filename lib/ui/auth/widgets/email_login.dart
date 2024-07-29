import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/utils/validator.dart';
import 'package:one_chatgpt_flutter/widgets/circular_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:one_chatgpt_flutter/common/log.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final supabase = Supabase.instance.client;
  final GlobalKey _formKey = GlobalKey<FormState>();

  bool _hideObscureText = true;

  String _userEmail = "";
  String _userPassword = "";

  bool _isLoading = false;

  Future<void> _onSubmit() async {
    try {
      if (!(_formKey.currentState as FormState).validate()) return;
      setState(() => _isLoading = true);
      await supabase.auth.signInWithPassword(
        email: _userEmail,
        password: _userPassword,
      );
    } catch (err) {
      Log.e("登录错误===>$err");
      SmartDialog.showToast('邮箱或密码不正确，请检查');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0), // 增加边距
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail_outline),
                labelText: '邮箱',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // 圆角边框
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) return "请输入邮箱";
                if (!Validator.validatorEmail(value)) return "请输入正确的邮箱";
                return null;
              },
              onChanged: (val) => setState(() => _userEmail = val),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: _hideObscureText,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: '密码',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // 圆角边框
                ),
                suffixIcon: _userPassword.isNotEmpty
                    ? IconButton(
                        icon: Icon(_hideObscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(
                            () => _hideObscureText = !_hideObscureText),
                      )
                    : null,
              ),
              validator: (value) {
                if (value!.isEmpty) return "请输入密码";
                if (!Validator.validatorPassword(value)) return "请输入正确的密码";
                return null;
              },
              onChanged: (val) => setState(() => _userPassword = val),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                icon: _isLoading
                    ? const CircularProgressWidget()
                    : const Icon(Icons.send),
                label: const Text("登录"),
                onPressed: _isLoading ? null : _onSubmit,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 圆角按钮
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('忘记密码?'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
