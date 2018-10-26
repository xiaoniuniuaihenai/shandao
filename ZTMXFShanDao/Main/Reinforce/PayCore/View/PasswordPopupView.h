//
//  PasswordPopupView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  密码弹窗

#import <UIKit/UIKit.h>
@class PasswordFieldView;

@protocol PasswordPopupViewDelegate <NSObject>
/** 输入密码完成 */
- (void)passwordPopupViewEnterPassword:(NSString *)password;
/** 忘记密码 */
- (void)passwordPopupViewForgetPassword;

@end

@interface PasswordPopupView : UIView

/** 密码输入框 */
@property (nonatomic, strong) PasswordFieldView             *passwordInputView;
@property (nonatomic, weak) id<PasswordPopupViewDelegate>   delegate;

//  弹出支付类型view
+ (instancetype)popupPasswordBoxView;
//  弹框取消
- (void)dismiss;

@end
