//
//  ZTMXFCertificationCenterCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationCenterCell.h"
#import "UIButton+JKImagePosition.h"
#import "ZTMXFCertificationStatusModel.h"
@implementation ZTMXFCertificationCenterCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /*
//        _imgView = [UIImageView new];
//        _nameLabel = [[UILabel alloc] init];
        _certificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COLOR_SRT(@"#F5F5F5");
//        [self.contentView addSubview:_imgView];
//        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_certificationBtn];
        [self.contentView addSubview:_lineView];
//
//        _imgView.sd_layout
//        .leftSpaceToView(self.contentView, 33)
//        .centerYEqualToView(self.contentView)
//        .widthIs(95)
//        .heightIs(49);
//
//        _nameLabel.sd_layout
//        .topSpaceToView(self.contentView, 22)
//        .leftSpaceToView(_imgView, 70)
//        .heightIs(22)
//        .rightSpaceToView(self.contentView, 10);
//
        _certificationBtn.sd_layout
        .rightSpaceToView(self.contentView, 14)
        .centerYEqualToView(self.contentView)
        .widthIs(16)
        .heightIs(28);
        [_certificationBtn setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
        _certificationBtn.userInteractionEnabled = NO;

        _lineView.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .bottomEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(1);

        _certificationBtn.userInteractionEnabled = NO;
        self.detailTextLabel.textColor = K_666666;
        self.detailTextLabel.font = FONT_Regular(12 * PX);
        self.textLabel.textColor = K_333333;
        self.textLabel.font = FONT_Regular(16 * PX);
         */
        
        UIView *grayView = [[UIView alloc]init];
        grayView.backgroundColor = COLOR_SRT(@"F5F5F5");
        grayView.layer.cornerRadius = 2;
        [self addSubview:grayView];
        
        UIView *whiteView = [[UIView alloc]init];
        whiteView.backgroundColor = UIColor.whiteColor;
        whiteView.layer.cornerRadius = 2;
        [grayView addSubview:whiteView];
        
        self.iconView = [[UIImageView alloc]init];
        [whiteView addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = FONT_Regular(X(18));
        self.titleLabel.textColor = K_333333;
        [whiteView addSubview:self.titleLabel];
        
        self.detailTitleLabel = [[UILabel alloc]init];
        self.detailTitleLabel.font = FONT_Regular(X(X(12)));
        self.detailTitleLabel.textColor = K_666666;
        [whiteView addSubview:self.detailTitleLabel];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.userInteractionEnabled = NO;
        [self.rightButton setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
        [self.rightButton.titleLabel setFont:FONT_Regular(X(14))];
        [whiteView addSubview:self.rightButton];
        
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(X(15));
            make.top.mas_equalTo(self.mas_top).mas_offset(X(10));
            make.right.mas_equalTo(self.mas_right).mas_offset(X(-15));
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(grayView.mas_left).mas_offset(X(5));
            make.right.mas_equalTo(grayView.mas_right).mas_offset(X(-5));
            make.bottom.mas_equalTo(grayView.mas_bottom).mas_offset(X(-5));
            make.top.mas_equalTo(grayView.mas_top).mas_offset(X(5));
        }];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(whiteView.mas_left).mas_offset(X(32));
            make.centerY.mas_equalTo(whiteView.mas_centerY);
            make.height.width.mas_equalTo(X(40));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(X(15));
            make.top.mas_equalTo(self.iconView.mas_top);
        }];
        [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(X(5));
        }];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(whiteView.mas_right).mas_offset(X(15));
            make.top.mas_equalTo(whiteView.mas_top);
            make.bottom.mas_equalTo(whiteView.mas_bottom);
            make.width.mas_equalTo(X(150));
        }];
        
    }
    
    return self;
}

- (void)setCertificationStatusModel:(ZTMXFCertificationStatusModel *)certificationStatusModel
{
    _certificationStatusModel = certificationStatusModel;
    
    self.titleLabel.text = certificationStatusModel.certificationName;
    self.detailTitleLabel.text = certificationStatusModel.detailsStr;
    self.iconView.image = [UIImage imageNamed:certificationStatusModel.iconStr];
    
//    _nameLabel.text = certificationStatusModel.certificationName;
//    _imgView.image = [UIImage imageNamed:certificationStatusModel.iconStr];
    
//    self.imageView.image = [UIImage imageNamed:certificationStatusModel.iconStr];
//    self.textLabel.text = certificationStatusModel.certificationName;;
//    self.detailTextLabel.text = certificationStatusModel.detailsStr;
    
    NSString * buttonString = @"";
    UIColor  * buttonTitleColor = UIColor.clearColor;
    switch (certificationStatusModel.certificationStatus) {
        case 0:
            buttonString = @"去认证";
            buttonTitleColor = K_MainColor;
            break;
        case 1:
            buttonString = @"已完成";
            buttonTitleColor = COLOR_SRT(@"73C915");
            break;
        case 2:
            buttonString = @"正在审核中…";
            buttonTitleColor = COLOR_SRT(@"4285E9");
            break;
        case -1:
            buttonString = @"审核失败";
            buttonTitleColor = COLOR_SRT(@"F5191B");
            break;
        default:
            break;
    }
    [self setTitle:buttonString titleColor:buttonTitleColor];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTitle:(NSString *)title titleColor:(UIColor *)color{
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton jk_setImagePosition:LXMImagePositionRight spacing:X(10)];
}
@end
