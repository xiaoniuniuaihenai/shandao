//
//  ZTMXFCertificationListCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationListCell.h"
#import "ZTMXFLsdAuthCenterConfigureList.h"
@implementation ZTMXFCertificationListCell

+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFCertificationListCell";
    ZTMXFCertificationListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFCertificationListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.detailTextLabel.font = FONT_Regular(14);
        self.detailTextLabel.sd_layout
        .centerYEqualToView(self.contentView);
        
        
        [self.detailTextLabel setSingleLineAutoResizeWithMaxWidth:KW / 2];
        _successfulImgView = [UIImageView new];
        _successfulImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_successfulImgView];
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = K_LineColor;
        [self.contentView addSubview:_bottomLine];
        _bottomLine.hidden = YES;
        
        _successfulImgView.sd_layout
        .rightSpaceToView(self.detailTextLabel, 5)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .widthIs(15);
        
        _bottomLine.sd_layout
        .leftEqualToView(self.textLabel)
        .bottomEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(1);
        
        _successfulImgView.image = [UIImage imageNamed:@"XL_RZ_WanCheng"];
        _rigthLabel = [UILabel new];
        _rigthLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rigthLabel];
        
        
        self.rigthLabel.sd_layout
        .rightEqualToView(self.detailTextLabel)
        .centerYEqualToView(self.contentView)
        .heightIs(30)
        .widthIs(60);
        
        _rigthLabel.textColor = K_MainColor;
        self.rigthLabel.font = FONT_Regular(14);
        self.rigthLabel.layer.cornerRadius = 5;
        self.rigthLabel.layer.borderColor = K_MainColor.CGColor;
        self.rigthLabel.layer.borderWidth = 1;
        

    }
    return self;
}


- (void)setCertificationStatus:(XLCertificationStatus *)certificationStatus
{
    _certificationStatus = certificationStatus;
    self.textLabel.text = _certificationStatus.authName;
    NSString * imgStr = @"";
    if ([certificationStatus.authNameUnique isEqualToString:@"idnumber_status"]) {
        imgStr = @"XL_Mine_RenZheng";
    }else if ([certificationStatus.authNameUnique isEqualToString:@"bind_card"]) {
        imgStr = @"XL_Mine_YinHangKa";
    }else if ([certificationStatus.authNameUnique isEqualToString:@"zm_status"]) {
        imgStr = @"XL_RZ_ZhiMa";
    }else if ([certificationStatus.authNameUnique isEqualToString:@"mobile_status"]) {
        imgStr = @"XL_RZ_YunYingShang";
    }else if ([certificationStatus.authNameUnique isEqualToString:@"taobao_status"]) {
        imgStr = @"XL_RZ_TaoBao";
    }else if ([certificationStatus.authNameUnique isEqualToString:@"jingdong_status"]) {
        imgStr = @"XL_RZ_JD";
    }else if ([certificationStatus.authNameUnique isEqualToString:@"contacts_status"]) {
        imgStr = @"XL_RZ_TongXunLu";
    }
    
    self.imageView.image = [UIImage imageNamed:imgStr];
    _successfulImgView.hidden = YES;
    NSString * status = @"";
    NSString * textCorol = @"#2B91F0";
    _rigthLabel.hidden = YES;
    self.detailTextLabel.hidden = NO;
    switch (_certificationStatus.authStatus) {
        case 0:
            status = @"";
            self.detailTextLabel.hidden = YES;
            _rigthLabel.hidden = NO;
            _rigthLabel.text = @"去认证";
            break;
        case 1:
            status = @"已认证";
            _successfulImgView.hidden = NO;
            textCorol = @"#73C915";
            break;
        case 2:
            status = @"认证中";
            textCorol = @"#F5A623";
            break;
        case -1:
            status = @"认证失败，请重新认证";
            break;
            
        default:
            break;
    }
    self.detailTextLabel.text = status;
    self.detailTextLabel.textColor = COLOR_SRT(textCorol);
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
