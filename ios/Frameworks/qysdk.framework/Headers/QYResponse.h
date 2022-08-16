//
//  QYResponse.h
//  qysdk5
//
//  Created by 吴怡顺 on 21/3/2019.
//  Copyright © 2019 wuyishun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYResponse : NSObject


@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, assign) int ret;
@end

NS_ASSUME_NONNULL_END
