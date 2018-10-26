//
//  ZTMXFAdvertisingApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ZTMXFAdvertisingApi : BaseRequestSerivce

/**
 type ==
 注册页：REGISTER_BOTTOM_ADSENSE 借贷超市：BORROW_SHOP_ADSENSE
 */
- (instancetype)initWithAdsenseType:(NSString *)adsenseType;
@end
