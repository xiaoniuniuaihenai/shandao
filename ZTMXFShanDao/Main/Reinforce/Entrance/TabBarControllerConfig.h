//
//  TabBarControllerConfig.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/29.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

@interface CYLBaseNavigationController : UINavigationController

@end

@interface TabBarControllerConfig : NSObject

@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;

+(void)changeTabBar;

@end
