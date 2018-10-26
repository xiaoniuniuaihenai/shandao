//
//  LSRefundProgress.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSRefundProgress : UIView

@property (nonatomic,strong) UIColor * minimumTrackTintColor;
@property (nonatomic,strong) UIColor * maxmumTrackTintColor;

/**
 @param progress 进度 [0,1],默认开启
 */
- (void)setProgress:(CGFloat)progress;

@end
