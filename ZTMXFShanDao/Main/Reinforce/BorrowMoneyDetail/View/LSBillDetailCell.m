//
//  LSBillDetailCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/10.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBillDetailCell.h"

@implementation LSBillDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSBillDetailCell";
    LSBillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSBillDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



//  添加子控件
- (void)setupViews{
    
    /** title label */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"4a4a4a"] fontSize:AdaptedWidth(15) alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    /** value label */
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"4a4a4a"] fontSize:AdaptedWidth(16) alignment:NSTextAlignmentLeft];
    self.valueLabel.numberOfLines = 1;
    [self.contentView addSubview:self.valueLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_BORDER_STR];
    
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


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    CGFloat leftMargin = 12.0;
    CGFloat rowImageViewWidth = 8.0;
    
    CGSize size = [@"应还金额" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(15)]} context:nil].size;
    
    self.titleLabel.frame = CGRectMake(leftMargin, 0.0, size.width, cellHeight);
    
    if (self.showRowImageView) {
        self.rowImageView.hidden = NO;
        self.rowImageView.frame = CGRectMake(cellWidth - leftMargin - rowImageViewWidth, 0.0, rowImageViewWidth, cellHeight);
        self.valueLabel.frame = CGRectMake(self.titleLabel.right+AdaptedWidth(19), 0.0, self.rowImageView.left - self.titleLabel.right - AdaptedWidth(25), cellHeight);
        
    } else {
        self.rowImageView.hidden = YES;
        self.valueLabel.frame = CGRectMake(self.titleLabel.right+AdaptedWidth(19), 0.0, cellWidth - self.titleLabel.right - AdaptedWidth(50), cellHeight);
    }
    
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, cellWidth, 0.5);
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
