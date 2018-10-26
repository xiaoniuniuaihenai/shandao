//
//  OrderPayProcessView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderPayProcessViewDelegate <NSObject>
/** 返回首页 */
- (void)orderPayProcessViewReturnHomePage;

@end

@interface OrderPayProcessView : UIView
/** 处理中title */
@property (nonatomic, strong) UILabel *processTitleLabel;
/** 处理中描述 */
@property (nonatomic, strong) UILabel *processDescrition;

@property (nonatomic, weak) id<OrderPayProcessViewDelegate> delegate;

@end
