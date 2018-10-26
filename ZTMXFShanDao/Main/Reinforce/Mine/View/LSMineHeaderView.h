//
//  LSMineHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSMineModel;
@class LSReminderButton;

@protocol MineHeaderViewDelegate <NSObject>

/** 点击登录 */
- (void)mineTableHeaderViewClickLogin;
/** 点击邀请有礼 */
- (void)mineTableHeaderViewClickInvite;
/** 点击借钱记录 */
- (void)mineTableHeaderViewClickLoanList;
/** 点击优惠券 */
- (void)mineTableHeaderViewClickCoupon;
/** 点击设置按钮 */
- (void)mineTableHeaderViewClickSetup;
/** 点击消息中心 */
- (void)mineTableHeaderViewClickMessageCenter;
/** 点击余额 */
- (void)mineTableHeaderViewClickBalance;
/** 签到 */
-(void)mineTableHeaderViewClickSigna;
/** 点击订单 */
- (void)mineTableHeaderViewClickOrder;
/** 点击分期账单 */
- (void)mineTableHeaderViewClickPreiodList;
@end

@interface LSMineHeaderView : UIView

@property (nonatomic, strong) UIImageView *topBgView;
/** message center button */
@property (nonatomic, strong) LSReminderButton *messageCenterButton;


@property (nonatomic,strong) LSMineModel * mineModel;

@property (nonatomic, weak) id<MineHeaderViewDelegate> delegate;

- (void)hiddenLoginButton:(BOOL)state;

- (void)showInviteButton:(BOOL)show;

@end

