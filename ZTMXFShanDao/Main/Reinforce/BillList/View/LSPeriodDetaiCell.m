//
//  LSPeriodDetaiCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodDetaiCell.h"
#import "LSBillListModel.h"
#import "MallBillInfoModel.h"

@interface LSPeriodDetaiCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *periodLabel;

@property (nonatomic, strong) UILabel *loanStatusLabel;

@property (nonatomic, strong) UILabel *overdueStatusLabel;

@property (nonatomic, strong) UILabel *restitutionTimeLabel;

@property (nonatomic, strong) UILabel *loanAmountLabel;

@property (nonatomic, strong) UIImageView *rowImageView;

@property (nonatomic, strong) UILabel *lineLabel;

/** cell 类型 */
@property (nonatomic, assign) LSPeriodDetailCellType loanCellType;

@end

@implementation LSPeriodDetaiCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSPeriodDetaiCell";
    LSPeriodDetaiCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSPeriodDetaiCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
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



#pragma mark -
- (void)setMallBillModel:(MallBillListModel *)mallBillModel{
    _mallBillModel = mallBillModel;
    if (_mallBillModel) {
        
        self.periodLabel.text = [NSString stringWithFormat:@"第%ld期",_mallBillModel.billNper];
        
        NSString *willPayDate = [NSDate dateYMDacrossStringFromLongDate:_mallBillModel.gmtRepay];
        NSString *returnDate = [NSDate dateYMDacrossStringFromLongDate:_mallBillModel.gmtPlanRepay];
        if (_mallBillModel.status == 1) {
            // 还款成功
            self.restitutionTimeLabel.text = [NSString stringWithFormat:@"%@ 已还",willPayDate];
        } else {
            self.restitutionTimeLabel.text = [NSString stringWithFormat:@"%@ 应还",returnDate];
        }
        
        NSString *loanAmountStr = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_mallBillModel.billAmount]];
        self.loanAmountLabel.text = loanAmountStr;
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}
#pragma mark -
-(void)setBillListModel:(LSBillListModel *)billListModel{
    _billListModel = billListModel;
    if (_billListModel) {
        
        self.periodLabel.text = [NSString stringWithFormat:@"第%ld期",_billListModel.billNper];
        
        NSString *returnDate = [NSDate dateYMDacrossStringFromLongDate:_billListModel.gmtPlanRepayment];
        self.restitutionTimeLabel.text = returnDate;
        
        NSString *loanAmountStr = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_billListModel.billAmount]];
        self.loanAmountLabel.text = loanAmountStr;
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}





#pragma mark - 私有方法
#pragma mark - 点击选中按钮
- (void)clickSelectedBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delegete && [self.delegete respondsToSelector:@selector(selectedCellButtonClick:)]) {
        [self.delegete selectedCellButtonClick:self.mallBillModel];
    }
}

#pragma mark - 设置子视图
- (void)setupViews{
    
    self.bgView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_WHITE_STR];
    
    // 选中按钮
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
    [self.selectedBtn addTarget:self action:@selector(clickSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.selectedBtn];
    
    // 借款期数
    self.periodLabel = [UILabel labelWithTitleColorStr:@"333333" fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.periodLabel];
    
    // 还款状态
    self.loanStatusLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] fontSize:AdaptedWidth(13) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.loanStatusLabel];
    self.loanStatusLabel.text = @"还款处理中...";
    self.loanStatusLabel.hidden = YES;
    
    // 日期
    self.restitutionTimeLabel = [UILabel labelWithTitleColorStr:@"888888" fontSize:AdaptedWidth(12) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.restitutionTimeLabel];
    
    // 逾期状态
    self.overdueStatusLabel = [UILabel labelWithTitleColorStr:@"F85C3B" fontSize:AdaptedWidth(12) alignment:NSTextAlignmentCenter];
    self.overdueStatusLabel.layer.cornerRadius = 4.0;
    self.overdueStatusLabel.layer.borderWidth = 1.0;
    self.overdueStatusLabel.layer.borderColor = [UIColor colorWithHexString:COLOR_RED_STR].CGColor;
    self.overdueStatusLabel.layer.masksToBounds = YES;
    self.overdueStatusLabel.text = @"逾期";
    [self.bgView addSubview:self.overdueStatusLabel];
    self.overdueStatusLabel.hidden = YES;
    
    // 账单金额
    self.loanAmountLabel = [UILabel labelWithTitleColorStr:@"333333" fontSize:AdaptedWidth(14) alignment:NSTextAlignmentRight];
    [self.bgView addSubview:self.loanAmountLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"mine_right_arrow" withSuperView:self.bgView];
    self.rowImageView.contentMode = UIViewContentModeRight;
    
    self.lineLabel = [[UILabel alloc] init];
    [self.lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self.bgView addSubview:self.lineLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    
    CGSize periodSize = [self.periodLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(14)]} context:nil].size;
    
    self.bgView.frame = CGRectMake(0, 0, cellWidth, cellHeight-1);
    self.rowImageView.frame = CGRectMake(0, 0, 8, 16);
    self.rowImageView.right = cellWidth - 13.0;
    self.rowImageView.centerY = cellHeight/2.;
    
    self.selectedBtn.frame = CGRectMake(0, 0, 50, cellHeight);
    self.selectedBtn.centerY = cellHeight/2.;
    
    self.periodLabel.frame = CGRectMake(self.selectedBtn.right, AdaptedHeight(8), periodSize.width, AdaptedHeight(20));
    self.overdueStatusLabel.frame = CGRectMake(_periodLabel.right+AdaptedWidth(5), 0, AdaptedWidth(32), AdaptedHeight(16));
    self.overdueStatusLabel.centerY = self.periodLabel.centerY;
    self.loanStatusLabel.frame = CGRectMake(_periodLabel.right+AdaptedWidth(5), 0, AdaptedWidth(100), AdaptedHeight(17));
    self.loanStatusLabel.centerY = self.periodLabel.centerY;
    
    self.restitutionTimeLabel.frame = CGRectMake(self.selectedBtn.right, _periodLabel.bottom, cellWidth-self.selectedBtn.right, AdaptedHeight(17));
    self.loanAmountLabel.frame = CGRectMake(0, 0, AdaptedWidth(100), cellHeight);
    self.loanAmountLabel.right = self.rowImageView.left - 13.0;
    self.loanAmountLabel.centerY = cellHeight/2.;
    
    self.lineLabel.frame = CGRectMake(0.0, cellHeight-1.0, cellWidth, 1.0);
    
    if (_mallBillModel.status == 0) {
        // 未还账单
        self.selectedBtn.hidden = NO;
        self.periodLabel.left = _selectedBtn.right;
        self.restitutionTimeLabel.left = _selectedBtn.right;
        // 逾期
        if (_mallBillModel.overdueStatus == 1) {
            self.overdueStatusLabel.hidden = NO;
        } else {
            self.overdueStatusLabel.hidden = YES;
        }
    } else {
        // 已还账单
        self.selectedBtn.hidden = YES;
        self.periodLabel.left = 12.0;
        self.restitutionTimeLabel.left = 12.0;
    }
    
    if (_mallBillModel.status == 2) {
        self.loanStatusLabel.hidden = NO;
    } else {
        self.loanStatusLabel.hidden = YES;
    }
    
    self.overdueStatusLabel.left = self.periodLabel.right+AdaptedWidth(5);
    self.loanStatusLabel.left = self.periodLabel.right+AdaptedWidth(5);
    
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
