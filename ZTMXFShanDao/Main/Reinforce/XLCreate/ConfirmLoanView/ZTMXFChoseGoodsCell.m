//
//  ZTMXFChoseGoodsCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFChoseGoodsCell.h"

@implementation ZTMXFChoseGoodsCell



+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFChoseGoodsCell";
    ZTMXFChoseGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFChoseGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.text = @"选择商品";
        self.textLabel.textColor = K_888888;
        self.textLabel.font = FONT_Regular(14 * PX);
//        _bottomLine = [UIView new];
//        _bottomLine.backgroundColor = K_LineColor;
//        [self.contentView addSubview:_bottomLine];
       
        //lis
        //self.bottomLine.sd_layout
        //.leftEqualToView(self.textLabel)
        //.bottomEqualToView(self.contentView)
        //.rightEqualToView(self.contentView)
        //.heightIs(1);
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"查看更多商品" forState:UIControlStateNormal];
        [self.contentView addSubview:_moreBtn];
        _moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_moreBtn setTitleColor:K_888888 forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = FONT_Regular(14 * PX);
        _moreBtn.sd_layout
        .rightSpaceToView(self.successfulImgView, 10)
        .centerYEqualToView(self.contentView)
        .heightIs(20 * PX)
        .widthIs(110);
       
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
