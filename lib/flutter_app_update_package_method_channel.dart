import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flutter_app_update_package_platform_interface.dart';
import 'src/model/app_info_model.dart';

/// An implementation of [FlutterAppUpdatePackagePlatform] that uses method channels.
class MethodChannelFlutterAppUpdatePackage
    extends FlutterAppUpdatePackagePlatform {
  /// The method channel used to interact with the native platform.
  late BuildContext context;
  bool _dialogOpen = false;
  @visibleForTesting
  final methodChannel = const MethodChannel('updateCheck/isUpdateAvailable');

  ///[context] is required to show dialog
  ///[isShowNative] is used to show [customWidget]
  ///[isShowNative] turn it off if you want to show your [customWidget]
  /// you can show your [customWidget] ui
  
  @override
  Future<void> initMethod(
    BuildContext context, {
    required String appId,
    bool showNativeUI = false,
    Widget? Function(AppInfo response)? customWidget,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape
    
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      this.context = context;

      final result = await methodChannel.invokeMethod(
          'setApplicationID', {"AppId": appId, "showNativeUI": showNativeUI});
      if (result) {
        
        _listenToNativeMethod();
        final appUpdateResponse = await _check();
        if (customWidget != null) {
        
          
          final widget = customWidget.call(appUpdateResponse);
        
          ///custom ui dialog
          if (!showNativeUI && widget != null) {
            if(Platform.isAndroid){
              if(appUpdateResponse.updateData?.isAndroidForcedUpdate == true || appUpdateResponse.updateData?.isAndroidUpdate == true){
                _alertDialog(widget,
                 padding: padding, shape: shape);
                 }
              }else{
                if(appUpdateResponse.updateData?.isIosForcedUpdate == true || appUpdateResponse.updateData?.isIosUpdate == true){
                   _alertDialog(widget,
                 padding: padding, shape: shape);

                }
              }
            }

           
        }
      }
    });
  }





  void _listenToNativeMethod() {
   
    if (Platform.isIOS) {
      methodChannel.setMethodCallHandler((call) {
        switch (call.method) {
          case "openDialog":
            _showIgnorePointerDialog();
            break;
          case "closeDialog":
            if (_dialogOpen) {
            
              _dialogOpen = false;
              _closeDialog();
            }
        }
        return Future.sync(() => _dialogOpen);
      },
    );  
    }
  }


  // while native dialog is open (in IOS), Flutter ui is still accessible
  // This dialog is solution for to prevent flutter ui access
  void _showIgnorePointerDialog() {
    
    if (!_dialogOpen) {
      _dialogOpen = true;
     
      showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        barrierColor: Colors.transparent,
        builder: (context) => Container(
          color: Colors.transparent,
        ),
      );
     }
  }

  void _closeDialog() => Navigator.pop(context);

  void _alertDialog(Widget widget, {required EdgeInsetsGeometry? padding,required  ShapeBorder? shape}) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: 
          AlertDialog(
          

            shape: shape ??   RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: padding ?? const EdgeInsets.symmetric(vertical: 5),
            content: widget  
             )
         
        );
      },
    );
  }

  Future<AppInfo> _check() async {
    String updateCheck = '';
    try {
      final result = await methodChannel.invokeMethod(
        'isUpdateAvailable',
      );
      if (result != null && result.isNotEmpty   ) {

      return  Platform.isIOS ? 
      
      /// jsonData is getting with type Map<Object?, Object?> so while parsing we are getting error of type mismatch
    /// so right now now we are using jsonEncode and jsonDecode to solve this
    
         AppInfo.fromJson(json.decode(json.encode( result)) ): AppInfo.fromJson(json.decode(result) );
      }
   
      return AppInfo.fromJson(( result ) );
    } on PlatformException catch (e) {
      updateCheck = "Failed to check for update: '${e.message}'.";
    }
    if (kDebugMode) {
      print(AppInfo(updateData: UpdateData(updateCheck: updateCheck)));
    }
    return AppInfo(updateData: UpdateData(updateCheck: updateCheck));
  
  }
}
