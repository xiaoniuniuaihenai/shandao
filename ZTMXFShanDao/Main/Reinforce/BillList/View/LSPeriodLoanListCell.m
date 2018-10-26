//
//  LSPeriodLoanListCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodLoanListCell.h"
#import "LSPeriodBillModel.h"
#import "LSBillListModel.h"

@interface LSPeriodLoanListCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *statusImgView;

@property (nonatomic, strong) UILabel *loanTypeLabel;

@property (nonatomic, strong) UILabel *overdueStatusLabel;

@property (nonatomic, strong) UILabel *restitutionTimeLabel;

@property (nonatomic, strong) UILabel *loanAmountLabel;

@property (nonatomic, strong) UILabel *periodLabel;

@property (nonatomic, strong) UIImageView *rowImageView;

@end

@implementation LSPeriodLoanListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView Type:(LSPeriodLoanListCellType)loanCellType
{
    static NSString *ID = @"LSPeriodLoanListCell";
    LSPeriodLoanListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSPeriodLoanListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID type:loanCellType];
    }
    return cell;
}



- (void)setLoanCellType:(LSPeriodLoanListCellType)loanCellType{
    _loanCellType = loanCellType;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(LSPeriodLoanListCellType)cellType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        self.loanCellType = cellType;
        [self setupViews];
    }
    return self;
}
#pragma mark -
-(void)setBillListModel:(PeriodBillListModel *)billListModel{
    _billListModel = billListModel;
    if (_billListModel) {
        self.loanTypeLabel.text = _billListModel.name;
        
        NSString *returnDate = [NSDate dateYMDacrossStringFromLongDate:_billListModel.gmtPlanRepay];
        self.restitutionTimeLabel.text = returnDate;
        
        NSString *loanAmountStr = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_billListModel.amount]];
        self.loanAmountLabel.text = loanAmountStr;
        
        self.periodLabel.text = [NSString stringWithFormat:@"%ld/%ld期",_billListModel.billNper,_billListModel.nper];
        self.periodLabel.left = _loanTypeLabel.right+AdaptedWidth(9);
        
        [self layoutIfNeeded];
    }
}

- (void)setBillModel:(LSBillListModel *)billModel{
    _billModel = billModel;
    if (_billModel) {
        self.loanTypeLabel.text = _billModel.name;
        
        NSString *returnDate = [NSDate dateYMDacrossStringFromLongDate:_billModel.gmtPlanRepayment];
        self.restitutionTimeLabel.text = returnDate;
        
        NSString *loanAmountStr = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_billModel.billAmount]];
        self.loanAmountLabel.text = loanAmountStr;
        
        self.periodLabel.text = [NSString stringWithFormat:@"%ld/%ld期",_billListModel.billNper,_billListModel.nper];
        self.periodLabel.left = _loanTypeLabel.right+AdaptedWidth(9);
        
        [self layoutIfNeeded];
    }
}

#pragma mark - 私有方法
#pragma mark - 点击选中按钮


- (void)setupViews{
    
    self.bgView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_WHITE_STR];
    
    // 选中按钮
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
    [self.selectedBtn addTarget:self action:@selector(clickSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.selectedBtn];
    
    // 账单名称
    self.loanTypeLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:AdaptedWidth(16) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.loanTypeLabel];
    
    // 日期
    self.restitutionTimeLabel = [UILabel labelWithTitleColorStr:@"9B9B9B" fontSize:AdaptedWidth(13) alignment:NSTextAlignmentLeft];
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
    self.loanAmountLabel = [UILabel labelWithTitleColorStr:@"151515" fontSize:AdaptedWidth(20) alignment:NSTextAlignmentRight];
    [self.bgView addSubview:self.loanAmountLabel];
    
    // 借款期数
    self.periodLabel = [UILabel labelWithTitleColorStr:@"9B9B9B" fontSize:AdaptedWidth(13) alignment:NSTextAlignmentRight];
    [self.bgView addSubview:self.periodLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"mine_right_arrow" withSuperView:self.bgView];
    self.rowImageView.contentMode = UIViewContentModeRight;
}
- (void)clickSelectedBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delegete && [self.delegete respondsToSelector:@selector(selectedCellButtonClick:)]) {
        [self.delegete selectedCellButtonClick:self.billListModel];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    
    CGSize dateSize = [self.restitutionTimeLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(13)]} context:nil].size;
    
    self.bgView.frame = CGRectMake(0, 0, cellWidth, cellHeight-1);
    self.rowImageView.frame = CGRectMake(0, 0, 8, 16);
    self.rowImageView.right = cellWidth - 13.0;
    self.rowImageView.centerY = cellHeight/2.;
    
    self.selectedBtn.frame = CGRectMake(0, 0, 50, cellHeight);
    self.selectedBtn.centerY = cellHeight/2.;
    
    self.loanTypeLabel.frame = CGRectMake(self.selectedBtn.right, AdaptedHeight(15), AdaptedWidth(200), AdaptedHeight(22));
    self.restitutionTimeLabel.frame = CGRectMake(self.selectedBtn.right, _loanTypeLabel.bottom+AdaptedHeight(4), dateSize.width, AdaptedHeight(18));
    self.overdueStatusLabel.frame = CGRectMake(_restitutionTimeLabel.right+AdaptedWidth(4), 0, AdaptedWidth(32), AdaptedHeight(16));
    self.overdueStatusLabel.centerY = self.restitutionTimeLabel.centerY;
    self.loanAmountLabel.frame = CGRectMake(0, 0, AdaptedWidth(100), AdaptedHeight(28));
    self.loanAmountLabel.right = self.rowImageView.left - 13.0;
    self.loanAmountLabel.centerY = self.loanTypeLabel.centerY;
    
    self.periodLabel.frame = CGRectMake(0.0, 0.0, AdaptedWidth(100), AdaptedHeight(18));
    self.periodLabel.right = self.loanAmountLabel.right;
    self.periodLabel.centerY = self.restitutionTimeLabel.centerY;
    
    if (self.loanCellType == LSPeriodLoanProgressType) {
        // 还款中账单
        self.selectedBtn.hidden = YES;
        self.periodLabel.hidden = NO;
        self.loanTypeLabel.left = 12.0;
        self.restitutionTimeLabel.left = 12.0;
    } else if (self.loanCellType == LSPeriodLoanHistoryType) {
        // 历史账单
        self.selectedBtn.hidden = YES;
        self.periodLabel.hidden = YES;
        self.loanTypeLabel.left = 12.0;
        self.restitutionTimeLabel.left = 12.0;
        self.loanAmountLabel.centerY = cellHeight/2.;
    } else {
        // 本月应还、剩余待还账单
        self.selectedBtn.hidden = NO;
        self.periodLabel.hidden = NO;
        self.loanTypeLabel.left = _selectedBtn.right;
        self.restitutionTimeLabel.left = _selectedBtn.right;
    }
    if (_billListModel.overdueStatus == 1) {
        // 逾期
        self.overdueStatusLabel.hidden = NO;
    } else {
        self.overdueStatusLabel.hidden = YES;
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
