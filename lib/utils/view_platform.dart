import 'dart:io';

class ViewPlatform {
  /// 判断是否是桌面端
  static bool isDesktop =
      ['windows', 'macos', 'linux'].contains(Platform.operatingSystem);

  /// 判断是否是移动端
  static bool isMobile = ['android', 'ios'].contains(Platform.operatingSystem);
}
