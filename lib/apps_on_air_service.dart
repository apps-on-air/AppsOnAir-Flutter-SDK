import 'package:flutter/material.dart';

import 'flutter_app_update_package_platform_interface.dart';

class AppsOnAir {
  ///
  ///[context] is required to show dialog
  ///
  ///[appId] is required to connect with server
  ///
  ///[showNativeUI] is used to show [customWidget]
  ///you can use your [customWidget] by just return your widget from function
  ///
  ///[showNativeUI] false if you want to show your [customWidget],by default its true
  ///
  ///[initialize] initialization of AppsOnAir is Required, you can get your [appID] on https://appsonair.com/,
  ///

  static String _appId = '';

  static initialize(String appId) {
    _appId = appId;
  }

  static Future<void> checkUpdateAvailable(
    BuildContext context, {
    bool showNativeUI = true,
    Widget Function(Map<String, dynamic>)? customWidget,
  }) {
    if (_appId.isNotEmpty) {
      return FlutterAppUpdatePackagePlatform.instance.initMethod(context,
          appId: _appId,
          showNativeUI: showNativeUI,
          customWidget: customWidget);
    } else {
      throw Exception(
          "Make sure you initialized AppsOnAir by calling initialize() method");
    }
  }
}
