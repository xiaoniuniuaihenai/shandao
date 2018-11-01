//
//  AddNumberView.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/6.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "AddNumberView.h"
@interface AddNumberView ()<UITextFieldDelegate>

@end

@implementation AddNumberView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        [self setupViews];
    }
    return self;
}




-(void)setupViews{
    
    
    UILabel *purchaseLabel = [[UILabel alloc] init];
    purchaseLabel.backgroundColor = [UIColor whiteColor];
    purchaseLabel.text = @"购买数量";
    purchaseLabel.font = [UIFont systemFontOfSize:14];
    purchaseLabel.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    [self addSubview:purchaseLabel];
    self.purchaseLabel = purchaseLabel;
    
    self.goodsCountLabel = [[UILabel alloc] init];
    self.goodsCountLabel.font = [UIFont systemFontOfSize:14];
    self.goodsCountLabel.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
//    self.goodsCountLabel.text = @"x4";
    self.goodsCountLabel.hidden = YES;
    [self addSubview:self.goodsCountLabel];
    
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.minusBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.minusBtn setImage:[UIImage imageNamed:@"goods_minus"] forState:UIControlStateNormal];
    [self addSubview:self.minusBtn];
    

    self.numberTextField = [[UITextField alloc] init];
    self.numberTextField.text = @"1";
    self.numberTextField.textAlignment = NSTextAlignmentCenter;
    self.numberTextField.font = [UIFont boldSystemFontOfSize:14];
    self.numberTextField.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    self.numberTextField.layer.cornerRadius = 4.0;
    self.numberTextField.layer.borderWidth = 0.5;
    self.numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numberTextField.layer.borderColor = [UIColor colorWithHexString:COLOR_BORDER_STR].CGColor;
    self.numberTextField.delegate = self;
    [self.numberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.numberTextField];
    

    self.numberTextField.inputAccessoryView = self.inputAccessoryView;
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setImage:[UIImage imageNamed:@"goods_add"] forState:UIControlStateNormal];
    [self addSubview:self.addBtn];
    
    
    //    lineView1
    self.line1View = [[UIView alloc] init];
    self.line1View.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    [self addSubview:self.line1View];

    //    lineView1
    self.line2View = [[UIView alloc] init];
    self.line2View.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    [self addSubview:self.line2View];
}
- (void)setGoodsCount:(NSInteger)goodsCount
{
    _goodsCount = goodsCount;
    self.addBtn.hidden = YES;
    self.minusBtn.hidden = YES;
    self.numberTextField.hidden = YES;
    self.goodsCountLabel.hidden = NO;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld",_goodsCount];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewHeight = self.bounds.size.height;
    
    CGFloat purchaseLabelX = 10.0;
    CGFloat purchaseLabelY = 0.0;
    CGFloat purchaseLabelW = 80.0;
    CGFloat purchaseLabelH = viewHeight;
    self.purchaseLabel.frame = CGRectMake(purchaseLabelX, purchaseLabelY, purchaseLabelW, purchaseLabelH);
    
    self.goodsCountLabel.frame = CGRectMake(CGRectGetMaxX(self.purchaseLabel.frame), CGRectGetMinY(self.purchaseLabel.frame), 160.0, CGRectGetHeight(self.purchaseLabel.frame));
    
    CGFloat buttonH = 24.0;
    CGFloat addButtonW = 30.0;
    CGFloat numberTextFeildW = 50.0;
    CGFloat buttonY = (viewHeight - buttonH)/2.0;
    
    CGFloat minusBtnX = SCREEN_WIDTH - 10.0 - 5.0 - addButtonW*2 - numberTextFeildW;
    CGFloat minusBtnY = buttonY;
    CGFloat minusBtnW = addButtonW;
    CGFloat minusBtnH = buttonH;
    self.minusBtn.frame = CGRectMake(minusBtnX, minusBtnY, minusBtnW, minusBtnH);
    
    CGFloat numberTextFieldX = CGRectGetMaxX(self.minusBtn.frame) + 2.5;
    CGFloat numberTextFieldY = buttonY;
    CGFloat numberTextFieldW = numberTextFeildW;
    CGFloat numberTextFieldH = buttonH;
    self.numberTextField.frame = CGRectMake(numberTextFieldX, numberTextFieldY, numberTextFieldW, numberTextFieldH);
    
    CGFloat addBtnX = CGRectGetMaxX(self.numberTextField.frame) + 2.5;
    CGFloat addBtnY = buttonY;
    CGFloat addBtnW = addButtonW;
    CGFloat addBtnH = buttonH;
    self.addBtn.frame = CGRectMake(addBtnX, addBtnY, addBtnW, addBtnH);

    //    *line1View;
    CGFloat line1ViewX = 10.0;
    CGFloat line1ViewY = self.bounds.size.height - 0.5;
    CGFloat line1ViewW = SCREEN_WIDTH -20.0;
    CGFloat line1ViewH = 0.5;
    self.line1View.frame = CGRectMake(line1ViewX, line1ViewY, line1ViewW, line1ViewH);

    
    //    *line1View;
    CGFloat line2ViewX = 10.0;
    CGFloat line2ViewY = 0.0;
    CGFloat line2ViewW = SCREEN_WIDTH -20.0;
    CGFloat line2ViewH = 0.5;
    self.line2View.frame = CGRectMake(line2ViewX, line2ViewY, line2ViewW, line2ViewH);

}
- (UIView *)inputAccessoryView{
    if (!_inputAccessoryView) {
        _inputAccessoryView = [[UIView alloc]initWithFrame:(CGRect){0.0,0.0,SCREEN_WIDTH,40}];
        _inputAccessoryView.backgroundColor = [UIColor colorWithHexString:@"dedede"];
        
        UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [finishButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [finishButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        finishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        finishButton.frame = CGRectMake(SCREEN_WIDTH - 60.0, 0.0, 60.0, 40.0);
        [_inputAccessoryView addSubview:finishButton];
    }
    return _inputAccessoryView;
}



//  点击加号添加数量
- (void)addBtnAction:(UIButton *)sender {
     NSLog(@"加方法");
    if(self.delegate && [self.delegate respondsToSelector:@selector(addNumberViewDelegateAddGoodsCount:)]){
        [self.delegate addNumberViewDelegateAddGoodsCount:self];
    }
}
//  点击减号减少数量
- (void)deleteBtnAction:(UIButton *)sender {
    NSLog(@"减方法");
    if(self.delegate && [self.delegate respondsToSelector:@selector(addNumberViewDelegateMinusGoodsCount:)]){
        [self.delegate addNumberViewDelegateMinusGoodsCount:self];
    }
}
//  点击完成, 失去第一响应
- (void)done{
    NSLog(@"点击完成");
    [self.numberTextField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addNumberViewDelegateResignFirstResponder:)]) {
        [self.delegate addNumberViewDelegateResignFirstResponder:self];
    }
}

#pragma mark -UITextField 代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addNumberViewDelegateBecomeFirstResponder:)]) {
        [self.delegate addNumberViewDelegateBecomeFirstResponder:self];
    }
    return YES;
}


//  购买的数量改变
- (void)textFieldDidChange:(UITextField *)sender
{
    NSLog(@"改变成了当前的值： %@", sender.text);
    if (self.delegate && [self.delegate respondsToSelector:@selector(addNumberViewDelegateNumberCountDidChange:)]) {
        [self.delegate addNumberViewDelegateNumberCountDidChange:self];
    }
}

@end
