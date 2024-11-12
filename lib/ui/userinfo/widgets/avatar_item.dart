import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/authentication.dart';
import 'package:one_chatgpt_flutter/widgets/network_image_with_loading.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class AvatarItem extends StatefulWidget {
  const AvatarItem({super.key});
  @override
  State<AvatarItem> createState() => _AvatarItem();
}

class _AvatarItem extends State<AvatarItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _handleImageSelection,
      title: const Text(
        "头像",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Selector<AuthProvider, User?>(
            selector: (context, state) => state.user,
            builder: (context, data, child) {
              final defaultAvatar =
                  '${dotenv.env['SUPABASE_URL']!}/storage/v1/object/public/common/default_avatar.png';
              final avatarUrl =
                  data?.userMetadata?['avatar_url'] ?? defaultAvatar;
              return ClipOval(
                child: NetworkImageWithLoading(
                  imageUrl: '$avatarUrl?v=${data?.updatedAt}',
                  height: 50,
                  width: 50,
                ),
              );
            },
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  // 处理图片选择
  void _handleImageSelection() async {
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
      Log.e(err);
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
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );
    return croppedImage;
  }
}
