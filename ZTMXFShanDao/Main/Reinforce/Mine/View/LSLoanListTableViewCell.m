//
//  LSLoanListTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanListTableViewCell.h"
#import "LSLoanRecordModel.h"
#import "UILabel+Attribute.h"

@implementation LSLoanListTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSLoanListTableViewCell";
    LSLoanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSLoanListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    self.firstView = [UIView setupViewWithSuperView:self withBGColor:COLOR_WHITE_STR];
//    self.firstView.layer.cornerRadius = 4.0;
    
    //  借款金额
    self.loanAmountIcon = [UIImageView setupImageViewWithImageName:@"XL_loan_amount" withSuperView:self.firstView];
    self.loanAmountIcon.contentMode = UIViewContentModeCenter;

    self.loanAmount = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:15 alignment:NSTextAlignmentLeft];
    self.loanAmount.text = @"借款金额";
    [self.firstView addSubview:self.loanAmount];

    self.loanAmountLabel = [[UILabel alloc]init];
    self.loanAmountLabel.textColor = K_333333;
    self.loanAmountLabel.textAlignment = NSTextAlignmentRight;
    self.loanAmountLabel.font = FONT_Medium(X(30));
    [self.firstView addSubview:self.loanAmountLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.firstView];
    self.rowImageView.contentMode = UIViewContentModeRight;

    self.secondView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_WHITE_STR];
    self.secondView.layer.cornerRadius = 4.0;

    self.loanDateIcon = [UIImageView setupImageViewWithImageName:@"XL_loan_date" withSuperView:self.secondView];
    self.loanDateIcon.contentMode = UIViewContentModeCenter;
    
    self.loanDate = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
    self.loanDate.text = @"申请时间";
    [self.secondView addSubview:self.loanDate];
    
    self.loanDateLabel = [UILabel labelWithTitleColorStr:@"9B9B9B" fontSize:X(14) alignment:NSTextAlignmentLeft];
    [self.firstView addSubview:self.loanDateLabel];

    
    self.loanStateIcon = [UIImageView setupImageViewWithImageName:@"XL_loan_state" withSuperView:self.secondView];
    self.loanStateIcon.contentMode = UIViewContentModeCenter;
    
    self.loanState = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
    self.loanState.text = @"状态";
    [self.secondView addSubview:self.loanState];
    
    self.loanStateLabel = [[UILabel alloc]init];
    self.loanStateLabel.textColor = K_333333;
    self.loanStateLabel.textAlignment = NSTextAlignmentLeft;
    self.loanStateLabel.font = FONT_Medium(X(16));

    [self.firstView addSubview:self.loanStateLabel];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    [self.loanAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_firstView.mas_right).mas_offset(X(-30));
        make.top.bottom.mas_equalTo(_firstView);
        make.width.mas_equalTo(X(240));
    }];
    [self.loanStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_firstView.mas_left).mas_offset(X(15));
        make.centerY.mas_equalTo(_firstView.mas_top).mas_offset(X(26));
        make.width.mas_equalTo(X(200));
    }];
    [self.loanDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loanStateLabel.mas_left);
        make.centerY.mas_equalTo(self.loanStateLabel.mas_centerY).mas_offset(X(26));
        make.width.mas_equalTo(X(200));
    }];
    
//    CGFloat cellHeight = self.bounds.size.height;
//    CGFloat cellWidth = self.bounds.size.width;
//    CGFloat leftMargin = 10.0;
//
//    self.firstView.frame = CGRectMake(leftMargin, 10.0, cellWidth - 20.0, 50.0);
//    self.loanAmountIcon.frame = CGRectMake(0.0, 0.0, 48.0, CGRectGetHeight(self.firstView.frame));
//    self.loanAmount.frame = CGRectMake(CGRectGetMaxX(self.loanAmountIcon.frame), 0.0, 160.0, CGRectGetHeight(self.firstView.frame));
//    self.loanAmountLabel.frame = CGRectMake(CGRectGetWidth(self.firstView.frame) - 37.0 - 240.0, 0.0, 240.0, CGRectGetHeight(self.firstView.frame));
//    self.rowImageView.frame = CGRectMake(CGRectGetWidth(self.firstView.frame) - 14 - 20.0, CGRectGetMinY(self.loanAmountLabel.frame), 20, CGRectGetHeight(self.loanAmountLabel.frame));
//
//    self.secondView.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.firstView.frame) + 1, CGRectGetWidth(self.firstView.frame), 80.0);
//    self.loanDateIcon.frame = CGRectMake(0.0, 12.0, CGRectGetWidth(self.loanAmountIcon.frame), 25.0);
//    self.loanDate.frame = CGRectMake(CGRectGetMinX(self.loanAmount.frame), CGRectGetMinY(self.loanDateIcon.frame), 160.0, CGRectGetHeight(self.loanDateIcon.frame));
//    self.loanDateLabel.frame = CGRectMake(CGRectGetWidth(self.secondView.frame) - 14.0 - 240.0, CGRectGetMinY(self.loanDate.frame), 240.0, CGRectGetHeight(self.loanDate.frame));
//
//    self.loanStateIcon.frame = CGRectMake(0.0, CGRectGetMaxY(self.loanDateIcon.frame), CGRectGetWidth(self.loanDateIcon.frame), CGRectGetHeight(self.loanDateIcon.frame));
//    self.loanState.frame = CGRectMake(CGRectGetMinX(self.loanAmount.frame), CGRectGetMinY(self.loanStateIcon.frame), 160.0, CGRectGetHeight(self.loanStateIcon.frame));
//    self.loanStateLabel.frame = CGRectMake(CGRectGetMinX(self.loanDateLabel.frame), CGRectGetMinY(self.loanState.frame), CGRectGetWidth(self.loanDateLabel.frame), CGRectGetHeight(self.loanDate.frame));
    
}

//  记录model
- (void)setLoanRecordModel:(LSLoanRecordModel *)loanRecordModel{
    if (_loanRecordModel != loanRecordModel) {
        _loanRecordModel = loanRecordModel;
        
        self.loanAmount.text = _loanRecordModel.typeDesc;
        NSString *amountString = [NSString stringWithFormat:@"¥%.2f",_loanRecordModel.amount];
        if ([self.loanRecordModel.status integerValue] == 5) {//待还款
            self.loanAmountLabel.textColor = K_MainColor;
        }else{
            self.loanAmountLabel.textColor = K_333333;
        }
        [UILabel attributeWithLabel:_loanAmountLabel text:amountString textFont:30 * PX attributes:@[@"¥"] attributeFonts:@[FONT_Regular(16 * PX)]];
        self.loanDateLabel.text = [NSDate dateStringFromLongDate:_loanRecordModel.gmtCreate];
        self.loanStateLabel.text = _loanRecordModel.statusDesc;
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
