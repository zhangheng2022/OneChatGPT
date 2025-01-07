import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateMail extends StatefulWidget {
  const UpdateMail({super.key});
  @override
  State<UpdateMail> createState() => _UpdateMail();
}

class _UpdateMail extends State<UpdateMail> {
  final supabase = Supabase.instance.client;
  final GlobalKey _formKey = GlobalKey<FormState>();

  TextEditingController userMailController = TextEditingController();

  Future<void> _onSubmit() async {
    try {
      if (!(_formKey.currentState as FormState).validate()) return;
      SmartDialog.showLoading(msg: "请稍候...");
      FocusScope.of(context).unfocus();
      await supabase.auth.updateUser(
        UserAttributes(
          email: userMailController.text,
        ),
      );
      SmartDialog.showToast("修改成功，请到新邮箱验证");
    } catch (err) {
      SmartDialog.showToast("系统错误，请稍候再试");
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  @override
  void initState() {
    super.initState();
    User? user = context.read<AuthProvider>().user;
    if (user != null) {
      setState(() {
        userMailController.text = user.email ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("修改邮箱"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), // 增加边距
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                maxLength: 30,
                controller: userMailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "请输入新邮箱地址",
                  suffixIcon: userMailController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              userMailController.clear();
                            });
                          },
                        )
                      : null,
                ),
                validator: (value) {
                  if (value!.isEmpty) return "请输入新邮箱地址";
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    userMailController.text = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("保存"),
                  onPressed: _onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
