//
//  LSInputTextField.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSInputTextField.h"
#import "ZTMXFCreditxTextField.h"

#define kBottomLineViewHeight 0.5

@interface LSInputTextField ()<UITextFieldDelegate>

/** bottom line */
@property (nonatomic, strong) UIView        *bottomLineView;

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIView        *titleLabelRightLine;
@end

@implementation LSInputTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

//  添加子视图
- (void)setupViews{
    
    self.inputTextField = [[ZTMXFCreditxTextField alloc] init];
    self.inputTextField.font = [UIFont systemFontOfSize:15];
    self.inputTextField.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    [self addSubview:self.inputTextField];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightButton];
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = [UIColor colorWithHexString:@"CFCFCF"];
    [self addSubview:self.bottomLineView];
    
}
-(void)setEditShowRight:(BOOL)editShowRight{
    _editShowRight = editShowRight;
    if (!editShowRight||[self.inputTextField.text length]>0) {
        self.rightButton.hidden = NO;
    }else {
        self.rightButton.hidden = YES;
        
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    self.inputTextField.frame = CGRectMake(0.0, 0.0, viewWidth - 30.0, viewHeight - kBottomLineViewHeight);
    self.rightButton.frame = CGRectMake(CGRectGetMaxX(self.inputTextField.frame), CGRectGetMinY(self.inputTextField.frame), 30.0, CGRectGetHeight(self.inputTextField.frame));
    self.bottomLineView.frame = CGRectMake(0.0, CGRectGetMaxY(self.inputTextField.frame), viewWidth, kBottomLineViewHeight);
}

- (void)setLeftImageStr:(NSString *)leftImageStr{
    if (_leftImageStr != leftImageStr) {
        _leftImageStr = leftImageStr;
        
        UIImage *leftImage = [UIImage imageNamed:_leftImageStr];
        UIImageView *leftImageView = [[UIImageView alloc] init];
        if (leftImage) {
            leftImageView.image = leftImage;
        }
        leftImageView.contentMode = UIViewContentModeLeft;
        
        leftImageView.frame = CGRectMake(0.0, 0.0, 35.0, self.bounds.size.height - kBottomLineViewHeight);
        self.inputTextField.leftView = leftImageView;
        self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    }
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
-(void)setIsLineHighlighted:(BOOL)isLineHighlighted{
    _isLineHighlighted = isLineHighlighted;
    if (_isLineHighlighted) {
        [self.inputTextField addTarget:self action:@selector(inputEditingDidBegin)
                      forControlEvents:UIControlEventEditingDidBegin];
        [self.inputTextField addTarget:self action:@selector(inputEditingDidEnd)
                      forControlEvents:UIControlEventEditingDidEnd];
        
    }
}
- (NSString *)inputText{
    NSString *inputStr = [self.inputTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return inputStr;
}

- (void)setInputKeyBoardType:(UIKeyboardType)inputKeyBoardType{
    self.inputTextField.keyboardType = inputKeyBoardType;
}

- (void)addTextFieldDelegate{
    self.inputTextField.delegate = self;
    [self.inputTextField addTarget:self action:@selector(bottomLineColorChange)
                  forControlEvents:UIControlEventEditingChanged];
    
    
}

#pragma mark - UITextField 代理方法
-(void)inputEditingDidBegin{
    if (self.inputTextField.inputActionName == CXInputLoginUserID) {
        
    }else if (self.inputTextField.inputActionName == CXInputLoginPassword){
        //后台打点-->输入验证码
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"dl" PointSubCode:@"input.dl_yzm" OtherDict:nil];
    }
    [_bottomLineView setBackgroundColor:K_MainColor];
}
-(void)inputEditingDidEnd{
    _bottomLineView.backgroundColor = [UIColor colorWithHexString:COLOR_DEEPBORDER_STR];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *strMobile = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSRange rangeStr = [@"1234567890" rangeOfString:string];
    if ([string isEqualToString:@""]) { //删除字符
        return YES;
    } else if ([strMobile length] >= 11||rangeStr.length <=0) {
        return NO;
    } else if ((range.location == 3 && [textField.text length]==3) || (range.location == 8 && [textField.text length]== 8)){
        textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *strMobile = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString * mutStr = [[NSMutableString alloc]initWithString:strMobile];
    if ([mutStr length]>3)
    {
        [mutStr insertString:@" " atIndex:3];
    }
    if ([mutStr length]>8)
    {
        [mutStr insertString:@" " atIndex:8];
    }
    textField.text = mutStr;
    [self bottomLineColorChange];
}
-(void)bottomLineColorChange{
    if (_editShowRight) {
        self.rightButton.hidden = [_inputTextField.text length]>0?NO:YES;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
