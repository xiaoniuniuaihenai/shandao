//
//  UIViewController+Visible.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Visible)
- (BOOL)isVisible;

/** 获取当前控制器 */
+ (UIViewController *)currentViewController;

/** 获取当前根控制器 */
+ (UIViewController *)currentRootViewController;

@end
