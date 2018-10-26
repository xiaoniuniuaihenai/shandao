//
//  SetupPayPasswordPopupView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/14.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SetupPayPasswordPopupView;
@protocol SetupPayPasswordPopupViewDelegate <NSObject>

/** 点击跳过 */
- (void)setupPayPasswordClickSkip:(SetupPayPasswordPopupView *)setupPayPasswordPopupView;
/** 密码输入完成 */
- (void)setupPayPasswordCompleteInputPassword:(NSString *)password;

@end

@interface SetupPayPasswordPopupView : UIView

@property (nonatomic, weak) id<SetupPayPasswordPopupViewDelegate> delegate;

//  弹出选择分期方式view
+ (instancetype)popupView;
//  弹框取消
- (void)dismiss;

@end
