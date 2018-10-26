//
//  LSAuthProgressView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAuthProgressView.h"

@interface LSAuthProgressView ()

/** 进度背景图片 */
@property (nonatomic, strong) UIImageView *progressImageView;
/** 实名认证 */
@property (nonatomic, strong) UILabel   *realNameLabel;
/** 信用认证 */
@property (nonatomic, strong) UILabel   *creditLabel;

@end

@implementation LSAuthProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    self.progressImageView.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    self.realNameLabel.frame = CGRectMake(0.0, 0.0, viewWidth / 2.0, viewHeight);
    self.creditLabel.frame = CGRectMake(CGRectGetMaxX(self.realNameLabel.frame), 0.0, CGRectGetWidth(self.realNameLabel.frame), CGRectGetHeight(self.realNameLabel.frame));
}

#pragma mark - setter getter
- (UIImageView *)progressImageView{
    if (_progressImageView == nil) {
        _progressImageView = [[UIImageView alloc] init];
        _progressImageView.image = [UIImage imageNamed:@"realName_auth"];
    }
    return _progressImageView;
}

- (UILabel *)realNameLabel{
    if (_realNameLabel == nil) {
        _realNameLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:16 alignment:NSTextAlignmentCenter];
        _realNameLabel.text = @"1 实名认证";
    }
    return _realNameLabel;
}

- (UILabel *)creditLabel{
    if (_creditLabel == nil) {
        _creditLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:16 alignment:NSTextAlignmentCenter];
        _creditLabel.text = @"2 信用认证";
    }
    return _creditLabel;
}



#pragma mark -
/** 实名认证 */
- (void)switchRealNameAuth{
    self.progressImageView.image = [UIImage imageNamed:@"realName_auth"];
    self.realNameLabel.textColor = [UIColor whiteColor];
    self.creditLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
}

/** 信用认证 */
- (void)switchCreditAuth{
    self.progressImageView.image = [UIImage imageNamed:@"credit_auth"];
    self.realNameLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    self.creditLabel.textColor = [UIColor whiteColor];
}

- (void)setupViews{
    [self addSubview:self.progressImageView];
    [self addSubview:self.realNameLabel];
    [self addSubview:self.creditLabel];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
