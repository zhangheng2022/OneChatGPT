import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/authentication.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({super.key});
  @override
  State<UpdateName> createState() => _UpdateName();
}

class _UpdateName extends State<UpdateName> {
  final supabase = Supabase.instance.client;
  final GlobalKey _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  Future<void> _onSubmit() async {
    try {
      if (!(_formKey.currentState as FormState).validate()) return;
      SmartDialog.showLoading(msg: "请稍候...");
      FocusScope.of(context).unfocus();
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'full_name': userNameController.text},
        ),
      );
      SmartDialog.showToast("修改成功");
    } catch (err) {
      Log.e("updateUser错误===>$err");
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
        userNameController.text = user.userMetadata?['full_name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("修改用户名"),
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
                maxLength: 10,
                controller: userNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "请输入用户名",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // 圆角边框
                  ),
                  suffixIcon: userNameController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              userNameController.clear();
                            });
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "请输入用户名";
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    userNameController.text = val;
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
