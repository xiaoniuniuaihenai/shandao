//
//  LSWaveView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WaveBlock)(CGFloat currentY);

@interface LSWaveView : UIView

/** 浪弯曲度 */
@property (nonatomic, assign) CGFloat waveCurvature;
/** 浪速 */
@property (nonatomic, assign) CGFloat waveSpeed;
/** 浪高 */
@property (nonatomic, assign) CGFloat waveHeight;
/** 浪色 */
@property (nonatomic, strong) UIColor *wavecolor;

@property (nonatomic, copy) WaveBlock waveBlock;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
