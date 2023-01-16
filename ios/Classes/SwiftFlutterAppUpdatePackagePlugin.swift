import Flutter
import UIKit
import AppsOnAir

public class SwiftFlutterAppUpdatePackagePlugin: NSObject, FlutterPlugin {
  
  private var appId: String = ""
  private var window: UIWindow?
  let appUpdateManager = UpdateManager()
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "updateCheck/isUpdateAvailable", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppUpdatePackagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

 if ("setApplicationID" == call.method) {
          if let args = call.arguments as? Dictionary<String, Any>,
    let appId = args["AppId"] as? String, let isShowNativeUI  = args["isShowNative"] as? Bool{
    do{  
    appUpdateManager.setAppId(appId, isShowNativeUI: isShowNativeUI)
    }catch let error {
    print("Failed to load: \(error.localizedDescription)")
}    
    result(true)
  } else {
    result(false)
  }
  } else if("isUpdateAvailable" == call.method){
       appUpdateManager.checkForAppUpdate { (appUpdateData) in
          result(appUpdateData)
      }
    }else{
      result({})
    }
  }
}


