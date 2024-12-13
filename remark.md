### 常用 Flutter 命令

#### 生成代码相关
# 监听文件变化并自动生成代码(推荐)
dart run build_runner watch --delete-conflicting-outputs

# 一次性生成代码
dart run build_runner build --delete-conflicting-outputs

#### Flutter 包管理
# 获取依赖包
flutter pub get

# 更新依赖包到最新版本
flutter pub upgrade

#### 打包发布
# 打包 Android APK
flutter build apk

# 打包 Android Bundle
flutter build appbundle

# 打包 iOS
flutter build ios

#### 调试相关
# 清理构建缓存
flutter clean

# 显示所有已连接设备
flutter devices

# 运行应用
flutter run
