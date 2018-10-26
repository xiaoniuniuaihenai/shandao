//
//  UIViewController+Nav.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "UIViewController+Nav.h"

@implementation UIViewController (Nav)
- (UINavigationController*)myNavigationController
{
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    }
    else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = ((UITabBarController*)self).selectedViewController.myNavigationController;
        }
        else {
            nav = self.navigationController;
        }
    }
    return nav;
}
@end
