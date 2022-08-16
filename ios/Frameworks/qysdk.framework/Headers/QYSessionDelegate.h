//
//  QYSessionDelegate.h
//  qysdk5
//
//  Created by 吴怡顺 on 19/3/2019.
//  Copyright © 2019 wuyishun. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@protocol QYSessionDelegate <NSObject>


@optional
//  断开通知
-(void)onDisConnect;

//  报警通知
-(void)onAlarm:(NSDictionary*) data;

// 设备上下线通知
-(void)onDeviceStatus:(NSString*) did
              Statues:(int) status
                 Name:(NSString*) devname;



//通道上下线通知
-(void)onChnStatus:(NSString*) cid
            Satues:(int) status
              Name:(NSString*) chnname;



@end

NS_ASSUME_NONNULL_END
