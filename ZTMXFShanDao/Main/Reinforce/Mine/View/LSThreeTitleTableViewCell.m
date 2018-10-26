//
//  LSThreeTitleTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSThreeTitleTableViewCell.h"
#import "LSPromoteAmountModel.h"

@implementation LSThreeTitleTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSThreeTitleTableViewCell";
    LSThreeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSThreeTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        self.backgroundColor = [UIColor clearColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    /** first label */
    self.firstLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.firstLabel];
    //    self.firstLabel.backgroundColor = [UIColor yellowColor];
    
    /** second label */
    self.secondLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.secondLabel];
    //    self.secondLabel.backgroundColor = [UIColor orangeColor];
    
    
    /** third label */
    self.thirdLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.thirdLabel];
    //    self.thirdLabel.backgroundColor = [UIColor yellowColor];
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:@"f6f6f6"];
    
    self.circleImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    CGFloat leftMargin = 12.0;
    CGFloat whiteViewW = cellWidth - leftMargin * 2;
    CGFloat firstLabelW = whiteViewW / 3.0;
    CGFloat secondLabelW = whiteViewW / 3.0;
    CGFloat thirdLabelW = whiteViewW / 3.0;
    
    self.firstLabel.frame = CGRectMake(leftMargin, 0.0, firstLabelW, cellHeight);
    self.secondLabel.frame = CGRectMake(CGRectGetMaxX(self.firstLabel.frame), 0.0, secondLabelW, cellHeight);
    self.thirdLabel.frame = CGRectMake(CGRectGetMaxX(self.secondLabel.frame), 0.0, thirdLabelW, cellHeight);
    self.bottomLineView.frame = CGRectMake(5.0, cellHeight - 1.0, whiteViewW - 10.0, 1.0);

    self.circleImageView.frame = CGRectMake(CGRectGetMinX(self.secondLabel.frame) - 20.0, 0.0, 11.0, cellHeight);
}

//  提额足迹设置数据
- (void)setPromoteAmountModel:(LSPromoteAmountModel *)promoteAmountModel{
    if (_promoteAmountModel != promoteAmountModel) {
        _promoteAmountModel = promoteAmountModel;
        
        self.firstLabel.text = [NSDate dateYMDacrossStringFromLongDate:_promoteAmountModel.gmtAuthAmount];
        CGFloat promoteAmount = _promoteAmountModel.amount - _promoteAmountModel.originalAmount;
        if (promoteAmount > 0) {
            self.secondLabel.text = [NSString stringWithFormat:@"+%.2f元",promoteAmount];
        } else {
            self.secondLabel.text = [NSString stringWithFormat:@"%.2f元",promoteAmount];
        }
        self.thirdLabel.text = _promoteAmountModel.typeDec;
        self.bottomLineView.hidden = YES;
    }
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
