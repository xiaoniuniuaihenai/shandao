//
//  AuthenProgressView.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "AuthenProgressView.h"



@interface AuthenProgressView ()

/** 进度条 */
@property (nonatomic, strong) UIView *progressLineView;
/** 进度button */
@property (nonatomic, strong) UIImageView *progressRowImageView;
/** 进度label */
@property (nonatomic, strong) UILabel *progressLabel;
/** 进度title */
@property (nonatomic, strong) UILabel *progressTitleLabel;
/** 进度描述 */
@property (nonatomic, strong) UILabel *progressDescribeLabel;

@end

@implementation AuthenProgressView



- (void)setupViews{
    /** 细线 */
    self.progressLineView = [UIView setupViewWithSuperView:self withBGColor:COLOR_RED_STR];
    
    /** 箭头图片 */
    self.progressRowImageView = [UIImageView setupImageViewWithImageName:@"authen_row_line" withSuperView:self];
    self.progressRowImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    /** 进度 */
    self.progressLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:10 alignment:NSTextAlignmentCenter];
    [self.progressRowImageView addSubview:self.progressLabel];
    
//    /** 进度title */
//    self.progressTitleLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:20 alignment:NSTextAlignmentLeft];
//    [self addSubview:self.progressTitleLabel];
//
//    /** 进度描述 */
//    self.progressDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:14 alignment:NSTextAlignmentLeft];
//    [self addSubview:self.progressDescribeLabel];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.progressLabel.frame = CGRectMake(0.0, 3.0, CGRectGetWidth(self.progressRowImageView.frame), CGRectGetHeight(self.progressRowImageView.frame));
    
//    self.progressTitleLabel.frame = CGRectMake(18.0, 42.0, Main_Screen_Width, 28.0);
//    self.progressDescribeLabel.frame = CGRectMake(18.0, CGRectGetMaxY(self.progressTitleLabel.frame) + 2.0, Main_Screen_Width, 20.0);
    
}

//  设置进度类型
- (void)setProgressType:(AuthenProgressType)progressType{
    if (_progressType != progressType) {
        _progressType = progressType;
    }
    
    CGFloat lineViewWidth = Main_Screen_Width / 5.0;
    
    
    if (_progressType == AuthenProgressScanIdentifyId) {
        //  扫描身份证
        self.progressLabel.text = @"Ready go!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        self.progressRowImageView.image = [UIImage imageNamed:@"authen_row_line"];
        self.progressLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];

        self.progressLineView.frame = CGRectMake(0.0, 0.0, 1.0, 2.0);
        self.progressRowImageView.frame = CGRectMake(-30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);

    } else if (_progressType == AuthenProgressFaceRecognition) {
        //  人脸识别
        self.progressLabel.text = @"太棒了!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        self.progressRowImageView.image = [UIImage imageNamed:@"authen_row_line"];
        self.progressLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];

        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);

    } else if (_progressType == AuthenProgressBindingBankCard) {
        //  绑定银行卡
        self.progressLabel.text = @"加油哦!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        self.progressRowImageView.image = [UIImage imageNamed:@"authen_row_line"];
        self.progressLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];

        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 2, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 2 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);

    } else if (_progressType == AuthenProgressSesameCredit) {
        //  芝麻信用
        self.progressLabel.text = @"继续加油!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        self.progressRowImageView.image = [UIImage imageNamed:@"authen_row_line"];
        self.progressLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];

        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 3, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 3 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);

    } else if (_progressType == AuthenProgressOperators) {
        //  运营商
        self.progressLabel.text = @"太厉害了!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        self.progressRowImageView.image = [UIImage imageNamed:@"authen_row_line"];
        self.progressLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];

        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 3.5, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 3.5 - 60.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 120.0, 23.0);

    } else if (_progressType == AuthenProgressConsumeLoan) {
        //  提交消费贷认证
        self.progressLabel.text = @"消费贷认证已完成!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        UIImage *progressRowImage = [UIImage imageNamed:@"authen_row_redleft"];
        self.progressRowImageView.image = progressRowImage;
        self.progressLabel.textColor = [UIColor whiteColor];
        
        CGSize progressRowImageViewSize = progressRowImage.size;
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 5, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 5 - progressRowImageViewSize.width, CGRectGetMaxY(self.progressLineView.frame) + 1.0, progressRowImageViewSize.width, 23.0);
        
    } else if (_progressType == AuthenProgressCompany) {
        //  公司认证
        self.progressLabel.text = @"太棒了!快完成了";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        UIImage *progressRowImage = [UIImage imageNamed:@"authen_row_redCenter"];
        self.progressRowImageView.image = progressRowImage;
        self.progressLabel.textColor = [UIColor whiteColor];
        
        CGSize progressRowImageSize = progressRowImage.size;
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 4.0, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 4.0 - progressRowImageSize.width, CGRectGetMaxY(self.progressLineView.frame) + 1.0, progressRowImageSize.width, 23.0);
        
    } else if (_progressType == AuthenProgressSheBaoGongJiJing) {
        //  社保/公积金
        self.progressLabel.text = @"就差最后一步了!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        UIImage *progressRowImage = [UIImage imageNamed:@"authen_row_redCenter"];
        self.progressRowImageView.image = progressRowImage;
        self.progressLabel.textColor = [UIColor whiteColor];

        CGSize progressRowImageSize = progressRowImage.size;
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 4.0, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 4.0 - progressRowImageSize.width, CGRectGetMaxY(self.progressLineView.frame) + 1.0, progressRowImageSize.width, 23.0);
        
    } else if (_progressType == AuthenProgressSubmitWhiteLoan) {
        //  白领贷认证
        self.progressLabel.text = @"白领贷认证已完成!";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        UIImage *progressRowImage = [UIImage imageNamed:@"authen_row_redleft"];
        self.progressRowImageView.image = progressRowImage;
        self.progressLabel.textColor = [UIColor whiteColor];
        
        CGSize progressRowImageViewSize = progressRowImage.size;
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 5, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 5 - progressRowImageViewSize.width, CGRectGetMaxY(self.progressLineView.frame) + 1.0, progressRowImageViewSize.width, 23.0);

    } else if (_progressType == AuthenProgressNoSubmitWhiteLoan) {
        //  白领贷认证
        self.progressLabel.text = @"已完成80%";
        self.progressLabel.font = [UIFont systemFontOfSize:9];
        self.progressRowImageView.image = [UIImage imageNamed:@"authen_row_line"];
        self.progressLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];

        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 4, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 4 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
    } else if (_progressType == AuthenProgressSubmitMallLoan) {
        //  消费分期认证
        self.progressLabel.text = @"消费分期认证已完成!";
        self.progressLabel.font = [UIFont systemFontOfSize:8];
        UIImage *progressRowImage = [UIImage imageNamed:@"authen_row_redleft"];
        self.progressRowImageView.image = progressRowImage;
        self.progressLabel.textColor = [UIColor whiteColor];
        
        CGSize progressRowImageViewSize = progressRowImage.size;
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 5, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 5 - progressRowImageViewSize.width, CGRectGetMaxY(self.progressLineView.frame) + 1.0, progressRowImageViewSize.width, 23.0);
        
    }
}

- (void)startAnimationWithProgessType:(AuthenProgressType)progressType{
    CGFloat lineViewWidth = Main_Screen_Width / 5.0;
    
    if (progressType == AuthenProgressScanIdentifyId) {
        //  扫描身份证
        self.progressLineView.frame = CGRectMake(0.0, 0.0, 1.0, 2.0);
        self.progressRowImageView.frame = CGRectMake(-30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        [UIView animateWithDuration:0.8 animations:^{
            self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth, 2.0);
            self.progressRowImageView.frame = CGRectMake(lineViewWidth - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        }];
    } else if (progressType == AuthenProgressFaceRecognition) {
        //  人脸识别
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        [UIView animateWithDuration:0.8 animations:^{
            self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 2, 2.0);
            self.progressRowImageView.frame = CGRectMake(lineViewWidth * 2 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        }];
        
    } else if (_progressType == AuthenProgressBindingBankCard) {
        //  绑定银行卡
        
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 2, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 2 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        [UIView animateWithDuration:0.8 animations:^{
            self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 3, 2.0);
            self.progressRowImageView.frame = CGRectMake(lineViewWidth * 3 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        }];
        
    } else if (_progressType == AuthenProgressSesameCredit) {
        //  芝麻信用
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 3, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 3 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        [UIView animateWithDuration:0.8 animations:^{
            self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 4, 2.0);
            self.progressRowImageView.frame = CGRectMake(lineViewWidth * 4 - 30.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 60.0, 23.0);
        }];
        
    } else if (_progressType == AuthenProgressOperators) {
        //  运营商
        self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 3.5, 2.0);
        self.progressRowImageView.frame = CGRectMake(lineViewWidth * 3.5 - 60.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 120.0, 23.0);
        [UIView animateWithDuration:0.8 animations:^{
            self.progressLineView.frame = CGRectMake(0.0, 0.0, lineViewWidth * 4.3, 2.0);
            self.progressRowImageView.frame = CGRectMake(lineViewWidth * 4.3 - 60.0, CGRectGetMaxY(self.progressLineView.frame) + 1.0, 120.0, 23.0);
        }];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:COLOR_WHITE_STR];
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
