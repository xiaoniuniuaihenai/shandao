//
//  CancelOrderAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CancelOrderAlertView.h"
#import "OrderGoodsInfoModel.h"

@interface CancelOrderAlertView ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descriptLabel;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) NSArray *clicks;

@end

@implementation CancelOrderAlertView

+ (void)showAlertViewWithTitle:(NSString *)title GoodsInfo:(OrderGoodsInfoModel *)goodsInfo Cancel:(NSString *)cancelButton Click:(clickHandle)cancelClick  OtherButton:(NSString *)buttonTitle Click:(clickHandle)sureClick{
    
    id newClick = cancelClick;
    if (!newClick) {
        newClick = [NSNull null];
    }
    id newClick1 = sureClick;
    if (!newClick1) {
        newClick1 = [NSNull null];
    }
    CancelOrderAlertView *alertView = [[CancelOrderAlertView alloc] initWithTitle:title GoodsInfo:goodsInfo Cancel:cancelButton OtherButton:buttonTitle];
    alertView.clicks = @[newClick,newClick1];
    
    [alertView show];
}

- (instancetype)initWithTitle:(NSString *)title GoodsInfo:(OrderGoodsInfoModel *)goodsInfo Cancel:(NSString *)cancelTitle OtherButton:(NSString *)otherTitle
{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height)];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self configueSubViews];
        
        self.titleLabel.text = title;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:goodsInfo.goodsIcon] placeholderImage:[UIImage imageNamed:@""]];
        
//        CGFloat width = _alertView.width-_iconView.right-AdaptedWidth(40);
//        CGSize size = [goodsInfo.title sizeWithFont:[UIFont boldSystemFontOfSize:16] maxW:width];
//        self.nameLabel.frame = CGRectMake(self.iconView.right+AdaptedWidth(14.0), self.iconView.top, size.width, size.height);
//        self.descriptLabel.frame = CGRectMake(self.nameLabel.left, CGRectGetMaxY(self.nameLabel.frame)+8.0, self.nameLabel.width, 20.0);
        
        self.nameLabel.text = goodsInfo.title;
        self.descriptLabel.text = goodsInfo.propertyValueNames;
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        [self.sureButton setTitle:otherTitle forState:UIControlStateNormal];
    }
    return self;
}



-(void)show{

    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];

    CGFloat duration = 0.3;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.alpha = 1.0;
    } completion:^(BOOL finished) {
        for (UIButton *btn in self.alertView.subviews) {
            btn.userInteractionEnabled = YES;
        }
    }];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = duration;
    [self.alertView.layer addAnimation:animation forKey:@"bouce"];
}
- (void)clickButton:(UIButton *)sender{
    
    if (self.clicks.count > 0) {
        clickHandle handle = self.clicks[sender.tag];
        if (![handle isEqual:[NSNull null]]) {
            [self hidden];
            handle();
        }
    }
}


-(void)hidden{
    
    CGFloat duration = 0.2;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.4, 0.4);
    } completion:^(BOOL finished) {
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

#pragma mark - setter
- (NSArray *)clicks{
    if (!_clicks) {
        _clicks = [NSArray array];
    }
    return _clicks;
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-AdaptedWidth(56), 220)];
    [self.alertView setBackgroundColor:[UIColor whiteColor]];
    self.alertView.center = self.center;
    self.alertView.layer.cornerRadius = 4.0;
    self.alertView.layer.masksToBounds = YES;
    [self addSubview:_alertView];
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:18 alignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.titleLabel setFrame:CGRectMake(0.0, 19.0, _alertView.width, 25.0)];
    [_alertView addSubview:self.titleLabel];
    
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(AdaptedWidth(27.0), 73.0, 70.0, 70.0)];
    self.iconView.backgroundColor = [UIColor colorWithHexString:@"FAFAFA"];
    self.iconView.layer.borderWidth = 1.0;
    self.iconView.layer.borderColor = [UIColor colorWithHexString:COLOR_BORDER_STR].CGColor;
    self.iconView.layer.masksToBounds = YES;
    [_alertView addSubview:self.iconView];
    
    self.nameLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentLeft];
    [self.nameLabel setFrame:CGRectMake(self.iconView.right+AdaptedWidth(14.0), self.iconView.top, _alertView.width-_iconView.right-AdaptedWidth(26), 44.0)];
    self.nameLabel.numberOfLines = 2;
    [_alertView addSubview:self.nameLabel];
    
    self.descriptLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.descriptLabel setFrame:CGRectMake(self.nameLabel.left, CGRectGetMaxY(self.nameLabel.frame), self.nameLabel.width, 20.0)];
    self.descriptLabel.numberOfLines = 0;
    [_alertView addSubview:self.descriptLabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 174, _alertView.width, 1.0)];
    line.backgroundColor = [UIColor colorWithHexString:@"EDEFF0"];
    [_alertView addSubview:line];
    
    CGFloat width = self.alertView.width/2.;
    
    UILabel *lineTwo = [[UILabel alloc] initWithFrame:CGRectMake(width, 175, 1.0, 44.0)];
    lineTwo.backgroundColor = [UIColor colorWithHexString:@"EDEFF0"];
    [_alertView addSubview:lineTwo];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setFrame:CGRectMake(0, 175, width-1, 44.0)];
    [self.cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.cancelButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] forState:UIControlStateNormal];
    self.cancelButton.tag = 0;
    [self.cancelButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:self.cancelButton];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setFrame:CGRectMake(width, 175, width-1, 44.0)];
    [self.sureButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.sureButton setTitleColor:[UIColor colorWithHexString:@"2DABF0"] forState:UIControlStateNormal];
    self.sureButton.tag = 1;
    [self.sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:self.sureButton];
}

@end
