//
//  LSInputTextField.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  自定义输入框

#import <UIKit/UIKit.h>
@class ZTMXFCreditxTextField;

@interface LSInputTextField : UIView

/** input TextFeild */
@property (nonatomic, strong) ZTMXFCreditxTextField   *inputTextField;
@property (nonatomic, strong) UIButton      *rightButton;

/** 左边图片名称 */
@property (nonatomic, copy) NSString *leftImageStr;
/** 右边图片名称 */
@property (nonatomic, copy) NSString *rightImageStr;

/** place holder str */
@property (nonatomic, copy) NSString *inputPlaceHolder;
// 编辑 才会显示  右边按钮
@property (nonatomic, assign) BOOL  editShowRight;
/** 输入内容 */
@property (nonatomic, copy) NSString *inputText;
/** 弹出键盘类型 */
@property (nonatomic, assign) UIKeyboardType inputKeyBoardType;
@property (nonatomic, assign) BOOL   isLineHighlighted;

@property (nonatomic, copy) NSString  *leftTitle;

/** 设置手机号3, 4, 4 中间加空格 */
- (void)addTextFieldDelegate;
-(void)bottomLineColorChange;
@end
