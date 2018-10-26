//
//  ALATitleValueTableViewCell.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/16.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ALATitleValueTableViewCell.h"

@implementation ALATitleValueTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ALATitleValueTableViewCell";
    ALATitleValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ALATitleValueTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



//  添加子控件
- (void)setupViews{
    
    /** title label */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:15 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    /** value label */
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:15 alignment:NSTextAlignmentRight];
    self.valueLabel.numberOfLines = 1;
    [self.contentView addSubview:self.valueLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_DEEPBORDER_STR];
    
    self.dashImageView = [UIImageView setupImageViewWithImageName:@"XL_line_dash" withSuperView:self.contentView];
    self.dashImageView.hidden = YES;
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
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    CGFloat leftMargin = 12.0;
    
    self.titleLabel.frame = CGRectMake(leftMargin, 0.0, cellWidth - 60.0, cellHeight);
    
    if (self.showRowImageView) {
        self.rowImageView.hidden = NO;
        self.valueLabel.frame = CGRectMake(120.0, 0.0, cellWidth - 120.0 - 25.0, cellHeight);
        self.rowImageView.frame = CGRectMake(cellWidth - 20.0, 0.0, 8.0, cellHeight);

    } else {
        self.rowImageView.hidden = YES;
        self.valueLabel.frame = CGRectMake(120.0, 0.0, cellWidth - 120.0 - 12.0, cellHeight);
    }
    
    self.bottomLineView.frame = CGRectMake(leftMargin, cellHeight - 0.5, cellWidth - 2 * leftMargin, 0.5);
    self.dashImageView.frame = CGRectMake(leftMargin, cellHeight - 0.5, cellWidth - 2 * leftMargin, 0.5);
}

- (void)setShowRowImageView:(BOOL)showRowImageView{
    _showRowImageView = showRowImageView;
    
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
