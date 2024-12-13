import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:one_chatgpt_flutter/utils/log.dart';
import 'package:one_chatgpt_flutter/utils/validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});
  @override
  State<UpdatePassword> createState() => _UpdatePassword();
}

class _UpdatePassword extends State<UpdatePassword> {
  final supabase = Supabase.instance.client;
  final GlobalKey _formKey = GlobalKey<FormState>();

  bool _hideObscureText = true;
  bool _hideRepeatObscureText = true;

  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userRepeatPasswordController = TextEditingController();

  Future<void> _onSubmit() async {
    try {
      if (!(_formKey.currentState as FormState).validate()) return;
      SmartDialog.showLoading(msg: "请稍候...");
      FocusScope.of(context).unfocus();
      await supabase.auth.updateUser(
        UserAttributes(
          password: userPasswordController.text,
        ),
      );
      SmartDialog.showToast("密码修改成功，下次登录请使用新密码");
    } catch (err) {
      Log.e("UpdatePassword错误===>$err");
      if (err is AuthException) {
        if (err.statusCode == '422') {
          SmartDialog.showToast("新密码和旧密码相同，请检查");
        } else {
          SmartDialog.showToast("服务错误，请稍候再试");
        }
      } else {
        SmartDialog.showToast("系统错误，请稍候再试");
      }
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("修改密码"),
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
                obscureText: _hideObscureText,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outlined),
                  labelText: '新密码',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "请输入新密码",
                  helperText: "最少6位，包括至少1个字母，1个数字",
                  suffixIcon: userPasswordController.text.isNotEmpty
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
                  if (value!.isEmpty) return "请输入新密码";
                  if (!Validator.validatorPassword(value)) return "请输入正确的新密码";
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    userPasswordController.text = val;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: _hideRepeatObscureText,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outlined),
                  labelText: '新密码',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "请再次输入新密码",
                  helperText: "请再次输入新密码",
                  suffixIcon: userRepeatPasswordController.text.isNotEmpty
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
                  if (value!.isEmpty) return "请输入新密码";
                  if (value != userRepeatPasswordController.text) {
                    return "两次输入密码不一致";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    userRepeatPasswordController.text = val;
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
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 圆角按钮
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
