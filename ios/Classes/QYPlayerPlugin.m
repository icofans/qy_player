#import "QYPlayerPlugin.h"
#import <qysdk/qysdk.h>
#import "QYPlatformView.h"

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
      result([QYSession Version]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
