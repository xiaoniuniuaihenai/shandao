//
//  LSPeriodAuthCellView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPeriodAuthCellView : UIView

@property (nonatomic, strong) UILabel *lineLabel;

/** 认证状态 0:未认证 1已认证 2认证中 -1认证失败】*/
@property (nonatomic, assign) NSInteger authStatus;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title icon:(NSString *)icon;

@end
