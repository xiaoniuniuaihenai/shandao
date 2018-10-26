//
//  LSMineTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSMineTableViewCell.h"

@implementation LSMineTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSMineTableViewCell";
    LSMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSMineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _showRowImageView = YES;
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    /** icon ImageView */
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.userInteractionEnabled = YES;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconImageView];
    
    /** title label */
    self.titleLabel = [UILabel labelWithTitleColor:COLOR_WORD_BLACK fontSize:15 alignment:NSTextAlignmentLeft];
    self.titleLabel.font = AdaptedFontSize(15);
    [self.contentView addSubview:self.titleLabel];
    
    /** value label */
    self.valueLabel = [UILabel labelWithTitleColor:K_B8B8B8 fontSize:13 alignment:NSTextAlignmentRight];
    self.valueLabel.font = AdaptedFontSize(13);
    self.valueLabel.numberOfLines = 1;
    [self.contentView addSubview:self.valueLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"mine_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:@"f5f5f5"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    CGFloat leftMargin = 16.0;
    
    CGFloat iconImageViewWidth = 20;
    self.iconImageView.frame = CGRectMake(leftMargin, 0.0, iconImageViewWidth, 20);
    self.iconImageView.centerY = AdaptedHeight(50)/2.0;
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10.0, 0.0, cellWidth - 120.0, cellHeight);
    
    if (self.showRowImageView) {
        self.rowImageView.hidden = NO;
        self.valueLabel.frame = CGRectMake(cellWidth - 220.0, 0.0, 195.0, cellHeight);
        self.rowImageView.frame = CGRectMake(cellWidth - 20.0, 0.0, 8.0, cellHeight);
        
    } else {
        self.rowImageView.hidden = YES;
        self.valueLabel.frame = CGRectMake(cellWidth - 220.0, 0.0, 208.0, cellHeight);
    }
    
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 1.0, cellWidth, 1.0);
}

- (void)setShowRowImageView:(BOOL)showRowImageView{
    _showRowImageView = showRowImageView;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
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
