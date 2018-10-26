//
//  LSReceivingView.m
//  YWLTMeiQiiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSReceivingView.h"
#import "AddressPickerView.h"
#import "LSAddressModel.h"

@interface LSReceivingView () <UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation LSReceivingView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self configueSubViews:0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self configueSubViews:type];
    }
    return self;
}

#pragma mark - setter
- (void)setAddressModel:(LSAddressModel *)addressModel{
    _addressModel = addressModel;
    if (_addressModel) {
        _defaultAddressSwitch.on = _addressModel.isDefault;
        self.textName.text = _addressModel.consignee;
        self.phoneNum.text = _addressModel.consigneeMobile;
        self.choosedAreaLabel.text = [NSString stringWithFormat:@"%@%@%@",_addressModel.province,_addressModel.city,_addressModel.region];
        self.detailArea.text = self.addressModel.detailAddress;
        if (_addressModel.detailAddress.length > 0) {
            self.placeholderLabel.text = @"";
        }
    }
}

#pragma mark - 点击选择区域按钮
- (void)clickChooseArea:(UIButton *)sender{
    // 隐藏键盘
    [self.textName resignFirstResponder];
    [self.phoneNum resignFirstResponder];
    [self.detailArea resignFirstResponder];
    
    AddressPickerView *pickerView = [AddressPickerView shareInstance];
    if (_addressModel) {
        [pickerView configDataProvince:_addressModel.province City:_addressModel.city Town:_addressModel.region];
    }
    [pickerView showAddressPickView];
    
    pickerView.block = ^(NSString *province, NSString *city, NSString *district) {
        
        self.choosedAreaLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,district];
        self.choosedAreaLabel.textColor = UIColor.blackColor;
        if (self.delegete && [self.delegete respondsToSelector:@selector(updateAddressWithProvice:city:region:)]) {
            [self.delegete updateAddressWithProvice:province city:city region:district];
        }
    };
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        _placeholderLabel.text = @"";
    }else{
        _placeholderLabel.text = @"请填写详细地址";
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews:(NSInteger)type{
    
    CGFloat labelLeftSpace = type == 1 ? X(18) : X(12);
    CGFloat lineLeftSpace = type == 1 ? X(19) : 0;
    CGFloat labelHeight = type == 1 ? X(46) : X(48);
    
    //    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineLeftSpace, 0, SCREEN_WIDTH - lineLeftSpace, 1)];
    //    lineLabel.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    //    type != 1 ? [self addSubview:lineLabel] : nil;
    
    UILabel *takeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [takeLabel setFrame:CGRectMake(labelLeftSpace, 0, X(78), labelHeight)];
    takeLabel.text = @"收件人";
    [self addSubview:takeLabel];
    
    _textName = [[UITextField alloc] initWithFrame:CGRectMake(takeLabel.right + X(10), takeLabel.top, SCREEN_WIDTH - X(90), takeLabel.height)];
    [_textName setFont:[UIFont systemFontOfSize:AdaptedWidth(14)]];
    _textName.centerY = takeLabel.centerY;
    _textName.placeholder = @"请填写收件人姓名";
    [self addSubview:_textName];
    
    UILabel *lineLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(lineLeftSpace, takeLabel.bottom - 1, SCREEN_WIDTH - lineLeftSpace, 1)];
    lineLabelOne.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    [self addSubview:lineLabelOne];
    
    UILabel *contactPeople = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [contactPeople setFrame:CGRectMake(takeLabel.left, takeLabel.bottom, takeLabel.width, takeLabel.height)];
    contactPeople.text = @"联系电话";
    [self addSubview:contactPeople];
    
    _phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(_textName.left, contactPeople.top, SCREEN_WIDTH - X(90), takeLabel.height)];
    [_phoneNum setFont:[UIFont systemFontOfSize:AdaptedWidth(14)]];
    _phoneNum.centerY = contactPeople.centerY;
    _phoneNum.placeholder = @"请填写联系电话";
    [self addSubview:_phoneNum];
    
    UILabel *lineLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(lineLeftSpace, contactPeople.bottom - 1, SCREEN_WIDTH - lineLeftSpace, 1)];
    lineLabelTwo.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    [self addSubview:lineLabelTwo];
    
    UILabel *areaLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [areaLabel setFrame:CGRectMake(takeLabel.left, contactPeople.bottom, contactPeople.width, contactPeople.height)];
    areaLabel.text = @"所在地区";
    [self addSubview:areaLabel];
    
    _choosedAreaLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    _choosedAreaLabel.textColor = COLOR_SRT(@"C1C1C1");
    _choosedAreaLabel.text = @"请选择所属地区";
    [_choosedAreaLabel setFrame:CGRectMake(_phoneNum.left, _phoneNum.bottom, SCREEN_WIDTH - 90 - 20, _phoneNum.height)];
    _choosedAreaLabel.centerY = areaLabel.centerY;
    [self addSubview:_choosedAreaLabel];
    
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, X(8),X(14))];
    arrowImage.image = [UIImage imageNamed:@"mine_right_arrow"];
    arrowImage.right = SCREEN_WIDTH - X(12);
    arrowImage.centerY = _choosedAreaLabel.centerY;
    [self addSubview:arrowImage];
    
    UIButton *chooseAreaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseAreaButton setFrame:CGRectMake(0, lineLabelTwo.bottom, SCREEN_WIDTH, takeLabel.height)];
    [chooseAreaButton addTarget:self action:@selector(clickChooseArea:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chooseAreaButton];
    
    UILabel *lineLabelThree = [[UILabel alloc] initWithFrame:CGRectMake(lineLeftSpace, areaLabel.bottom - 1, SCREEN_WIDTH - lineLeftSpace, 1)];
    lineLabelThree.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    [self addSubview:lineLabelThree];
    
    UILabel * addressLabelText = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [addressLabelText setFrame:CGRectMake(takeLabel.left, lineLabelThree.bottom, takeLabel.width, takeLabel.height)];
    addressLabelText.text = @"详细地址";
    [self addSubview:addressLabelText];
    
    _detailArea = [[UITextView alloc] initWithFrame:CGRectMake(_textName.left - X(3), lineLabelThree.bottom + X(10), SCREEN_WIDTH -_textName.left - X(12), (type == 1 ? X(71) : X(152)) - X(10))];
    [_detailArea setFont:[UIFont systemFontOfSize:AdaptedWidth(14)]];
    _detailArea.delegate = self;
    [self addSubview:_detailArea];
    
    _placeholderLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [_placeholderLabel setFrame:CGRectMake(_textName.left, lineLabelThree.bottom, _detailArea.width, takeLabel.height)];
    _placeholderLabel.text = @"请填写详细地址";
    _phoneNum.delegate = self;
    [self addSubview:_placeholderLabel];
    
    [_phoneNum addTarget:self action:@selector(editingAction:) forControlEvents:UIControlEventEditingChanged];
    _textName.returnKeyType = UIReturnKeyDone;
    _phoneNum.returnKeyType = UIReturnKeyDone;
    _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    
    type == 1 ? ({
       
        UILabel *lineLabelFour = [[UILabel alloc] initWithFrame:CGRectMake(0, lineLabelThree.bottom + 71 * PX, SCREEN_WIDTH, 6 * PX)];
        lineLabelFour.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
        [self addSubview:lineLabelFour];
        
        UILabel * defaultAddressLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
        [defaultAddressLabel setFrame:CGRectMake(takeLabel.left, lineLabelFour.bottom - 1, takeLabel.width + X(30), takeLabel.height)];
        defaultAddressLabel.text = @"设置默认地址";
        [self addSubview:defaultAddressLabel];
        
        
        self.defaultAddressSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KW - X(60), X(6), X(100), X(40))];
        _defaultAddressSwitch.onTintColor = K_MainColor;
        _defaultAddressSwitch.centerY = defaultAddressLabel.centerY;
        _defaultAddressSwitch.transform = CGAffineTransformMakeScale(0.9, 0.9);//缩放
        [self addSubview:_defaultAddressSwitch];
    }):({
        UILabel *lineLabelFour = [[UILabel alloc] initWithFrame:CGRectMake(lineLeftSpace, lineLabelThree.bottom + 152 * PX - 1, SCREEN_WIDTH - lineLeftSpace, 1)];
        lineLabelFour.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
        [self addSubview:lineLabelFour];
        
        UILabel * defaultAddressLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
        [defaultAddressLabel setFrame:CGRectMake(takeLabel.left, lineLabelFour.bottom - 1, takeLabel.width + X(30), takeLabel.height)];
        defaultAddressLabel.text = @"设置默认地址";
        [self addSubview:defaultAddressLabel];
        
        
        self.defaultAddressSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KW - X(60), X(6), X(100), X(40))];
        _defaultAddressSwitch.onTintColor = K_MainColor;
        _defaultAddressSwitch.centerY = defaultAddressLabel.centerY;
        _defaultAddressSwitch.transform = CGAffineTransformMakeScale(0.9, 0.9);//缩放
        [self addSubview:_defaultAddressSwitch];
    });
}

- (void)chooseDefaultArea:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}


-(void)editingAction:(UITextField *)tf
{
    tf.text = [[tf.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (tf == _phoneNum) {
        if (_phoneNum.text.length >= 11) {
            _phoneNum.text = [_phoneNum.text substringToIndex:11];
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_phoneNum == textField) {
        NSString *text = [textField text];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" "withString:@""];
        if ([text length] > 11) {
            return NO;
        }
        return YES;
        
    }
    return YES;
}

@end

