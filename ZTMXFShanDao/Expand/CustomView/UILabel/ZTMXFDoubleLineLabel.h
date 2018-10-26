//
//  DoubleLineLabel.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/4.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTMXFDoubleLineLabel : UILabel

/** 左侧细线 */
@property (nonatomic, strong) UIView *leftLine;
/** 右侧细线 */
@property (nonatomic, strong) UIView *rightLine;

/** 线的颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 线的高度 */
@property (nonatomic, assign) CGFloat lineHeight;
/** 线的宽度 */
@property (nonatomic, assign) CGFloat lineWidth;

/** 线和文字的间距 */
@property (nonatomic, assign) CGFloat lineMarging;

@end
