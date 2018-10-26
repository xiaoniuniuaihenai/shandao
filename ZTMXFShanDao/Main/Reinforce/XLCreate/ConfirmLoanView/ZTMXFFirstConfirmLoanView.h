//
//  ZTMXFFirstConfirmLoanView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickCouponButtonBlock)(void);

@interface ZTMXFFirstConfirmLoanView : UIView

@property (nonatomic, copy)NSString * amountStr;
@property (nonatomic, copy)NSString * arrivalAmount;

///优惠券Label
@property (nonatomic, strong)UILabel * couponLabel;
///优惠券金额
@property (nonatomic, assign)CGFloat   couponFloat;

@property (nonatomic, copy)clickCouponButtonBlock   clickCouponBlock;
@end
