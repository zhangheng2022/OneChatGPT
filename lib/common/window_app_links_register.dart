import 'dart:io';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:win32_registry/win32_registry.dart';

class WindowAppLinksRegister {
  WindowAppLinksRegister(String scheme) {
    String appPath = Platform.resolvedExecutable;
    Log.i(appPath);
    String protocolRegKey = 'Software\\Classes\\$scheme';
    RegistryValue protocolRegValue = const RegistryValue(
      'URL Protocol',
      RegistryValueType.string,
      '',
    );
    String protocolCmdRegKey = 'shell\\open\\command';
    RegistryValue protocolCmdRegValue = RegistryValue(
      '',
      RegistryValueType.string,
      '"$appPath" "%1"',
    );

    final regKey = Registry.currentUser.createKey(protocolRegKey);
    regKey.createValue(protocolRegValue);
    regKey.createKey(protocolCmdRegKey).createValue(protocolCmdRegValue);
  }
}
