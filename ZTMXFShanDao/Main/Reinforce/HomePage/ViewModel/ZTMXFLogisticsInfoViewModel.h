//
//  LogisticsInfoViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LogistcsInfoModel;
@protocol LogistcsInfoViewModelDelegate <NSObject>

/** 获取物流信息成功 */
- (void)requestLogistcsInfoSuccess:(LogistcsInfoModel *)logistcsModel;

@end

@interface ZTMXFLogisticsInfoViewModel : NSObject
@property (nonatomic, weak) id<LogistcsInfoViewModelDelegate> delegate;
-(void)requestLogistcsInfoDataWithOrderId:(NSString*)orderId type:(NSString *)type;
@end
