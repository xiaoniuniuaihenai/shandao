//
//  ZTMXFPayPWDViewController.h
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@protocol ZTMXFPayPWDViewControllerDelegate <NSObject>

@optional

/** 跳过按钮点击 */
- (void)passwordInputViewClickskipButton;
/** 点击忘记密码 */
- (void)clickForgetButton;
/** 密码输入完成 */
- (void)passwordPopupViewEnterPassword:(NSString *)password;


@end

@interface ZTMXFPayPWDViewController : BaseViewController


@property (nonatomic, weak) id<ZTMXFPayPWDViewControllerDelegate> delegate;


@end
