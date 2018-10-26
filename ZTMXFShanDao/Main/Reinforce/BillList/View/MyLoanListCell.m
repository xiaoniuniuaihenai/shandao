//
//  MyLoanListCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/9.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MyLoanListCell.h"
#import "LSBillListModel.h"

@interface MyLoanListCell ()

/**
 cell 类型
 */
//@property (nonatomic, assign) LSLoanListCellType loanCellType;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *statusImgView;

@property (nonatomic, strong) UILabel *loanTypeLabel;

@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, strong) UILabel *restitutionTimeLabel;

@property (nonatomic, strong) UILabel *loanAmountLabel;

@property (nonatomic, strong) UIImageView *rowImageView;

@property (nonatomic, strong) UILabel *loanStatusLabel;

@end

@implementation MyLoanListCell




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(LSLoanListCellType)cellType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        self.loanCellType = cellType;
        [self setupViews];
    }
    return self;
}

- (void)setLoanCellType:(LSLoanListCellType)loanCellType{
    _loanCellType = loanCellType;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView Type:(LSLoanListCellType)loanCellType
{
    static NSString *ID = @"MyLoanListCell";
    MyLoanListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MyLoanListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID type:loanCellType];
    }
    return cell;
}


#pragma mark -
-(void)setBillListModel:(LSBillListModel *)billListModel{
    _billListModel = billListModel;
    if (_billListModel) {
        NSString *billName = _billListModel.name;
        CGSize billNameSize = [billName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(18)]} context:nil].size;
        self.loanTypeLabel.text = billName;
        self.loanTypeLabel.width = billNameSize.width;
        self.subLabel.text = [NSString stringWithFormat:@"%ld/%ld期",_billListModel.billNper,_billListModel.nper];
        self.subLabel.left = _loanTypeLabel.right+AdaptedWidth(9);
        
        NSString *returnDate = [NSDate dateYMDacrossStringFromLongDate:_billListModel.gmtPlanRepayment];
        self.restitutionTimeLabel.text = [NSString stringWithFormat:@"应还日期  %@",returnDate];
        
        NSString *loanAmountStr = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_billListModel.billAmount]];
        CGSize loanAmountSize = [billName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(20)]} context:nil].size;
        self.loanAmountLabel.text = loanAmountStr;
        self.loanAmountLabel.width = loanAmountSize.width;
        
        if (self.loanCellType == LSLoanHistoryType) {
            self.loanStatusLabel.text = _billListModel.statusDesc;
        }
    }
}

#pragma mark - 私有方法
#pragma mark - 点击选中按钮
- (void)clickSelectedBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delegete && [self.delegete respondsToSelector:@selector(selectedCellButtonClick:)]) {
        [self.delegete selectedCellButtonClick:self.billListModel];
    }
}

- (void)setupViews{
    
    self.bgView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_WHITE_STR];
    
    //  借款类型
    self.statusImgView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.bgView];
    self.statusImgView.contentMode = UIViewContentModeScaleAspectFit;
    // 选中按钮
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
    [self.selectedBtn addTarget:self action:@selector(clickSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.selectedBtn];
    
    self.loanTypeLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:AdaptedWidth(18) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.loanTypeLabel];
    
    self.subLabel = [UILabel labelWithTitleColorStr:@"9B9B9B" fontSize:AdaptedWidth(13) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.subLabel];
    
    self.restitutionTimeLabel = [UILabel labelWithTitleColorStr:@"9B9B9B" fontSize:AdaptedWidth(13) alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.restitutionTimeLabel];
    
    self.loanAmountLabel = [UILabel labelWithTitleColorStr:@"151515" fontSize:AdaptedWidth(20) alignment:NSTextAlignmentRight];
    [self.bgView addSubview:self.loanAmountLabel];
    
    // 借款状态
    self.loanStatusLabel = [UILabel labelWithTitleColorStr:@"9B9B9B" fontSize:AdaptedWidth(13) alignment:NSTextAlignmentRight];
    [self.bgView addSubview:self.loanStatusLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.bgView];
    self.rowImageView.contentMode = UIViewContentModeRight;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    
    self.bgView.frame = CGRectMake(0, 0, cellWidth, cellHeight-1);
    self.rowImageView.frame = CGRectMake(0, 0, 8, 16);
    self.rowImageView.right = cellWidth - 13.0;
    self.rowImageView.centerY = cellHeight/2.;
    
    self.statusImgView.frame = CGRectMake(0, 0, 50, 37);
    self.selectedBtn.frame = CGRectMake(0, 0, 50, cellHeight);
    self.selectedBtn.centerY = cellHeight/2.;
    
    self.loanTypeLabel.frame = CGRectMake(self.selectedBtn.right, AdaptedHeight(11), AdaptedWidth(60), AdaptedHeight(25));
    self.subLabel.frame = CGRectMake(_loanTypeLabel.right+AdaptedWidth(9), 0, AdaptedWidth(40), AdaptedHeight(18));
    self.subLabel.centerY = self.loanTypeLabel.centerY;
    self.restitutionTimeLabel.frame = CGRectMake(self.selectedBtn.right, _loanTypeLabel.bottom+AdaptedHeight(5), AdaptedWidth(150), AdaptedHeight(18));
    self.loanAmountLabel.frame = CGRectMake(0, 0, AdaptedWidth(100), AdaptedHeight(28));
    self.loanAmountLabel.right = self.rowImageView.left - 13.0;
    self.loanAmountLabel.centerY = cellHeight/2.;
    
    self.loanStatusLabel.frame = CGRectMake(0.0, 0.0, AdaptedWidth(100), AdaptedHeight(18));
    
    if (self.loanCellType == LSLoanNotReturnType) {
        // 未还账单
        if (_billListModel.overdueStatus == 1) {
            // 逾期
            self.statusImgView.hidden = NO;
            self.statusImgView.image = [UIImage imageNamed:@"overdueStatus"];
        }
        self.selectedBtn.hidden = NO;
        self.loanStatusLabel.hidden = YES;
        self.loanTypeLabel.left = _selectedBtn.right;
        self.restitutionTimeLabel.left = _selectedBtn.right;
        self.loanAmountLabel.centerY = cellHeight/2.;

    }else if (self.loanCellType == LSLoanHistoryType){
        self.statusImgView.hidden = YES;
        self.selectedBtn.hidden = YES;
        self.loanStatusLabel.hidden = NO;

        self.loanTypeLabel.left = 12.0;
        self.restitutionTimeLabel.left = 12.0;

        self.loanAmountLabel.top = 12.0;
        self.loanStatusLabel.centerY = self.restitutionTimeLabel.centerY;
        self.loanStatusLabel.right = self.loanAmountLabel.right;
    }
    self.subLabel.left = _loanTypeLabel.right+AdaptedWidth(9);
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
