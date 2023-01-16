#import "FlutterAppUpdatePackagePlugin.h"
#if __has_include(<appsonair_flutter_sdk/appsonair_flutter_sdk-Swift.h>)
#import <appsonair_flutter_sdk/appsonair_flutter_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "appsonair_flutter_sdk-Swift.h"
#endif

@implementation FlutterAppUpdatePackagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAppUpdatePackagePlugin registerWithRegistrar:registrar];
}
@end
