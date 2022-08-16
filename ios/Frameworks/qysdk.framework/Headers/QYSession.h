//
//  QYSession.h
//  qysdk5
//
//  Created by 吴怡顺 on 19/3/2019.
//  Copyright © 2019 wuyishun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYSessionDelegate.h"
#import "QYResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYSession : NSObject

/*
 获取SDK当前版本号
 */
+ (NSString*) Version;

-(void) SetEventDelegate:(id<QYSessionDelegate>) del;


/*
 登录接口
 ip:登录地址
 port:登陆端口
 name:账号
 pwd:密码
 mode:是否强制登录
 loginmode:是否支持多点登陆 0不支持，1支持
 */
-(void) Login:(NSString*)  ip
         Port:(int) port
     UserName:(NSString*) name
     Password:(NSString*) pwd
         Mode:(int)  mode
    LoginMode:(int) loginmode
     CallBack:(void (^)(int32_t ret)) callback;


/*
 登录接口
 ip:登录地址
 port:登陆端口
 name:账号
 pwd:密码
 mode:是否强制登录
 loginmode:是否支持多点登陆 0不支持，1支持
 */
-(int) SyncLogin:(NSString*)  ip
            Port:(int) port
        UserName:(NSString*) name
        Password:(NSString*) pwd
            Mode:(int)  mode
       LoginMode:(int) loginmode;




/*
 session登陆成功后获取数据言接口已（异步接口）
 key:请求接口的uri
 data:根据协议来传（json）
 */
-(void) Call:(NSString*)  key
    SendData:(NSDictionary*)    data
    CallBack:(void (^)(int32_t ret,NSDictionary* resData)) callback;

/*
 session登陆成功后获取数据言接口（同步接口）
 key:请求接口的uri
 data:根据协议来传（json）
 */
-(QYResponse*) SyncCall:(NSString*)  key
           SendData:(NSDictionary*) data;




-(void) Release;

@end

NS_ASSUME_NONNULL_END
