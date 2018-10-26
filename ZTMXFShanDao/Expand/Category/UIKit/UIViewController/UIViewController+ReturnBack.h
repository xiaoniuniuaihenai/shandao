//
//  UIViewController+ReturnBack.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/21.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ReturnBack)

/** 返回指定控制器 */
- (void)returnBackWithControllerName:(NSString *)controllName;

@end
