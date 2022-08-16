//
//  QYPlatformView.m
//  qy_player
//
//  Created by 捡来的💻 on 2022/6/27.
//

#import "QYPlatformView.h"
#import <qysdk/qysdk.h>


@implementation QYPlatformViewFactory{
    NSObject<FlutterBinaryMessenger>* _messenger;
  }

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  return [[QYPlatformView alloc] initWithFrame:frame
                              viewIdentifier:viewId
                                   arguments:args
                             binaryMessenger:_messenger];
}

@end

@interface QYPlatformView ()<QYPlayerDelegate>

@end

@implementation QYPlatformView {
    UIView *view;
    NSObject<FlutterBinaryMessenger>* _messenger;
    QYSession *session;
    QYPlayer *player;
    QYPlayer *talkPlayer;
}


- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
      view = [[UIView alloc] init];
      session = [[QYSession alloc] init];
      _messenger = messenger;
      [self initMethodChannel];
  }
  return self;
}


- (void)initMethodChannel {
    NSLog(@"初始化消息通道");
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"qy_player" binaryMessenger:_messenger];
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        NSLog(@"接收到消息 --- [%@]",call.method);
        if ([@"preview" isEqualToString:call.method]) {
            NSDictionary *data = call.arguments;
            NSString *viewUrl = data[@"viewUrl"];
            NSLog(@"preview --- [%@]",viewUrl);
            if (self->player != nil) {
                [self->player Release];
                self->player = nil;
            }
            self->player = [[QYPlayer alloc] init];
            [self->player SetEventDelegate:self];
            [self->player SetCanvas: self->view];
            [self->player CtrlAudio:YES];
            NSLog(@"player = %@",self->player);
//            [self->player SyncConnect:viewUrl];
            [self->player Connect:viewUrl CallBack:^(int32_t ret) {
                if(ret==0){;
                    NSLog(@"预览成功");
                }else{
                    NSLog(@"预览失败");
                }
            }];
            result(@"开始播放");
        } else  if ([@"stop_preview" isEqualToString:call.method]) {
            [self->player Release];
            self->player = nil;
            result(@"开始播放");
        }   else  if ([@"ctrolSound" isEqualToString:call.method]) {
            NSDictionary *data = call.arguments;
            bool soud = [data[@"isOpen"] boolValue];
            [self->player CtrlAudio:soud];
            result(@"开始播放");
        } else if ([@"talk" isEqualToString:call.method]) {
            NSDictionary *data = call.arguments;
            NSString *viewUrl = data[@"viewUrl"];
            NSLog(@"Talk --- [%@]",viewUrl);
            if (self->talkPlayer != nil) {
                [self->talkPlayer Release];
                self->talkPlayer = nil;
            }
            self->talkPlayer = [[QYPlayer alloc] init];
            [self->talkPlayer SetEventDelegate:self];
            [self->talkPlayer SetCanvas: self->view];
            [self->talkPlayer CtrlAudio:YES];
            NSLog(@"player = %@",self->talkPlayer);
//            [self->player SyncConnect:viewUrl];
            [self->talkPlayer Connect:viewUrl CallBack:^(int32_t ret) {
                if(ret==0){;
                    NSLog(@"开启对讲成功");
                    [self->talkPlayer CtrlTalk:true];
                }else{
                    NSLog(@"预览失败");
                }
            }];
            result(@"开始播放");
        } else  if ([@"stop_talk" isEqualToString:call.method]) {
            [self->talkPlayer CtrlTalk:NO];
            [self->talkPlayer Release];
            self->talkPlayer = nil;
            result(@"开始播放");
        }
        else {
            result(FlutterMethodNotImplemented);
        }
    }];
}




#pragma mark - PlayerDelegate Methods 播放器回调
-(void)onAudioCallBack:(int) type
              AudioType:(int) audiotype
                 Smaple:(int) smpale
                    Chn:(int) chn
                    Bit:(int) bit
                   Data:(NSData*)  data
                 Length:(int)  len
{
    
    NSLog(@"-------");
    
}



-(void)onVideoCallBack:(int) type
                 Iframe:(int) iframe
              TimeStamp:(long long) timestamp
                   Data:(NSData*)  data
                 Length:(int)  len
{
    
    NSLog(@"-------");
}

-(void)onDisConnect
{
    
    NSLog(@"-------");
}

- (UIView*)view {
  return view;
}

@end
