//
//  LabelTextFeild.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ZTMXFLabelTextFeild.h"
#import "ZTMXFCreditxTextField.h"

#define kBottomLineViewHeight 0.5

@interface ZTMXFLabelTextFeild ()

@end

@implementation ZTMXFLabelTextFeild



//  添加子视图
- (void)setupViews{
    
    self.leftLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self addSubview:self.leftLabel];
    
    self.inputTextField = [[ZTMXFCreditxTextField alloc] init];
    self.inputTextField.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    self.inputTextField.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    [self addSubview:self.inputTextField];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightButton];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = [UIColor colorWithHexString:COLOR_DEEPBORDER_STR];
    [self addSubview:self.bottomLineView];
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    CGFloat leftLabelWidth = [self.leftTitle sizeWithFont:self.leftLabel.font maxW:MAXFLOAT].width;
    self.leftLabel.frame = CGRectMake(0.0, 0.0, leftLabelWidth, viewHeight);
    self.inputTextField.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame) + self.titleMargin, 0.0, viewWidth - 30.0 - CGRectGetMaxX(self.leftLabel.frame) - self.titleMargin, viewHeight - kBottomLineViewHeight);
    self.rightButton.frame = CGRectMake(CGRectGetMaxX(self.inputTextField.frame), CGRectGetMinY(self.inputTextField.frame), 30.0, CGRectGetHeight(self.inputTextField.frame));
    self.bottomLineView.frame = CGRectMake(0.0, CGRectGetMaxY(self.inputTextField.frame), viewWidth, kBottomLineViewHeight);
}

- (void)setLeftTitle:(NSString *)leftTitle{
    if (_leftTitle != leftTitle) {
        _leftTitle = leftTitle;
    }
    
    self.leftLabel.text = _leftTitle;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitleMargin:(CGFloat)titleMargin{
    if (_titleMargin != titleMargin) {
        _titleMargin = titleMargin;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setRightImageStr:(NSString *)rightImageStr{
    if (_rightImageStr != rightImageStr) {
        _rightImageStr = rightImageStr;
        
        UIImage *rightImage = [UIImage imageNamed:_rightImageStr];
        [self.rightButton setImage:rightImage forState:UIControlStateNormal];
    }
}

- (void)setInputPlaceHolder:(NSString *)inputPlaceHolder{
    if (_inputPlaceHolder != inputPlaceHolder) {
        _inputPlaceHolder = inputPlaceHolder;
        
        self.inputTextField.placeholder = _inputPlaceHolder;
    }
}

- (NSString *)inputText{
    NSString *inputStr = [self.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return inputStr;
}

- (void)setInputKeyBoardType:(UIKeyboardType)inputKeyBoardType{
    self.inputTextField.keyboardType = inputKeyBoardType;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
