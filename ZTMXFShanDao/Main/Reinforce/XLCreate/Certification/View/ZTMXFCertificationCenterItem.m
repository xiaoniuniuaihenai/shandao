//
//  ZTMXFCertificationCenterItem.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/7.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationCenterItem.h"
#import "ZTMXFLsdAuthCenterConfigureList.h"

@interface ZTMXFCertificationCenterItem()
@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *amountLabel;
@end

@implementation ZTMXFCertificationCenterItem



- (void)setCertificationStatus:(XLCertificationStatus *)certificationStatus{
    self.titleLabel.text = certificationStatus.authName;
    NSString *imageName = [self imageForStatus][certificationStatus.authNameUnique];
    NSString *amountLabelText = @"";
    switch (certificationStatus.authStatus) {
        case 0:
            imageName = [imageName stringByAppendingString:@""];
            amountLabelText = @"+500";
            break;
        case 1:
            imageName = [imageName stringByAppendingString:@"_Success"];
            amountLabelText = @"已领取";
            break;
        case -1:
            imageName = [imageName stringByAppendingString:@"_Failer"];
            amountLabelText = @"+500";
            break;
        case 2:
            imageName = [imageName stringByAppendingString:@"_Loading"];
            amountLabelText = @"+500";
            break;
            
        default:
            break;
    }
    self.amountLabel.text = amountLabelText;
    [self.iconButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}


- (void)configUI{
//    UIView * whiteView = [UIView new];
//    [self.contentView addSubview:whiteView];
//    whiteView.frame = self.contentView.bounds;
//    whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.amountLabel];
}

- (void)layoutSubviews{
    self.iconButton.sd_layout
    .topSpaceToView(self.contentView, X(0))
    .centerXEqualToView(self.contentView)
    .widthIs(X(114))
    .heightIs(X(84));
    
    self.titleLabel.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.iconButton, 0)
    .heightIs(X(20));
    
    self.amountLabel.sd_layout
    .topSpaceToView(self.titleLabel, X(5))
    .centerXEqualToView(self.contentView)
    .widthIs(X(50))
    .heightIs(X(20));
    self.amountLabel.sd_cornerRadius = @(3);
}

- (UIButton *)iconButton{
    if (!_iconButton) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconButton.userInteractionEnabled = NO;
    }
    return _iconButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel               = [[UILabel alloc]init];
        _titleLabel.font          = FONT_Regular(X(14));
        _titleLabel.textColor     = K_333333;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel  = [[UILabel alloc]init];
        _amountLabel.font = FONT_Regular(X(12));
        _amountLabel.textColor = UIColor.whiteColor;
        _amountLabel.backgroundColor = K_MainColor;
        _amountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _amountLabel;
}

- (NSDictionary *)imageForStatus{
    return @{
             @"idnumber_status":@"JZ_RZ_ShiMing",
             @"bind_card"      :@"JZ_RZ_YinHangKa",
             @"zm_status"      :@"JZ_RZ_ZhiMa",
             @"mobile_status"  :@"JZ_RZ_YunYingShang",
             @"contacts_status":@"JZ_RZ_TongXunLu",
             @"taobao_status"  :@"JZ_RZ_TaoBao",
             @"jingdong_status":@"JZ_RZ_JingDong"
             };
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self configUI];
    }
    return self;
}
@end
