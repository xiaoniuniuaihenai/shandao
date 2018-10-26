//
//  LSLoanRecordTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanRecordTableViewCell.h"
#import "LSLoanRecordModel.h"
#import "ZTMXFRenewRecordModel.h"
#import "LSRepaymentListModel.h"

@implementation LSLoanRecordTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSLoanRecordTableViewCell";
    LSLoanRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSLoanRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    /** 还款类型 */
    self.loanTypeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:17 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.loanTypeLabel];
    
    /** 借款金额 */
    self.loanAmountLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:18 alignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.loanAmountLabel];
    
    /** 借款日期 */
    self.loanDateLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.loanDateLabel];
    
    /** 借款状态 */
    self.loanStateLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:15 alignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.loanStateLabel];
    
    
    self.renewAmountLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.renewAmountLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** bottomLineView */
//    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_DEEPBORDER_STR];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat leftMargin = 15.0;
    
    self.loanTypeLabel.frame = CGRectMake(leftMargin, 10.0, Main_Screen_Width - 140.0, 20.0);
    self.loanAmountLabel.frame = CGRectMake(Main_Screen_Width - 25.0 - 200.0, CGRectGetMinY(self.loanTypeLabel.frame), 200.0, 20.0);
    self.loanDateLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.loanAmountLabel.frame) + 10.0, 260.0, 20.0);
    
    self.loanStateLabel.frame = CGRectMake(Main_Screen_Width - 25.0 - 200.0, CGRectGetMinY(self.loanDateLabel.frame), 200.0, 20.0);
    
    self.renewAmountLabel.frame = CGRectMake(Main_Screen_Width - 25.0 - 200.0, CGRectGetMinY(self.loanDateLabel.frame), 200.0, CGRectGetHeight(self.loanDateLabel.frame));
    
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, Main_Screen_Width, 0.5);
    
    self.rowImageView.frame = CGRectMake(Main_Screen_Width - 20.0, CGRectGetMaxY(self.loanAmountLabel.frame), 8.0, CGRectGetHeight(self.loanStateLabel.frame));
    self.rowImageView.centerY = self.frame.size.height/2.0;
}

//  借钱记录Model
- (void)setLoanRecordModel:(LSLoanRecordModel *)loanRecordModel{
    if (_loanRecordModel != loanRecordModel) {
        _loanRecordModel = loanRecordModel;
     
        self.loanAmountLabel.text = [NSString stringWithFormat:@"借款%.2f元",_loanRecordModel.amount];
        self.loanDateLabel.text = [NSDate dateStringFromLongDate:_loanRecordModel.gmtCreate];
        self.loanStateLabel.text = _loanRecordModel.statusDesc;
    }
}

//  延期还款记录Model
- (void)setRenewRecordModel:(ZTMXFRenewRecordModel *)renewRecordModel{
    if (_renewRecordModel != renewRecordModel) {
        _renewRecordModel = renewRecordModel;
        self.loanTypeLabel.text = renewRecordModel.repayDesc;//延期还款方式
        self.loanAmountLabel.text = [NSString stringWithFormat:@"%.2f元",_renewRecordModel.renewalAmount];
        self.loanDateLabel.text = [NSDate dateStringFromLongDate:_renewRecordModel.gmtCreate];
        self.loanStateLabel.text = _renewRecordModel.statusDesc;
//        self.renewAmountLabel.text = [NSString stringWithFormat:@"%.2f元",_renewRecordModel.renewalPayAmount];
    }
}

//  还款记录Model
- (void)setRepaymentListModel:(LSRepaymentListModel *)repaymentListModel{
    if (_repaymentListModel != repaymentListModel) {
        _repaymentListModel = repaymentListModel;
        
        self.loanTypeLabel.text = _repaymentListModel.repayDec;//还款方式
        self.loanAmountLabel.text = [NSString stringWithFormat:@"%.2f元",_repaymentListModel.amount];
        self.loanDateLabel.text = [NSDate dateStringFromLongDate:_repaymentListModel.gmtRepay];
        self.loanStateLabel.text = _repaymentListModel.statusDesc;

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
