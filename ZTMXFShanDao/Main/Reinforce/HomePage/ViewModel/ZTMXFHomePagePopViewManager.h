//
//  HomePagePopViewManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFHomePagePopViewManager : NSObject

/** 处理不在首页的时候获取到推送通知,当再次进入时跳转到通知对应的页面 */
- (void)handleNotInHomePagePopupView;

@end
