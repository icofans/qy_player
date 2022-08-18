
#if TARGET_IPHONE_SIMULATOR//模拟器
#import "QYPlayerPlugin.h"
#import "QYPlatformView.h"
#elif TARGET_OS_IPHONE//真机
#import "QYPlayerPlugin.h"
#import <qysdk/qysdk.h>
#import "QYPlatformView.h"
#endif

@implementation QYPlayerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  QYPlatformViewFactory* factory = [[QYPlatformViewFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:factory withId:@"qy_player/videoView"];

  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"qy_player/plugin"
            binaryMessenger:[registrar messenger]];
    QYPlayerPlugin* instance = [[QYPlayerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init_sdk" isEqualToString:call.method]) {
//      NSDictionary *data = call.arguments;
//      bool success = [qysdk init];
    #if TARGET_IPHONE_SIMULATOR//模拟器
    result("1.0");
    #elif TARGET_OS_IPHONE//真机
    result([QYSession Version]);
    #endif
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end