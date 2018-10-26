//
//  ZTMXFLoanSecondCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//
typedef void(^OtherLoanShopClick)(void);

#import <UIKit/UIKit.h>
@class StatusInfo;
@class BannerList;

@interface ZTMXFLoanSecondCell : UITableViewCell
@property (nonatomic, strong)StatusInfo * statusInfo;
@property (nonatomic, strong)NSArray<BannerList *> *botBannerList;
@property (nonatomic, strong)OtherLoanShopClick otherLoanShopClick;

@end
