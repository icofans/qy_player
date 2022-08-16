//
//  QYPlayer.h
//  qysdk5
//
//  Created by 吴怡顺 on 21/3/2019.
//  Copyright © 2019 wuyishun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QYPlayerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYPlayer : NSObject

-(id)init;


/*
 设置事件回调
 */
- (void) SetEventDelegate:(id<QYPlayerDelegate>) delegate;


/*
 设置画面
 canvas:画布(uiview对像)
 */
-(void)SetCanvas:(UIView*) canvas;


/*
 请求播放
 uri:通过qysession获取的播放地址
 callback:返回值回调，0为成功，其它值为失败
 */
-(void) Connect:(NSString*)  uri
       CallBack:(void (^)(int32_t ret)) callback;


/*
 请求播放
 uri:通过qysession获取的播放地址
 返回值：0为成功，其它值为失败
 */
-(int) SyncConnect:(NSString*)  uri;



/*
 截图（当播放成功有数据回调后才能生效）
 uri:通过qysession获取的播放地址
 返回值：0为成功，其它值为失败
 */
-(int)Capture:(NSString*) savePath;


/*
 是否播放声音（默认静音）
 open:YES 打开 NO 关立闭
 */
- (void) CtrlAudio:(BOOL) open;


/*
 对讲（创建对讲房间才有效）
 open:YES 打开 NO 关立闭
 */
-(void) CtrlTalk:(BOOL) open;



/*
 开始录像
 savePath：录像文件保存完整路径
 */
-(void) StartRecord:(NSString*) savePath;

/*
 结束录像 返回值 文件大小
 */
-(unsigned long long) EndRecord;

/*
 释放QYPlayer
 当不使用时必须释放
 */
-(void)Release;

@end

NS_ASSUME_NONNULL_END
