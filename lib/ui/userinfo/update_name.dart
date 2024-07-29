import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
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
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'full_name': userNameController.text},
        ),
      );
      SmartDialog.dismiss(status: SmartStatus.loading);
      SmartDialog.showToast("修改成功");
    } catch (err) {
      Log.e("updateUser错误===>$err");
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: _onSubmit,
            label: const Text("保存"),
          )
        ],
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
            ],
          ),
        ),
      ),
    );
  }
}
