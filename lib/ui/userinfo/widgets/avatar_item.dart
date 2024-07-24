import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/state/auth.dart';
import 'package:one_chatgpt_flutter/widgets/circular_progress.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class AvatarItem extends StatelessWidget {
  const AvatarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _handleImageSelection(context);
      },
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
              return SizedBox(
                height: 60,
                child: ClipOval(
                  child: Image.network(
                    avatarUrl,
                    fit: BoxFit.cover,
                  ),
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
  void _handleImageSelection(BuildContext context) async {
    // 选择图片
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // 如果没有选择图片，则返回
    if (file == null) return;
    if (mounted) return;
    final CroppedFile? result = await _cropImage(File(file.path), context);
    if (result == null) return;

    try {
      // 生成图片名称
      String? userID = context.read<AuthProvider>().user?.id ?? '';
      String imageName = '$userID${path.extension(result.path)}';
      String storageFile = await supabase.storage
          .from('user_avatar')
          .upload(imageName, File(result.path));

      String imagePath =
          '${dotenv.get('SUPABASE_URL', fallback: null)}/storage/v1/object/public/$storageFile';

      await supabase.auth.updateUser(
        UserAttributes(
          data: {'avatar_url': imagePath},
        ),
      );
    } catch (err) {
      // 处理错误
      Log.e(err);
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile, BuildContext context) async {
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
