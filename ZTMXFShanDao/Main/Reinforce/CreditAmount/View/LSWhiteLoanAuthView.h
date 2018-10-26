//
//  LSWhiteLoanAuthView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAuthSupplyCertifyModel;

@protocol WhiteLoanAuthViewDelegate <NSObject>

@optional
/** 点击社保 */
- (void)whiteLoanAuthViewClickSocialSecurity;
/** 点击公积金 */
- (void)whiteLoanAuthViewClickProvidentFund;
/** 公司电话 */
- (void)whiteLoanAuthViewClickCompanyPhone;

@end

@interface LSWhiteLoanAuthView : UIView

@property (nonatomic, weak) id<WhiteLoanAuthViewDelegate> delegate;

@property (nonatomic, strong) LSAuthSupplyCertifyModel *whiteLoanInfoModel;

@end
