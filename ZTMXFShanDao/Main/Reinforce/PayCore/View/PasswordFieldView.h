//
//  PasswordFieldView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  密码输入框

#import <UIKit/UIKit.h>

@protocol PasswordFieldViewDelegate <NSObject>

//  密码输入完成
- (void)passwordFieldViewCompletePasswordInput:(NSString *)passwordStr;

@end

@interface PasswordFieldView : UIView

/** 密码输入UITextField */
@property (nonatomic, strong) UITextField *passwordTextField;

/** 密码个数 */
@property (nonatomic, assign) NSInteger passwordCount;
/** 密码框的宽度 */
@property (nonatomic, assign) CGFloat passwordTextFieldW;
/** 密码框的间距 */
@property (nonatomic, assign) CGFloat passwordTextFieldMargin;

/** textField 数组 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, weak) id<PasswordFieldViewDelegate> delegate;

/** 弹出键盘 */
- (void)passwordTextFeildBecomeFirstResponder;

/**
 清空密码框
 */
-(void)emptyPassword;
@end
