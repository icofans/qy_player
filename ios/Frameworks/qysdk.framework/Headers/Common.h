//
//  Common.h
//  qysdk
//
//  Created by 吴怡顺 on 31/10/17.
//  Copyright © 2017年 wuyishun. All rights reserved.
//

#import <Foundation/Foundation.h>




@protocol  CommonDelegate <NSObject>
@optional


//  报警通知
-(void)onCommonAlarm:(NSDictionary*) data;

//  设备上下线通知
-(void)onCommonDeviceStatus:(NSString*) did
              Statues:(int) status
                 Name:(NSString*) devname;



//通道上下线通知
-(void)onCommonChnStatus:(NSString*) cid
            Satues:(int) status
              Name:(NSString*) chnname;


//断开通知
-(void)onViewDisConnectCallBack;




-(void) onVideoCallBack:(int) type
                 Iframe:(int) iframe
              TimeStamp:(long long) timestamp
                   Data:(NSData*)  data
                 Length:(int)  len;



-(void) onAudioCallBack:(int) type
              AudioType:(int) audiotype
                 Smaple:(int) smpale
                    Chn:(int) chn
                    Bit:(int) bit
                   Data:(NSData*)  data
                 Length:(int)  len;



@end







@interface Common : NSObject



//初始化
-(id) init;





-(void)Config:(NSString*) cip
         Port:(int) cport;


-(void) setEventDelegate:(id<CommonDelegate>) delgate;


/*===============session相关方法======================*/
-(void) LoginServerCallBack:(NSDictionary*) Info
                   CallBack:(void (^)(int32_t ret)) callback;

-(void)Call:(NSString*) key
   SendData:(NSDictionary*) dic
   CallBack:(void (^)(int32_t ret,NSDictionary* resData)) callback;






/*===============登陆转发相关方法======================*/

-(void) LoginRelayCallBack:(void (^)(int32_t ret)) callback;

-(void) LoignRePlay:(NSString*) roomId
                Key:(NSString*) viewKey
            TimeOut:(long) timeout
               Sign:(NSString*) sign
           CallBack:(void (^)(int32_t ret)) callback;

-(void) SendAudio:(NSData*) audio;



-(void) Release;



@end
