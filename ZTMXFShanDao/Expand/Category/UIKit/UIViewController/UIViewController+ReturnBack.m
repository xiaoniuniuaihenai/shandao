//
//  UIViewController+ReturnBack.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/21.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "UIViewController+ReturnBack.h"

@implementation UIViewController (ReturnBack)

- (void)returnBackWithControllerName:(NSString *)controllName{
    if (!kStringIsEmpty(controllName)) {
        //  修改支付密码成功返回设置
        NSArray * viewControllers = self.navigationController.viewControllers;
        UIViewController * backController = nil;
        for (UIViewController * controller in viewControllers) {
            if ([controller isKindOfClass:NSClassFromString(controllName)]) {
                backController = controller;
                break;
            }
        }
        if (backController) {
            [self.navigationController popToViewController:backController animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
