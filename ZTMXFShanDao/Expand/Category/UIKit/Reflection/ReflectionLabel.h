//
//  ReflectionLabel.h
//  ReflectionTry
//
//  Created by 朱吉达 on 2017/10/16.
//  Copyright © 2017年 try. All rights reserved.
//
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wobjc-missing-property-synthesis"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ReflectionLabel : UILabel
@property (nonatomic, assign) CGFloat reflectionGap;
@property (nonatomic, assign) CGFloat reflectionScale;
@property (nonatomic, assign) CGFloat reflectionAlpha;
@property (nonatomic, assign) BOOL dynamic;

- (void)update;

@end
#pragma GCC diagnostic pop
