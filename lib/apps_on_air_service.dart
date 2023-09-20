import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flutter_app_update_package_platform_interface.dart';
import 'src/model/app_info_model.dart';

class AppsOnAir {
  ///
  ///[context] is required to show dialog
  ///
  ///[appId] is required to connect with server
  ///
  ///[showNativeUI] is used to show [customWidget]
  ///you can use your [customWidget] by just return your widget from function
  ///
  ///[showNativeUI] false if you want to show your [customWidget],by default its false
  ///set to 'true' if you want to show native ui.
  ///
  ///[setAppId] initialization of AppsOnAir is Required, you can get your [appID] on https://appsonair.com/,
  ///

  static String _appId = '';

  static bool _showNativeUI = false;

  static setAppId(String appId, {bool showNativeUI = false}) {
    _appId = appId;
    _showNativeUI = showNativeUI;
    
  }

  static void checkForAppUpdate(
    BuildContext context, {
    Widget? Function(AppInfo)? customWidget,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape

    
  }) {
    if (_appId.isNotEmpty) {
      if (!_showNativeUI && customWidget == null) {
        throw Exception(
          "set showNativeUI = 'true' in  setAppId()"
          " or/else return your custom widget in checkForAppUpdate() Method ",
        );
      
      } else if (_showNativeUI && customWidget != null) {
        _printWarning(
            "set showNativeUI = 'false' to show custom ui in setAppId() or/else remove custom widget from checkForAppUpdate() method");
      }
      FlutterAppUpdatePackagePlatform.instance.initMethod(
        context,
          appId: _appId,
          showNativeUI: _showNativeUI,
          customWidget: customWidget ,
          padding: padding,
          shape: shape
          );
    } else {
      throw Exception(
          "Make sure you initialized AppsOnAir by calling initialize() method");
    }
  }

  static void _printWarning(String text) {
    if (kDebugMode) {
      print('[33m$text[0m');
    }
  }
}
