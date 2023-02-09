package com.lwpackage.applicationupdate.flutter_app_update_package

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.appsonair.AppsOnAirServices
import com.appsonair.UpdateCallBack

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterAppUpdatePackagePlugin */
class FlutterAppUpdatePackagePlugin: FlutterPlugin, MethodCallHandler, ActivityAware{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "updateCheck/isUpdateAvailable")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when(call.method){
      "setApplicationID" ->
        if(call.argument<Boolean>("AppId").toString() != "") {
          AppsOnAirServices.setAppId(call.argument("AppId"), call.argument<Boolean>("showNativeUI") as Boolean)
          result.success(true)
        }else{
          result.success(false)
        }
      "isUpdateAvailable" ->
        AppsOnAirServices.checkForAppUpdate(activity, object : UpdateCallBack {
          override fun onSuccess(response: String) {
            result.success(response)
          }
          override fun onFailure(message: String) {
            result.success(message)
          }
        })
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

}
