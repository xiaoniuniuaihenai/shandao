//
//  LSSliderView.h
//  ReflectionTry
//
//  Created by 朱吉达 on 2017/10/27.
//  Copyright © 2017年 try. All rights reserved.
//  滑动条

#import <UIKit/UIKit.h>
@class ZTMXFSliderView;
@protocol LSSliderViewDelegate <NSObject>
@optional
- (void)sliderValueChanging:(ZTMXFSliderView *)slider;
- (void)sliderEndValueChanged:(ZTMXFSliderView *)slider;
@end
@interface ZTMXFSliderView : UIControl
@property (nonatomic,strong) UIColor * minimumTrackTintColor;
@property (nonatomic,strong) UIColor * maxmumTrackTintColor;
@property (nonatomic,strong) UIColor * sliderBgColor;
@property (nonatomic,copy  ) NSString * thumbImageName;
@property (nonatomic,copy  ) NSString * thumbSrc;
@property (nonatomic,assign) CGFloat  thumbSize;

@property (nonatomic, assign) CGFloat value;
/*最小值*/
@property (nonatomic, assign) CGFloat minValue;
/*最大值*/
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, weak) id<LSSliderViewDelegate> delegate;
/**
 *  设置滑动条进度
 *  value取值minValue~maxValue  默认 0~1
 */
- (void)setSliderValue:(CGFloat)value;
/**
 *  动画设置滑动条进度
 */
- (void)setSliderValue:(CGFloat)value animation:(BOOL)animation completion:(void(^)(BOOL finish))completion;

@end

