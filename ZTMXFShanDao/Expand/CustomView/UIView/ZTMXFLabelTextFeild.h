//
//  LabelTextFeild.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTMXFCreditxTextField;

@interface ZTMXFLabelTextFeild : UIView

/** input TextFeild */
@property (nonatomic, strong) UILabel       *leftLabel;
@property (nonatomic, strong) ZTMXFCreditxTextField   *inputTextField;
@property (nonatomic, strong) UIButton      *rightButton;
/** bottom line */
@property (nonatomic, strong) UIView        *bottomLineView;

/** 左边title */
@property (nonatomic, copy) NSString *leftTitle;
/** 右边图片名称 */
@property (nonatomic, copy) NSString *rightImageStr;
/** title margin */
@property (nonatomic, assign) CGFloat titleMargin;

/** place holder str */
@property (nonatomic, copy) NSString *inputPlaceHolder;

/** 输入内容 */
@property (nonatomic, copy) NSString *inputText;
/** 弹出键盘类型 */
@property (nonatomic, assign) UIKeyboardType inputKeyBoardType;

@end
