//
//  LSCreditAmountHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditAmountHeaderView.h"
#import "UICountingLabel.h"
#import "LSAmountPageModel.h"
#import "LSCreditAuthModel.h"

@interface LSCreditAmountHeaderView ()

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *headDescribeLabel;
@property (nonatomic, strong) UICountingLabel *headAmountLabel;
@property (nonatomic, strong) UIImageView   *creditArrowView;
@property (nonatomic, strong) UILabel       *headerBottomLabel;

/** 刻度视图 */
@property (nonatomic, strong) CAShapeLayer *progressShaper;
@property (nonatomic, strong) UIImageView  *scaleImageView;
@property (nonatomic, strong) UIImageView  *progressImageView;
@property (nonatomic, strong) CALayer      *progressMask;

@end

@implementation LSCreditAmountHeaderView



- (void)setupViews{
    [self addSubview:self.headImageView];
    
    [self.headImageView addSubview:self.scaleImageView];
    [self.headImageView addSubview:self.progressImageView];
    [self.progressMask addSublayer:self.progressShaper];
    self.progressImageView.layer.mask = self.progressMask;

    
    [self addSubview:self.headDescribeLabel];
    [self addSubview:self.headAmountLabel];
    [self addSubview:self.creditArrowView];
    [self addSubview:self.headerBottomLabel];
    
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, (213 - 77) * PY, KW, 71 * PY)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIImage *scaleImage = [UIImage imageNamed:@"creditAuth_scale"];
    CGFloat scaleImageW = scaleImage.size.width;
    CGFloat scaleImageH = scaleImage.size.height;
    CGFloat scaleImageX = (Main_Screen_Width - scaleImageW) / 2.0;
    CGFloat scaleImageY = AdaptedHeight(40.0);

    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.headImageView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    
    self.scaleImageView.frame = CGRectMake(scaleImageX, scaleImageY, scaleImageW, scaleImageH);
    self.progressImageView.frame = self.scaleImageView.frame;
    self.progressShaper.bounds = self.scaleImageView.bounds;
    self.progressShaper.path = [UIBezierPath bezierPathWithRect:self.scaleImageView.bounds].CGPath;
    self.progressShaper.position = CGPointMake(-CGRectGetWidth(self.scaleImageView.frame) / 2.0, CGRectGetHeight(self.scaleImageView.frame) / 2.0);

    
    self.headDescribeLabel.frame = CGRectMake(0.0, AdaptedHeight(77.0), Main_Screen_Width, 20.0);
    self.headAmountLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.headDescribeLabel.frame), Main_Screen_Width, 56.0);
    self.creditArrowView.frame = CGRectMake(0.0, CGRectGetMaxY(self.headAmountLabel.frame), 150.0, 12.0);
    self.creditArrowView.centerX = Main_Screen_Width/2.;
    self.headerBottomLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.headAmountLabel.frame)+14.0, Main_Screen_Width, 20.0);
}


- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"amount_background"];
    }
    return _headImageView;
}

#pragma mark -- 头部Title
- (UILabel *)headDescribeLabel{
    if (_headDescribeLabel == nil) {
        _headDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:AdaptedWidth(16) alignment:NSTextAlignmentCenter];
        _headDescribeLabel.text = @"";
    }
    return _headDescribeLabel;
}

- (UILabel *)headAmountLabel{
    if (_headAmountLabel == nil) {
        _headAmountLabel = [[UICountingLabel alloc] init];
        _headAmountLabel.textAlignment = NSTextAlignmentCenter;
        _headAmountLabel.textColor = [UIColor whiteColor];
        _headAmountLabel.font = [UIFont boldSystemFontOfSize:AdaptedWidth(40)];
        _headAmountLabel.text = @"";
        _headAmountLabel.method = UILabelCountingMethodLinear;
        _headAmountLabel.format = @"%d";
    }
    return _headAmountLabel;
}



- (UIImageView *)creditArrowView{
    if (_creditArrowView == nil) {
        _creditArrowView = [[UIImageView alloc] init];
        _creditArrowView.image = [UIImage imageNamed:@"credit_arrow"];
    }
    return _creditArrowView;
}

- (UILabel *)headerBottomLabel{
    if (_headerBottomLabel == nil) {
        _headerBottomLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:AdaptedWidth(12) alignment:NSTextAlignmentCenter];
        _headerBottomLabel.text = @"";
    }
    return _headerBottomLabel;
}

//   添加刻度视图
- (UIImageView *)scaleImageView{
    if (_scaleImageView == nil) {
        UIImage *scaleImage = [UIImage imageNamed:@"creditAuth_scale"];
        _scaleImageView = [[UIImageView alloc] init];
        _scaleImageView.image = scaleImage;
    }
    return _scaleImageView;
}

- (UIImageView *)progressImageView{
    if (_progressImageView == nil) {
        UIImage *progressImage = [UIImage imageNamed:@"creditAuth_progress"];
        _progressImageView = [[UIImageView alloc] init];
        _progressImageView.image = progressImage;
    }
    return _progressImageView;
}

- (CALayer *)progressMask{
    if (_progressMask == nil) {
        _progressMask = [CALayer layer];
    }
    return _progressMask;
}

- (CAShapeLayer *)progressShaper{
    if (_progressShaper == nil) {
        _progressShaper = [CAShapeLayer layer];
        _progressShaper.fillColor = [UIColor whiteColor].CGColor;
    }
    return _progressShaper;
}

//  开始刻度动画
- (void)startCreditProgressAnimation
{
    NSInteger creditAmount = [self.creditAuthModel.ballNum integerValue];
    NSInteger allAmount = [self.creditAuthModel.ballAllNum integerValue];
    CGFloat percent = creditAmount*2.0/allAmount - 1.0;
    
    CABasicAnimation *progressAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    progressAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-CGRectGetWidth(self.progressImageView.frame) / 2.0, CGRectGetHeight(self.progressImageView.frame) / 2.0)];
    progressAnimation.byValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.progressImageView.frame) / 2.0, -20.0)];
    progressAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.progressImageView.frame) / 2.0 * percent, CGRectGetHeight(self.progressImageView.frame) / 2.0)];
    progressAnimation.duration = 1.5;
    progressAnimation.fillMode=kCAFillModeForwards;
    progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    progressAnimation.removedOnCompletion = NO;
    
    [self.progressShaper addAnimation:progressAnimation forKey:@"progressAnimation"];
    
    //  额度增加动画
    if (creditAmount > 0) {
        [self.headAmountLabel countFrom:1 to:creditAmount withDuration:1.5];
    }
}

- (void)setCreditAuthModel:(LSCreditAuthModel *)creditAuthModel{
    if (_creditAuthModel != creditAuthModel) {
        _creditAuthModel = creditAuthModel;
    }
    //  非审核中
    self.headDescribeLabel.text = self.creditAuthModel.ballDesc;
    self.headAmountLabel.text = self.creditAuthModel.ballNum;
    NSString * titlePrompt = [_creditAuthModel.reminder length] > 0?_creditAuthModel.reminder:@"";
    self.headerBottomLabel.text = titlePrompt;
}

- (void)setAmountPageModel:(LSAmountPageModel *)amountPageModel{
    if (_amountPageModel != amountPageModel) {
        _amountPageModel = amountPageModel;
    }
    //  非审核中
    self.headDescribeLabel.text = self.amountPageModel.ballDesc;
    
    NSString * titlePrompt = [_amountPageModel.reminder length] > 0?_amountPageModel.reminder:@"";
    self.headerBottomLabel.text = titlePrompt;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
