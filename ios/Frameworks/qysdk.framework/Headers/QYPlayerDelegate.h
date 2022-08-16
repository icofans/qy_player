//
//  QYPlayerDelegate.h
//  qysdk5
//
//  Created by 吴怡顺 on 21/3/2019.
//  Copyright © 2019 wuyishun. All rights reserved.
//


#import "QYPlayerDelegate.h"

#ifndef QYPlayerDelegate_h
#define QYPlayerDelegate_h


@protocol QYPlayerDelegate <NSObject>

@optional
/*
  player断开事件回调
 */
-(void) onDisConnect;


/*
 音频数据回调
 type:0:录制的音频数据 1:观看设备返回的音频数据
 audiotype:0=adpcm, 1=AAC, 2=PCM, 3=mp3
 smpale:采样赫兹
 chn:采样位数
 bit:通道总数
 data:音频数据
 len:音频数据长度
 */
-(void) onAudioCallBack:(int) type
              AudioType:(int) audiotype
                 Smaple:(int) smpale
                    Chn:(int) chn
                    Bit:(int) bit
                   Data:(NSData*)  data
                 Length:(int)  len;


/*
 视频数据回调
 type:视频格式，0=h264; 1=h265, 6=jpeg, 7=area
 iframe:是否为关键帧
 timestamp:视频画面时间戳（精大确到毫秒）
 data:视频数据
 len:视频数据长度
 */
-(void) onVideoCallBack:(int) type
                 Iframe:(int) iframe
              TimeStamp:(long long) timestamp
                   Data:(NSData*)  data
                 Length:(int)  len;



/*
 yuv视频数据回调
 type:视频格式，0=h264; 1=h265, 6=jpeg, 7=area
 timestamp:视频画面时间戳（精大确到毫秒）
 data:视频数据
 len:视频数据长度
 width:画面宽度
 height:视频画面长度
 */
-(void) onYUVCallBack:(int) type
              TimeStamp:(long long) timestamp
                   Data:(NSData*)  data
                 Length:(int)  len
                Width:(int) width
               Height:(int) height;

@end

#endif /* QYPlayerDelegate_h */
