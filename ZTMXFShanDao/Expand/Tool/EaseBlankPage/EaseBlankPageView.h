//
//  EaseBlankPageView.h
//  Blossom
//
//  Created by wujunyang on 15/9/21.
//  Copyright © 2015年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EaseBlankPageType)
{
    EaseBlankPageTypeView = 0,
    EaseBlankPageTypeProject,
    EaseBlankPageTypeNoButton,
    EaseBlankPageTypeMaterialScheduling,
    EaseBlankPageTypeNoLoanList,         //  借钱记录数据没有
    EaseBlankPageTypeNoCouponList,       //  优惠券记录没有
    EaseBlankPageTypeNoPromoteAmountList,//  提额足迹记录没有
    EaseBlankPageTypeNoRepaymentList,    //  还款记录数据没有
    EaseBlankPageTypeNoMsgList,          //  暂无消息
    EaseBlankPageTypeNoAddressList,      //  暂无地址
    EaseBlankPageTypeNoOrderList,        //  暂无订单
    EaseBlankPageTypeNoBillHistoryList,  //  暂无历史账单
    EaseBlankPageTypeNoBankList,         //  没有添加银行卡

};

@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *monkeyView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
