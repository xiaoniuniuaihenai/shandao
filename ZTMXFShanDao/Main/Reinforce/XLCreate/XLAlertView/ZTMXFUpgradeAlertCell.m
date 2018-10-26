//
//  ZTMXFUpgradeAlertCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/20.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFUpgradeAlertCell.h"

@implementation ZTMXFUpgradeAlertCell

+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFUpgradeAlertCell";
    ZTMXFUpgradeAlertCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFUpgradeAlertCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)setDesc:(NSString *)desc
{
    _desc = desc;
    self.textLabel.text = desc;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * view = [UIView new];
        view.hidden = YES;
        [self.contentView addSubview:view];
        
        view.sd_layout
        .leftEqualToView(self.contentView)
        .topSpaceToView(self.contentView, 15)
        .widthIs(4)
        .heightIs(4);
        view.backgroundColor = COLOR_SRT(@"#F5A623");
        view.sd_cornerRadiusFromWidthRatio = @0.5;
        
        
        self.clipsToBounds = YES;
        self.textLabel.font = FONT_Regular(14 * PX);
        self.textLabel.textColor = COLOR_SRT(@"#323232");
        
        self.textLabel.sd_layout
        .topSpaceToView(self.contentView, 7)
        .leftSpaceToView(view, 8 * PX)
        .rightEqualToView(self.contentView)
        .autoHeightRatio(0);
        
        [self setupAutoHeightWithBottomView:self.textLabel bottomMargin:7];
        
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
