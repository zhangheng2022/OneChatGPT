import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chatgpt_flutter/ui/auth/widgets/email_register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_chatgpt_flutter/utils/validator.dart';
import 'package:one_chatgpt_flutter/widgets/circular_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final supabase = Supabase.instance.client;
  final GlobalKey _formKey = GlobalKey<FormState>();

  String _userEmail = "";
  bool _isLoading = false;

  Future<void> _onSubmit() async {
    if (!(_formKey.currentState as FormState).validate()) return;
    try {
      setState(() => _isLoading = true);
      await supabase.auth.resetPasswordForEmail(
        _userEmail,
        redirectTo: "https://lanhuapp.com",
      );
      _showDialog();
    } catch (err) {
      SmartDialog.showToast('邮箱或密码不正确，请检查');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("重置密码"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                "assets/logos/logo.gif", // The path to your local image
                height: 90, // Optional, adjust the height as needed
                fit: BoxFit.cover, // Maintain the aspect ratio of the image
              ),
              Text(
                "ONE CHAT GPT",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: GoogleFonts.anton().fontFamily,
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(20.0), // 增加边距
                child: Form(
                  key: _formKey,
                  child: (Column(
                    children: <Widget>[
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outlined),
                          labelText: '邮箱',
                          hintText: "请输入邮箱",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "请输入邮箱";
                          if (!Validator.validatorEmail(value)) {
                            return "请输入正确的邮箱";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            _userEmail = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton.icon(
                          icon: _isLoading
                              ? CircularProgressWidget(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                )
                              : const Icon(Icons.lock_reset),
                          label: const Text("重置密码"),
                          onPressed: _isLoading ? null : _onSubmit,
                        ),
                      )
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '发送成功',
            textAlign: TextAlign.center,
          ),
          icon: Icon(
            Icons.check_circle,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          actionsAlignment: MainAxisAlignment.center,
          content: const SizedBox(
            child: Text(
              '下一步，请前往邮箱修改',
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
}
