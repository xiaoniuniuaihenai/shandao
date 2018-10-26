//
//  LoginoutView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/30.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineLoginOutViewDelegete <NSObject>

/** 点击登录 */
- (void)mineLoginOutViewClickLogin;

@end

@interface LoginoutView : UIView

@property (nonatomic, strong) UIButton *loginoutBtn;

@property (nonatomic, weak) id <MineLoginOutViewDelegete>delegete;

@end
