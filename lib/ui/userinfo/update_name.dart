import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/widgets/circular_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({super.key});
  @override
  State<UpdateName> createState() => _UpdateName();
}

class _UpdateName extends State<UpdateName> {
  final supabase = Supabase.instance.client;
  final GlobalKey _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  TextEditingController userNameController = TextEditingController();

  Future<void> _onSubmit() async {
    try {
      if (!(_formKey.currentState as FormState).validate()) return;
      setState(() => _isLoading = true);
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'full_name': userNameController.text},
        ),
      );
    } catch (err) {
      Log.e("updateUser错误===>$err");
      Fluttertoast.showToast(
        msg: "修改失败，请检查",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("保存"),
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
                autofocus: false,
                controller: userNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "请输入用户名",
                  suffixIcon: userNameController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            // 清除文本
                            userNameController.clear();
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "请输入用户名";
                  return null;
                },
                onChanged: (val) {
                  userNameController.text = val;
                },
              ),
              // const SizedBox(height: 20),
              // SizedBox(
              //   width: double.infinity,
              //   height: 50,
              //   child: FilledButton.icon(
              //     icon: _isLoading
              //         ? const CircularProgressWidget()
              //         : const Icon(Icons.save_outlined),
              //     label: const Text("保存"),
              //     onPressed: _isLoading ? null : _onSubmit,
              //     style: FilledButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10), // 圆角按钮
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
