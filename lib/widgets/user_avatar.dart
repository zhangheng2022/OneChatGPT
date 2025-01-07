import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class UserAvatar extends StatefulWidget {
  final double radius; // 添加 radius 参数
  final String url; // 添加 url 参数
  final bool isUpload; // 添加 isUpload 参数

  const UserAvatar({
    super.key,
    required this.radius,
    required this.url,
    this.isUpload = false,
  });

  @override
  UserAvatarState createState() => UserAvatarState();
}

class UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(widget.url),
      radius: widget.radius,
      backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
      child: Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isUpload ? handleImageSelection : null,
        ),
      ),
    );
  }

  // 处理图片选择
  Future<void> handleImageSelection() async {
    // 选择图片
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // 如果没有选择图片，则返回
    if (file == null) return;

    final CroppedFile? result = await _cropImage(File(file.path));
    if (result == null) return;

    try {
      // 生成图片名称
      if (!mounted) return;
      SmartDialog.showLoading(msg: "请稍候...");
      User? user = context.read<AuthProvider>().user;
      String imageName = '${user?.id}${path.extension(result.path)}';
      String storageFile = await supabase.storage.from('user_avatar').upload(
            imageName,
            File(result.path),
            fileOptions: const FileOptions(upsert: true),
          );

      String imagePath =
          '${dotenv.get('SUPABASE_URL', fallback: null)}/storage/v1/object/public/$storageFile';

      await supabase.auth.updateUser(
        UserAttributes(
          data: {'avatar_url': imagePath},
        ),
      );
      SmartDialog.dismiss(status: SmartStatus.loading);
      SmartDialog.showToast("修改成功");
    } catch (err) {
      // 处理错误
      debugPrint(err.toString());
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Theme.of(context).colorScheme.primary,
          statusBarColor: Theme.of(context).colorScheme.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          cropStyle: CropStyle.circle,
          showCropGrid: true,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );
    return croppedImage;
  }
}
