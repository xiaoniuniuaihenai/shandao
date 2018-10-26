//
//  ZTMXFLoanAdCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanAdCell.h"
//#import <UIImageView+WebCache.h>
#import "UIImageView+Addition.h"

@implementation ZTMXFLoanAdCell


+ (id)LoanAdCellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFLoanAdCell";
    ZTMXFLoanAdCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFLoanAdCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        _adImageView = [UIImageView new];
        _adImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _adImageView.clipsToBounds
        [self.contentView addSubview:_adImageView];
        
        _adImageView.sd_layout
        .rightEqualToView(self.contentView)
        .leftEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView);
        
        _shutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shutBtn setImage:[UIImage imageNamed:@"Loan_shut"] forState:UIControlStateNormal];
        [self.contentView addSubview:_shutBtn];
        
        _shutBtn.sd_layout
        .topEqualToView(_adImageView)
        .rightEqualToView(self.contentView)
        .heightIs(40 * PX)
        .widthIs(40 * PX);
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = K_LineColor;
        [self.contentView addSubview:lineView];
        
        lineView.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(1);
        
        
        
        
    }
    return self;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setImageUrl:(NSString *)imageUrl
{
    if (_imageUrl != imageUrl) {
        _imageUrl = [imageUrl copy];
    }
    [self.adImageView sd_setImageFadeEffectWithURLstr:_imageUrl placeholderImage:nil];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
