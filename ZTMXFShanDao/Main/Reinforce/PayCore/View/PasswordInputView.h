//
//  PasswordInputView.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/23.
//  Copyright © 2017年 讯秒. All rights reserved.
//  输入密码框view

#import <UIKit/UIKit.h>
@class PasswordFieldView;
@class PasswordInputView;
@protocol PasswordInputViewDelegate <NSObject>

@optional
/** 点击返回按钮 */
- (void)passwordInputViewClickBackButton:(PasswordInputView *)passwordInputView;
/** 跳过按钮点击 */
- (void)passwordInputViewClickskipButton;
/** 点击忘记密码 */
- (void)passwordInputViewClickForgetButton;

/** 密码输入完成 */
- (void)passwordInputViewCompleteInputPassword:(PasswordInputView *)passwordInputView password:(NSString *)password;

@end

@interface PasswordInputView : UIView
/** 密码输入 */
@property (nonatomic, strong) PasswordFieldView *passwordFieldView;
/** 输入完成的支付密码 */
@property (nonatomic, copy) NSString *password;
@property (nonatomic, weak) id<PasswordInputViewDelegate> delegate;

/** 设置title */
- (void)configHeaderTitle:(NSString *)title;
/** 隐藏密码按钮 */
- (void)hiddenForgetPassword:(BOOL)hidden;

/** 隐藏跳过按钮 */
- (void)hiddenSkipButton:(BOOL)hidden;
/**
 清空密码框
 */
-(void)emptyPassword;
@end
