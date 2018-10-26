//
//  LSPeriodNoDataView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LSPeriodNoDataType){
    LSPeriodNoMonthDataType,      // 本月应还类型
    LSPeriodNoResidueDataType,    // 剩余应还类型
};

@interface LSPeriodNoDataView : UIView

@property (nonatomic, assign) LSPeriodNoDataType periodType;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end
