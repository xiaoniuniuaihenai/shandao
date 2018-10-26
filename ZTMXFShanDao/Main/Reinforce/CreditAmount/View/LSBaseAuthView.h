//
//  LSBaseAuthView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPromoteCreditInfoModel;

@protocol BaseAuthViewDelegate <NSObject>

@optional
/** 点击芝麻信用 */
- (void)baseAuthViewClickZhiMaCredit;
/** 点击运营商 */
- (void)baseAuthViewClickPhoneOperation;

@end

@interface LSBaseAuthView : UIView

@property (nonatomic, weak) id<BaseAuthViewDelegate> delegate;

@property (nonatomic, strong) LSPromoteCreditInfoModel *consumeLoanInfoModel;

@end
