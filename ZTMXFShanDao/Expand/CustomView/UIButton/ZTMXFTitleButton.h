//
//  TitleButton.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/25.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TitleCenterType,
    TitleLeftType,
} TitleButtonType;

@interface ZTMXFTitleButton : UIButton
/** title 显示位置 */
@property (nonatomic, assign) TitleButtonType titleType;
@end
