import Flutter
import UIKit
import AppsOnAir

public class SwiftFlutterAppUpdatePackagePlugin: NSObject, FlutterPlugin {
    
    private var appId: String = ""
    private var window: UIWindow?
    let appsOnAirService = AppsOnAirServices()
    static var channel:FlutterMethodChannel = FlutterMethodChannel()
    
    public override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.onViewVisibilityChanged(_:)), name: .visibilityChanges, object: nil)
        
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        self.channel = FlutterMethodChannel(name: "updateCheck/isUpdateAvailable", binaryMessenger: registrar.messenger())
      
        let instance = SwiftFlutterAppUpdatePackagePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if ("setApplicationID" == call.method) {
            if let args = call.arguments as? Dictionary<String, Any>,
               let appId = args["AppId"] as? String, let showNativeUI  = args["showNativeUI"] as? Bool{
                do{
                    appsOnAirService.setAppId(appId, showNativeUI)
                }catch let error {
                    print("Failed to load: \(error.localizedDescription)")
                }
                result(true)
            } else {
                result(false)
            }
        } else if("isUpdateAvailable" == call.method){
            appsOnAirService.checkForAppUpdate { (appUpdateData) in
                result(appUpdateData)
            }
        }else{
            result({})
        }
    }
    
    @objc public func onViewVisibilityChanged(_ notification: NSNotification) {
        if let isPresented = notification.userInfo?["isPresented"] as? Bool {
            if(isPresented == true) {
                SwiftFlutterAppUpdatePackagePlugin.channel.invokeMethod("openDialog", arguments:true)
            } else {
                SwiftFlutterAppUpdatePackagePlugin.channel.invokeMethod("closeDialog", arguments:true)
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .visibilityChanges, object: nil)
    }
    
}

extension Notification.Name {
 static let visibilityChanges = NSNotification.Name("visibilityChanges")
}




