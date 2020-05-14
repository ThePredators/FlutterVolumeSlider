#import "FlutterVolumePlugin.h"
#if __has_include(<FlutterVolume/FlutterVolume-Swift.h>)
#import <FlutterVolume/FlutterVolume-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "FlutterVolume-Swift.h"
#endif

@implementation FlutterVolumePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterVolumePlugin registerWithRegistrar:registrar];
}
@end
