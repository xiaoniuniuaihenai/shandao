//
//  LSWhiteLoanDetailCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSWhiteLoanDetailCell.h"

@interface LSWhiteLoanDetailCell ()

/** value label */
@property (nonatomic, strong) UILabel *valueLabel;

/** row image view */
@property (nonatomic, strong) UIImageView *rowImageView;
/** bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation LSWhiteLoanDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSWhiteLoanDetailCell";
    LSWhiteLoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSWhiteLoanDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



- (void)setLoanDetailDict:(NSDictionary *)loanDetailDict{
    _loanDetailDict = loanDetailDict;
    
    self.titleLabel.text = _loanDetailDict[kTitleValueCellManagerKey];
    self.valueLabel.text = _loanDetailDict[kTitleValueCellManagerValue];
    
    if ([self.titleLabel.text isEqualToString:@"借款编号"]) {
        self.showRowImageView = YES;
    } else {
        self.showRowImageView = NO;
    }
}

- (void)setShowRowImageView:(BOOL)showRowImageView{
    _showRowImageView = showRowImageView;
    
    [self layoutIfNeeded];
}

//  添加子控件
- (void)setupViews{
    
    /** title label */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    /** value label */
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentRight];
    self.valueLabel.numberOfLines = 1;
    [self.contentView addSubview:self.valueLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"mine_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_DEEPBORDER_STR];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:COLOR_WHITE_STR];
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
        self.valueLabel.frame = CGRectMake(0.0, 0.0, cellWidth - 30.0, cellHeight);
        self.rowImageView.frame = CGRectMake(cellWidth - 20.0, 0.0, 8.0, cellHeight);
        
    } else {
        self.rowImageView.hidden = YES;
        self.valueLabel.frame = CGRectMake(0.0, 0.0, cellWidth - 20.0, cellHeight);
    }
    
    self.bottomLineView.frame = CGRectMake(leftMargin, cellHeight - 0.5, cellWidth - 2 * leftMargin, 0.5);
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
