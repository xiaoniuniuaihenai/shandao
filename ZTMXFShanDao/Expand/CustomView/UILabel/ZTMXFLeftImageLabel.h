//
//  LeftImageLabel.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/7.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ContentTextAlignmentLeft,
    ContentTextAlignmentCenter,
    ContentTextAlignmentRight,
} ContentTextAlignment;

@interface ZTMXFLeftImageLabel : UIView

/** 左边按钮图片 */
@property (nonatomic, copy) NSString *leftImageStr;
/** title font */
@property (nonatomic, assign) UIFont* titleFont;
/** titleColor */
@property (nonatomic, strong) UIColor *titleColor;
/** title */
@property (nonatomic, copy) NSString *title;

/** 图片和文字间距 */
@property (nonatomic, assign) CGFloat imageTitleMargin;

/** 设置对齐 */
@property (nonatomic, assign) ContentTextAlignment contentTextAlignment;

+ (instancetype)leftImageLabelWithImageStr:(NSString *)imageStr title:(NSString *)title origin:(CGPoint)origin;

@end
