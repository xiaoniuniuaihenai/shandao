//
//  LSScaleChiSliderView.h
//
//  Created by 朱吉达 on 17/9/27.
//  Copyright © 2017年 try. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSScaleChiSliderView;
@protocol LSScaleChiSliderViewDelegate <NSObject>
@optional
- (void)sliderValueChanging:(LSScaleChiSliderView *)slider;
- (void)sliderEndValueChanged:(LSScaleChiSliderView *)slider;
@end

@interface LSScaleChiSliderView : UIView
@property (nonatomic, assign) CGFloat value;
/*最小值*/
@property (nonatomic, assign) CGFloat minValue;
/*最大值*/
@property (nonatomic, assign) CGFloat maxValue;

/**
 *  拖动后是否返回
 */
@property (nonatomic,assign) BOOL thumbBack;
@property (nonatomic, weak) id<LSScaleChiSliderViewDelegate> delegate;
/**
 *  设置滑动条进度
 *  value取值minValue~maxValue  默认 0~1
 */
- (void)setSliderValue:(CGFloat)value;
/**
 *  动画设置滑动条进度
 */
- (void)setSliderValue:(CGFloat)value animation:(BOOL)animation completion:(void(^)(BOOL finish))completion;

/**
 *  移除圆角和边框
 */
- (void)removeRoundCorners:(BOOL)corners border:(BOOL)border;

@end
