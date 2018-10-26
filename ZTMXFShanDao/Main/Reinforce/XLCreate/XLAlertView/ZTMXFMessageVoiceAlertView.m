//
//  ZTMXFMessageVoiceAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMessageVoiceAlertView.h"

@interface ZTMXFMessageVoiceAlertView()

@property (nonatomic, strong) UIButton * mainBtn;
@property (nonatomic, strong) UIView   *backgroundView;

@property (nonatomic, copy) ActionBlock cancelBlock;
@property (nonatomic, copy) ActionBlock confirmBlock;
@property (nonatomic, assign)XLMessageVoiceAlertType messageVoiceAlertType;
@property (nonatomic, strong)   UILabel * topLabel;
@property (nonatomic, strong)   UIImageView * imageView;
@property (nonatomic, strong)   UIButton * cancelButton;
@property (nonatomic, strong)   UIButton * confirmButton;
@end

@implementation ZTMXFMessageVoiceAlertView


+ (void)showVoiceWithMessageVoiceAlertType:(XLMessageVoiceAlertType)messageVoiceAlertType ConfirmBlock:(ActionBlock )confirmBlock cancelBlock:(ActionBlock )cancelBlock
{
    ZTMXFMessageVoiceAlertView *alertView = [[ZTMXFMessageVoiceAlertView alloc]init];
    alertView.confirmBlock = confirmBlock;
    alertView.cancelBlock = cancelBlock;
    alertView.messageVoiceAlertType = messageVoiceAlertType;
    [kKeyWindow addSubview:alertView];
    [alertView show];
}

- (void)setMessageVoiceAlertType:(XLMessageVoiceAlertType)messageVoiceAlertType
{
    _messageVoiceAlertType = messageVoiceAlertType;
    switch (messageVoiceAlertType) {
        case XLMessageVoiceAlertDefault:
            
            break;
        case XLMessageVoiceAlertCertification:
            [_cancelButton setTitle:@"放弃成为土豪" forState:UIControlStateNormal];
            [_cancelButton setTitle:@"放弃成为土豪" forState:UIControlStateHighlighted];
            [_confirmButton setTitle:@"继续认证" forState:UIControlStateNormal];
            [_confirmButton setTitle:@"继续认证" forState:UIControlStateHighlighted];
            _topLabel.text = @"还差一步，钱就到手啦！\n您确定放弃成为土豪的机会？";
            _imageView.image = [UIImage imageNamed:@"XL_RenZheng_JiXu"];
            break;
        case XLMessageVoiceAlertLoan:
            
            break;
            
        default:
            break;
    }
}
- (void)show
{
    self.backgroundView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        self.backgroundView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, KW, KH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mainBtn.frame = CGRectMake(0, 0, 300 * PX, 280 * PX);
        [self addSubview:_mainBtn];
        _mainBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        _mainBtn.layer.cornerRadius = 4 * PX;
        _mainBtn.clipsToBounds = YES;
        _mainBtn.center = self.center;
        
        self.backgroundView = [[UIView alloc]init];
        self.backgroundView.backgroundColor = UIColor.whiteColor;
        self.backgroundView.layer.cornerRadius = 10.f;
        self.backgroundView.layer.masksToBounds = YES;
        [_mainBtn addSubview:self.backgroundView];
        
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"video_icon"];
        _imageView.contentMode = UIViewContentModeCenter;
        [self.backgroundView addSubview:_imageView];
        
        _topLabel = [[UILabel alloc]init];
        _topLabel.text = @"关闭消息声音后，您可能再也听\n不到小美的声音咯，确定关闭吗？";
        _topLabel.font = FONT_Regular(X(16));
        _topLabel.numberOfLines = 0;
        _topLabel.textColor = COLOR_SRT(@"3E3E3E");
        _topLabel.textAlignment = NSTextAlignmentCenter;
        [self.backgroundView addSubview:_topLabel];
        
//        UILabel *bottomLabel = [[UILabel alloc]init];
//        bottomLabel.text = @"不到小美的声音咯，确定关闭吗？";
//        bottomLabel.font = FONT_Regular(X(16));
//        bottomLabel.textColor = COLOR_SRT(@"3E3E3E");
//        bottomLabel.textAlignment = NSTextAlignmentCenter;
//        [self.backgroundView addSubview:bottomLabel];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = COLOR_SRT(@"DDDDDD");
        [self.backgroundView addSubview:line];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateHighlighted];
        [_cancelButton setTitle:@"忍痛抛弃她" forState:UIControlStateNormal];
        [_cancelButton setTitle:@"忍痛抛弃她" forState:UIControlStateHighlighted];
        [_cancelButton setTitleColor:COLOR_SRT(@"939393") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:COLOR_SRT(@"939393") forState:UIControlStateHighlighted];
        [_cancelButton.titleLabel setFont:FONT_Regular(X(14))];
        [_cancelButton addTarget:self action:@selector(cancelButtonClock) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:_cancelButton];
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        [_confirmButton setTitleColor:K_BtnTitleColor forState:UIControlStateHighlighted];
        [_confirmButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateHighlighted];
        [_confirmButton setTitle:@"声音很好听" forState:UIControlStateNormal];
        [_confirmButton setTitle:@"声音很好听" forState:UIControlStateHighlighted];
        [_confirmButton.titleLabel setFont:FONT_Regular(X(14))];
        [_confirmButton addTarget:self action:@selector(confirmButtonClock) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:_confirmButton];
        
        _mainBtn.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .bottomEqualToView(self)
        .topEqualToView(self);
        
        self.backgroundView.sd_layout
        .leftSpaceToView(_mainBtn, X(38))
        .topSpaceToView(_mainBtn, X(169))
        .rightSpaceToView(_mainBtn, X(37))
        .heightIs(X(260));
        
        _imageView.sd_layout
        .leftSpaceToView(self.backgroundView, X(12))
        .rightSpaceToView(self.backgroundView, X(13))
        .topSpaceToView(self.backgroundView, X(11))
        .heightIs(X(133));
        
        _topLabel.sd_layout
        .centerXEqualToView(self.backgroundView)
        .topSpaceToView(_imageView, X(5))
        .widthRatioToView(self.backgroundView, 1)
        .heightIs(X(50));
        
//        bottomLabel.sd_layout
//        .centerXEqualToView(self.backgroundView)
//        .topSpaceToView(_topLabel, X(5))
//        .widthRatioToView(self.backgroundView, 1)
//        .heightIs(X(22));
        
        _cancelButton.sd_layout
        .leftEqualToView(self.backgroundView)
        .widthRatioToView(self.backgroundView, .5)
        .heightIs(X(45))
        .bottomEqualToView(self.backgroundView);
        
        _confirmButton.sd_layout
        .rightEqualToView(self.backgroundView)
        .widthRatioToView(self.backgroundView, .5)
        .heightIs(X(45))
        .bottomEqualToView(self.backgroundView);
        
        line.sd_layout
        .leftEqualToView(self.backgroundView)
        .rightEqualToView(self.backgroundView)
        .bottomSpaceToView(self.backgroundView, X(45))
        .heightIs(1);
    }
    return self;
}
+ (void)showVoiceWithConfirmBlock:(ActionBlock )confirmBlock cancelBlock:(ActionBlock )cancelBlock{
    ZTMXFMessageVoiceAlertView *alertView = [[ZTMXFMessageVoiceAlertView alloc]init];
    alertView.confirmBlock = confirmBlock;
    alertView.cancelBlock = cancelBlock;
    [kKeyWindow addSubview:alertView];
    [alertView show];
}
- (void)dismiss{
//    [UIView animateWithDuration:.3 animations:^{
//        self.backgroundView.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//    }];
}

- (void)cancelButtonClock{
    if (self.cancelBlock) {
        self.cancelBlock();
        [self dismiss];
    }
}

- (void)confirmButtonClock{
    if (self.confirmBlock) {
        self.confirmBlock();
        [self dismiss];
    }
}

@end
