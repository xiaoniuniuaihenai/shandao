//
//  PFProgressView.h
//  ZBProgressView
//
//  Created by panfei mao on 2017/11/14.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LSProgressType) {
    LSRefundType = 0,//还款
    LSOverdueType//逾期
};

@class LSBrwSatusInfoModel;

@interface PFProgressView : UIView

@property (nonatomic,strong) UIColor * minimumTrackTintColor;
@property (nonatomic,strong) UIColor * maxmumTrackTintColor;

@property (nonatomic,strong) LSBrwSatusInfoModel * brwStatusInfo;

@property (nonatomic,assign) LSProgressType progressType;

- (instancetype)initWithFrame:(CGRect)frame ProgressType:(LSProgressType)style;

/**
 @param progress 进度 [0,1],默认开启
 */
- (void)setProgress:(CGFloat)progress;

-(void)stop;

@end
