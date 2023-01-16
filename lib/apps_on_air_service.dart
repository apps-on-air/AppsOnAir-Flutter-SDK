import 'package:flutter/material.dart';

import 'flutter_app_update_package_platform_interface.dart';

class AppsOnAirService {
  ///
  ///[context] is required to show dialog
  ///
  ///[appId] is required to connect with backend
  ///
  ///[isShowNativeUI] is used to show [customWidget]
  ///you can use your [customWidget] by just return your widget from function 
  ///
  ///[isShowNativeUI] false if you want to show your [customWidget],by default its true
  ///
  

  static Future<Map<String, dynamic>?> checkUpdateAvailable(
    BuildContext context, {
    required String appId,
    bool isShowNativeUI = false,
    Widget Function(Map<String, dynamic>)? customWidget,
  }) {
    return FlutterAppUpdatePackagePlatform.instance.initMethod(context,
        appId: appId,
        isShowNativeUI: isShowNativeUI,
        customWidget: customWidget);
  }
}
