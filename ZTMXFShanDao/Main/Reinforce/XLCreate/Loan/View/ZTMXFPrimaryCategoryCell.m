//
//  ZTMXFPrimaryCategoryCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 凉 on 2018/7/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPrimaryCategoryCell.h"
#import "ZTMXFClassification.h"
@implementation ZTMXFPrimaryCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 50 * PX)];
        self.textLabel.textColor = K_333333;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = FONT_Regular(13 * PX);
        _leftView.backgroundColor = K_MainColor;
        [self.contentView addSubview:_leftView];
        self.textLabel.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView);
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setClassification:(ZTMXFClassification *)classification
{
    if (_classification != classification) {
        _classification = classification;
    }
    _leftView.hidden = !_classification.isSelect;
    self.textLabel.text = _classification.name;
    if (_classification.isSelect) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else{
        self.contentView.backgroundColor = K_LineColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
