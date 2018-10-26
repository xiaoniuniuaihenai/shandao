//
//  LSLoanDetailHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanDetailHeaderView.h"
#import "LSLoanDetailModel.h"
#import "HWTitleButton.h"
#import "UIButton+Attribute.h"

@interface LSLoanDetailHeaderView ()


/** 还款金额 */
@property (nonatomic, strong) UILabel *repaymentAmountLabel;
/** 借款状态描述 */
@property (nonatomic, strong) UILabel *loanStateDescribeLabel;


@property (nonatomic, strong)UIButton * topBtn;


/** topView */
@property (nonatomic, strong) UIView *topView;

/** 显示还款按钮的背景view */
@property (nonatomic, strong) UIView *showRepaymentView;
@property (nonatomic, strong) UILabel *amountTopLabel;

/** 还款金额描述 */
@property (nonatomic, strong) UILabel *repaymentAmountDescribeLabel;
/** 还款下面的按钮 */
@property (nonatomic, strong) UIButton *repaymentBottomButton;

/** 不显示还款按钮的背景view */
@property (nonatomic, strong) UIView *hiddenRepaymentView;
@property (nonatomic, strong) UIImageView *loanIconImageView;
/** 借款状态 */
@property (nonatomic, strong) UILabel *loanStateLabel;

/** 借款按钮 */
@property (nonatomic, strong) HWTitleButton *loanStateBottomButton;

@end

@implementation LSLoanDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

//  添加子视图
- (void)setupViews{
    
    _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtn.frame = CGRectMake(0, 27 * PX, KW, 30 * PX);
    _topBtn.userInteractionEnabled = NO;
    [_topBtn setTitleColor:K_333333 forState:UIControlStateNormal];
    _topBtn.titleLabel.font  =FONT_Regular(15 * PX);
    [self addSubview:_topBtn];
    
    
    /** 还款金额 */
    self.repaymentAmountLabel = [[UILabel alloc] init];
    _repaymentAmountLabel.textAlignment = NSTextAlignmentCenter;
    self.repaymentAmountLabel.text = @"";
    self.repaymentAmountLabel.font = FONT_Medium(36 * PX);
    _repaymentAmountLabel.frame = CGRectMake(0, _topBtn.bottom + 5, KW, 50 * PX);
    [self addSubview:self.repaymentAmountLabel];
    
    
    /** 还款金额描述 */
    self.repaymentAmountDescribeLabel = [[UILabel alloc] init];
    _repaymentAmountDescribeLabel.textAlignment = NSTextAlignmentCenter;
    _repaymentAmountDescribeLabel.textColor = K_666666;
    _repaymentAmountDescribeLabel.numberOfLines = 0;
    _repaymentAmountDescribeLabel.font = FONT_Regular(14 * PX);
    self.repaymentAmountDescribeLabel.text = @"";
    [self addSubview:self.repaymentAmountDescribeLabel];
    _repaymentAmountDescribeLabel.frame = CGRectMake(50 * PX,_repaymentAmountLabel.bottom + 14 * PX, (KW - 100 * PX), 20 * PX);
//    _repaymentAmountDescribeLabel.sd_layout
//    .leftSpaceToView(self, 50 * PX)
//    .topSpaceToView(_repaymentAmountLabel, 14 * PX)
//    .rightSpaceToView(self, 50 * PX)
//    .autoHeightRatio(0);
    
    _repaymentBottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_repaymentBottomButton setTitleColor:K_333333 forState:UIControlStateNormal];
    _repaymentBottomButton.titleLabel.font  =FONT_Regular(12 * PX);
    [_repaymentBottomButton addTarget:self action:@selector(repaymentBottomButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [UIButton attributeWithBUtton:_repaymentBottomButton title:@"周转不开？试试续借 点此尝试" titleColor:@"888888" forState:UIControlStateNormal attributes:@[@"点此尝试"] attributeColors:@[K_2B91F0]];
    [self addSubview:self.repaymentBottomButton];
    
    _repaymentBottomButton.frame = CGRectMake(60, _repaymentAmountDescribeLabel.bottom + 5, KW - 120, 30 * PX);
    self.height = _repaymentBottomButton.bottom + 35 * PX;

//    _repaymentBottomButton.sd_layout
//    .leftSpaceToView(self, 60)
//    .rightSpaceToView(self, 60)
//    .topSpaceToView(_repaymentAmountDescribeLabel, 5)
//    .heightIs(30 * PX);
//
    

}



#pragma mark - 按钮点击事件
//  马上还款
- (void)repaymentButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(boneDetailHeaderViewClickRepayment)]) {
        [self.delegate boneDetailHeaderViewClickRepayment];
    }
}

//  马上还款下面按钮点击事件
- (void)repaymentBottomButtonAction{
    /** 逾期状态(0没有逾期, 1表示逾期) */
    /** 借款状态【0:申请/未审核,1:已结清,2:打款中,3:打款失败,4:关闭,5:已经打款/待还款,6:还款中 */
    /** 是否显示续期入口【1.显示（申请延期还款）；0不显示；2显示（延期还款处理中） */
    NSInteger renewalStatus = self.loanDetailModel.renewalStatus;
    if (renewalStatus == 1) {
        //  延期还款按钮
        if (self.delegate && [self.delegate respondsToSelector:@selector(boneDetailHeaderViewClickRenew)]) {
            [self.delegate boneDetailHeaderViewClickRenew];
        }
    }
}

//  借款状态下面的按钮点击事件
- (void)boneStateBottomButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(boneDetailHeaderViewClickPromoteAmount)]) {
        [self.delegate boneDetailHeaderViewClickPromoteAmount];
    }
}



- (void)setLoanDetailModel:(LSLoanDetailModel *)loanDetailModel{
    if (_loanDetailModel != loanDetailModel) {
        _loanDetailModel = loanDetailModel;
        
        if (!kStringIsEmpty(_loanDetailModel.statusDesc)) {
//            self.loanStateLabel.text = _loanDetailModel.statusDesc;
            [_topBtn setTitle:[NSString stringWithFormat:@"  %@", _loanDetailModel.statusDesc] forState:UIControlStateNormal];
        }
        if (!kStringIsEmpty(_loanDetailModel.remindInfo)) {
            self.repaymentAmountDescribeLabel.text = _loanDetailModel.remindInfo;

        }else{
            self.repaymentAmountDescribeLabel.text = @"";
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:FONT_Regular(14 * PX) forKey:NSFontAttributeName];
        CGSize size = [self.repaymentAmountDescribeLabel.text boundingRectWithSize:CGSizeMake((KW - 100 * PX), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        _repaymentAmountDescribeLabel.height = size.height;
        _repaymentBottomButton.frame = CGRectMake(60, _repaymentAmountDescribeLabel.bottom + 5, KW - 120, 30 * PX);
        self.height = _repaymentBottomButton.bottom + 15 * PX;
        //  剩余应还
        self.repaymentAmountLabel.text = [NSString stringWithFormat:@"%.2f", _loanDetailModel.returnAmount];

        /** 【0:申请/未审核,1:已结清（已结清）,2:打款中,3:打款失败,4:关闭,5:已经打款/待还款,6:还款中7已逾期*/
        NSInteger loanState = _loanDetailModel.status;
        NSString * imgStr = @"";
        if (loanState == 0) {
            //  借钱申请中
            imgStr = @"XL_Loan_xq_ChuLiZhong";
        } else if (loanState == 1) {
            //  已经清
            imgStr = @"XL_Loan_xq_ChengGong";
        } else if (loanState == 2) {
            //  打款中
            imgStr = @"XL_Loan_xq_ChuLiZhong";

        } else if (loanState == 3) {
            //  打款失败
            imgStr = @"XL_Loan_xq_GuanBi";

        } else if (loanState == 4) {
            //  借款关闭
            imgStr = @"XL_Loan_xq_GuanBi";

        } else if (loanState == 5) {
            //  待还款
            imgStr = @"XL_Loan_xq_dengdai";

        } else if (loanState == 6) {
            //  还款中
            imgStr = @"XL_Loan_xq_ChuLiZhong";
        } else if (loanState == 7) {
            //  逾期
            imgStr = @"XL_Loan_xq_dengdai";
        }
        [_topBtn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        /** 是否显示续期入口【1.显示（申请延期还款）；0不显示；2显示（延期还款处理中） */
        NSInteger renewalStatus = self.loanDetailModel.renewalStatus;
        self.repaymentBottomButton.hidden = YES;
        self.repaymentBottomButton.userInteractionEnabled = NO;
        if (renewalStatus == 1) {
            //  显示延期还款按钮
            self.repaymentBottomButton.hidden = NO;
            self.repaymentBottomButton.userInteractionEnabled = YES;

        } else if (renewalStatus == 2) {
            self.repaymentBottomButton.hidden = NO;
            [UIButton attributeWithBUtton:_repaymentBottomButton title:@"延期还款处理中" titleColor:@"888888" forState:UIControlStateNormal attributes:@[@"延期还款处理中"] attributeColors:@[K_2B91F0]];

        } else {
        }
    }
    
  
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
