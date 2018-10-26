//
//  LSPeriodDetailView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodDetailView.h"
#import "MallBillInfoModel.h"

@interface LSPeriodDetailView ()

/** 应还总额 */
@property (nonatomic, strong) UILabel *returnMoneyLabel;
/** 借款本金 */
@property (nonatomic, strong) UILabel *loanMoneyLabel;
/** 借款利息 */
@property (nonatomic, strong) UILabel *loanInterestLabel;
/** 交易时间 */
@property (nonatomic, strong) UILabel *tradeTimeLabel;
/** 借款编号 */
@property (nonatomic, strong) UILabel *loanNoLabel;
/** 分期期数 */
@property (nonatomic, strong) UILabel *periodLabel;
/** 逾期费用 */
@property (nonatomic, strong) UILabel *overdueCostLabel;

@end

@implementation LSPeriodDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setSubViews];
    }
    return self;
}



#pragma mark - setter
-(void)setBorrowInfoModel:(BorrowInfoModel *)borrowInfoModel{
    _borrowInfoModel = borrowInfoModel;
    if (_borrowInfoModel) {
        self.returnMoneyLabel.text = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_borrowInfoModel.amount]];
        self.loanMoneyLabel.text = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_borrowInfoModel.borrowAmount]];
        self.loanInterestLabel.text = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_borrowInfoModel.interest]];
        self.tradeTimeLabel.text = [NSDate dateStringFromLongDate:_borrowInfoModel.gmtBorrow];
        self.loanNoLabel.text = _borrowInfoModel.borrowNo;
        self.periodLabel.text = [NSString stringWithFormat:@"%ld期", _borrowInfoModel.nper];
        self.overdueCostLabel.text = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:_borrowInfoModel.overdueAmount]];
    }
}
#pragma mark - 点击借款编号
- (void)clickBorrowNoBtn
{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickBorrowNumber)]) {
        [self.delegete clickBorrowNumber];
    }
}


#pragma mark - 设置子视图
- (void)setSubViews
{
    
    CGFloat labelTop = AdaptedHeight(13.0);
    CGFloat labelWidth = [@"应还总额" sizeWithFont:[UIFont systemFontOfSize:AdaptedHeight(12.0)] maxW:MAXFLOAT].width;
    CGFloat width = Main_Screen_Width/2.;
    
    UILabel *leftOneLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedHeight(12.0) alignment:NSTextAlignmentLeft];
    [leftOneLabel setFrame:CGRectMake(12.0, labelTop, labelWidth, AdaptedHeight(15.0))];
    leftOneLabel.text = @"应还总额";
    [self addSubview:leftOneLabel];
    labelTop = leftOneLabel.bottom + AdaptedHeight(9.0);
    self.returnMoneyLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentLeft];
    [self.returnMoneyLabel setFrame:CGRectMake(leftOneLabel.right+12.0, 0.0, width-leftOneLabel.right, AdaptedHeight(18.0))];
    self.returnMoneyLabel.centerY = leftOneLabel.centerY;
    [self addSubview:self.returnMoneyLabel];
    
    UILabel *leftTwoLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedHeight(12.0) alignment:NSTextAlignmentLeft];
    [leftTwoLabel setFrame:CGRectMake(12.0, labelTop, labelWidth, AdaptedHeight(15.0))];
    leftTwoLabel.text = @"借款本金";
    [self addSubview:leftTwoLabel];
    labelTop = leftTwoLabel.bottom + AdaptedHeight(9.0);
    self.loanMoneyLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentLeft];
    [self.loanMoneyLabel setFrame:CGRectMake(leftOneLabel.right+12.0, 0.0, width-leftOneLabel.right, AdaptedHeight(18.0))];
    self.loanMoneyLabel.centerY = leftTwoLabel.centerY;
    [self addSubview:self.loanMoneyLabel];
    
    UILabel *leftThreeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedHeight(12.0) alignment:NSTextAlignmentLeft];
    [leftThreeLabel setFrame:CGRectMake(12.0, labelTop, labelWidth, AdaptedHeight(15.0))];
    leftThreeLabel.text = @"借款利息";
    [self addSubview:leftThreeLabel];
    labelTop = leftThreeLabel.bottom + AdaptedHeight(9.0);
    self.loanInterestLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentLeft];
    [self.loanInterestLabel setFrame:CGRectMake(leftOneLabel.right+12.0, AdaptedHeight(11.0), width-leftOneLabel.right, AdaptedHeight(18.0))];
    self.loanInterestLabel.centerY = leftThreeLabel.centerY;
    [self addSubview:self.loanInterestLabel];
    
    UILabel *leftFourLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedHeight(12.0) alignment:NSTextAlignmentLeft];
    [leftFourLabel setFrame:CGRectMake(12.0, labelTop, labelWidth, AdaptedHeight(15.0))];
    leftFourLabel.text = @"交易时间";
    [self addSubview:leftFourLabel];
    labelTop = leftFourLabel.bottom + AdaptedHeight(9.0);
    self.tradeTimeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentLeft];
    [self.tradeTimeLabel setFrame:CGRectMake(leftOneLabel.right+12.0, AdaptedHeight(11.0), Main_Screen_Width-leftFourLabel.right-12.0, AdaptedHeight(18.0))];
    self.tradeTimeLabel.centerY = leftFourLabel.centerY;
    [self addSubview:self.tradeTimeLabel];
    
    UILabel *leftFiveLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedHeight(12.0) alignment:NSTextAlignmentLeft];
    [leftFiveLabel setFrame:CGRectMake(12.0, labelTop, labelWidth, AdaptedHeight(15.0))];
    leftFiveLabel.text = @"借款编号";
    [self addSubview:leftFiveLabel];
    self.loanNoLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentLeft];
    [self.loanNoLabel setFrame:CGRectMake(leftOneLabel.right+12.0, AdaptedHeight(11.0), Main_Screen_Width-leftFiveLabel.right-12.0, AdaptedHeight(18.0))];
    self.loanNoLabel.centerY = leftFiveLabel.centerY;
    [self addSubview:self.loanNoLabel];
    
    UIImageView *rowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 6.0, 12.0)];
    rowImgView.image = [UIImage imageNamed:@"mine_right_arrow"];
    rowImgView.right = self.width - 18.0;
    rowImgView.centerY = self.loanNoLabel.centerY;
    [self addSubview:rowImgView];
    
    UIButton *borrowNoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [borrowNoBtn setFrame:CGRectMake(0.0, leftFiveLabel.top, self.width, 30)];
    [borrowNoBtn addTarget:self action:@selector(clickBorrowNoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:borrowNoBtn];
    
    UILabel *rightOneLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedHeight(12.0) alignment:NSTextAlignmentLeft];
    [rightOneLabel setFrame:CGRectMake(width+12.0, AdaptedHeight(13.0), labelWidth, AdaptedHeight(15.0))];
    rightOneLabel.text = @"分期期数";
    [self addSubview:rightOneLabel];
    self.periodLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentLeft];
    [self.periodLabel setFrame:CGRectMake(rightOneLabel.right+12.0, AdaptedHeight(11.0), width, AdaptedHeight(18.0))];
    self.periodLabel.centerY = rightOneLabel.centerY;
    [self addSubview:self.periodLabel];
    
    UILabel *rightTwoLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedHeight(12.0) alignment:NSTextAlignmentLeft];
    [rightTwoLabel setFrame:CGRectMake(width+12.0, leftTwoLabel.top, labelWidth, AdaptedHeight(15.0))];
    rightTwoLabel.text = @"逾期费用";
    [self addSubview:rightTwoLabel];
    self.overdueCostLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentLeft];
    [self.overdueCostLabel setFrame:CGRectMake(rightOneLabel.right+12.0, AdaptedHeight(11.0), width, AdaptedHeight(18.0))];
    self.overdueCostLabel.centerY = rightTwoLabel.centerY;
    [self addSubview:self.overdueCostLabel];
}

@end
