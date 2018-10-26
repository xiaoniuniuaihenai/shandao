//
//  LSSlider.h
//  ReflectionTry
//
//  Created by 朱吉达 on 2017/10/27.
//  Copyright © 2017年 try. All rights reserved.
//  滑动条

#import <UIKit/UIKit.h>
@class LSSlider;
@protocol LSSliderDelegate <NSObject>
@optional
- (void)sliderValueChanging:(LSSlider *)slider;
- (void)sliderEndValueChanged:(LSSlider *)slider;
@end
@interface LSSlider : UIControl
@property (nonatomic,strong) UIColor * minimumTrackTintColor;
@property (nonatomic,strong) UIColor * maxmumTrackTintColor;
@property (nonatomic,copy  ) NSString * thumbImageName;
@property (nonatomic, assign) CGFloat value;
/*最小值*/
@property (nonatomic, assign) CGFloat minValue;
/*最大值*/
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, weak) id<LSSliderDelegate> delegate;
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

