//
//  UITabBar+badge.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/24.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
