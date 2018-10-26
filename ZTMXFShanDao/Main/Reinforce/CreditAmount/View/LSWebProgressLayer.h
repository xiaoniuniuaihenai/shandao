//
//  LSWebProgressLayer.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/8/16.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface LSWebProgressLayer : CAShapeLayer

+ (instancetype)layerWithFrame:(CGRect)frame;

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
