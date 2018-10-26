//
//  XLServerStatisticalApi.h
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/7/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ZTMXFServerStatisticalApi : BaseRequestSerivce

- (instancetype)initWithClassName:(NSString *)className PointSubCode:(NSString *)pointSubCode Time:(NSDate *)date lastPageCode:(NSString *)lastPageCode type:(BOOL)type;
@end
