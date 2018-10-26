//
//  ZTMXFConfirmLoanCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFConfirmLoanCell.h"

@implementation ZTMXFConfirmLoanCell

+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFConfirmLoanCell";
    ZTMXFConfirmLoanCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFConfirmLoanCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.detailTextLabel.font = FONT_Regular(16 * PX);
        self.detailTextLabel.textColor = K_333333;

        [self.detailTextLabel setSingleLineAutoResizeWithMaxWidth:KW / 2];
        _successfulImgView = [UIImageView new];
        _successfulImgView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_successfulImgView];
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = K_LineColor;
        [self.contentView addSubview:_bottomLine];
//        _bottomLine.hidden = YES;
        _successfulImgView.sd_layout
        .rightSpaceToView(self.contentView, 5)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .widthIs(15);
        
        _bottomLine.sd_layout
        .leftEqualToView(self.textLabel)
        .topEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(1);
        
        _successfulImgView.image = [UIImage imageNamed:@"mine_right_arrow"];
        
        _rigthLabel = [UILabel new];
        _rigthLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rigthLabel];
        
        self.rigthLabel.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .centerYEqualToView(self.contentView)
        .heightIs(30);
        [_rigthLabel setSingleLineAutoResizeWithMaxWidth:KW / 2];
        _rigthLabel.textAlignment = NSTextAlignmentRight;
        
        _rigthLabel.textColor = K_333333;
        self.rigthLabel.font = FONT_Regular(16 * PX);
        
        _iconImgView = [UIImageView new];
        [self.contentView addSubview:_iconImgView];
        
        _iconImgView.sd_layout
        .rightSpaceToView(_rigthLabel, 3)
        .heightIs(22 * PX)
        .widthIs(22 * PX)
        .centerYEqualToView(self.contentView);
        
    }
    return self;
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
