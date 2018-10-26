//
//  ALABorrowStateView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/21.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ALABorrowStateView.h"
#import "ALATopBottomLabelView.h"
#import "ALATopBottomButtonView.h"
#import "LSLoanDetailModel.h"

@interface ALABorrowStateView ()<ALATopBottomLabelViewDelegate, ALATopBottomButtonViewDelegate>

/** 金额view */
@property (nonatomic, strong) UIView *repayView;
/** 细线 */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ALABorrowStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        //  添加子控件
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    /** 状态 */
    self.stateLabel = [UILabel labelWithTitleColorStr:COLOR_ORANGE_STR fontSize:18 alignment:NSTextAlignmentLeft];
    [self addSubview:self.stateLabel];
    
    /** 状态描述 */
    self.stateDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
    [self addSubview:self.stateDescribeLabel];
    
    /** 间隔view */
    self.gapView = [UIView setupViewWithSuperView:self withBGColor:@"f5f5f5"];

    //  已还金额
    //  等待还款 / 还款逾期 / 已结清 /还款中 这四种状态会有
//    if ([self borrowStateValidate]) {
        /** 还款金额view */
        self.repayView = [UIView setupViewWithSuperView:self withBGColor:COLOR_WHITE_STR];
        
        /** 应还金额 */
        self.shouldRepayView = [[ALATopBottomLabelView alloc] init];
        self.shouldRepayView.backgroundColor = [UIColor whiteColor];
        self.shouldRepayView.topStr = @"剩余应还";
        self.shouldRepayView.bottomStr = @"0.0";
        self.shouldRepayView.topFontSize = 14.0;
        self.shouldRepayView.bottomFontSize = 22.0;
        [self.shouldRepayView setAllTextAlignment:NSTextAlignmentLeft];
        self.shouldRepayView.topTitleColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        self.shouldRepayView.bottomTitleColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        self.shouldRepayView.viewButton.hidden = NO;
        self.shouldRepayView.delegate = self;
        [self.repayView addSubview:self.shouldRepayView];
        
        self.didRepayView = [[ALATopBottomButtonView alloc] initWithTopTitle:@"已还金额" bottomTitle:@"0.00" target:self action:nil];
        self.didRepayView.topTextColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        self.didRepayView.bottomTextColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        self.didRepayView.topFontSize = 14.0;
        self.didRepayView.bottomFontSize = 22.0;
        self.didRepayView.backgroundColor = [UIColor whiteColor];
        [self.didRepayView setAllTextAlignment:NSTextAlignmentLeft];
        self.didRepayView.showRowImageView = YES;
        self.didRepayView.showViewDetailButton = NO;
        self.didRepayView.delegate = self;
        [self.repayView addSubview:self.didRepayView];
        
        self.lineView = [UIView  setupViewWithSuperView:self.repayView withBGColor:@"afafaf"];
//    }

    self.bottomGapView = [UIView setupViewWithSuperView:self withBGColor:@"f5f5f5"];
    
}


//  布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    [self setupViewsFrame];
}

- (void)setupViewsFrame{
    CGFloat leftMargin = 12.0;
    
    self.stateLabel.frame = CGRectMake(leftMargin, 25.0, SCREEN_WIDTH - 2 * leftMargin, 25.0);
    CGFloat stateDescribeLabelH = [self.stateDescribeLabel.text sizeWithFont:self.stateDescribeLabel.font maxW:(SCREEN_WIDTH - 24.0)].height;
    if (stateDescribeLabelH > 20.0) {
        self.stateDescribeLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.stateLabel.frame) + 10.0, SCREEN_WIDTH - 2 * leftMargin, stateDescribeLabelH);
    } else {
        self.stateDescribeLabel.frame = CGRectMake(12.0, CGRectGetMaxY(self.stateLabel.frame) + 10.0, SCREEN_WIDTH - 24.0, 20.0);
    }
    
    self.gapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.stateDescribeLabel.frame) + 20.0, SCREEN_WIDTH, 5.0);
    
    self.viewHeight = CGRectGetMaxY(self.gapView.frame);
    
    self.repayView.frame = CGRectMake(0.0, CGRectGetMaxY(self.gapView.frame), SCREEN_WIDTH, 100.0);
    self.shouldRepayView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH / 2.0, CGRectGetHeight(self.repayView.frame));
    
    self.didRepayView.frame = CGRectMake(CGRectGetMaxX(self.shouldRepayView.frame), CGRectGetMinY(self.shouldRepayView.frame), SCREEN_WIDTH - CGRectGetMaxX(self.shouldRepayView.frame), CGRectGetHeight(self.shouldRepayView.frame));
    
    self.lineView.frame = CGRectMake(CGRectGetMaxX(self.shouldRepayView.frame), CGRectGetMinY(self.shouldRepayView.frame) + 4.0, 0.5, CGRectGetHeight(self.shouldRepayView.frame) - 8.0);
    
    self.bottomGapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.repayView.frame), SCREEN_WIDTH, 5.0);
    //  等待还款 / 还款逾期 / 已结清 /还款中 这四种状态会有
    if ([self borrowStateValidate]) {
        self.height = self.bottomGapView.bottom;
    }else{
        self.height = self.gapView.bottom;
    }

}

- (void)setLoanDetailModel:(LSLoanDetailModel *)loanDetailModel{
    if (_loanDetailModel != loanDetailModel) {
        _loanDetailModel = loanDetailModel;
        
        if (!kStringIsEmpty(_loanDetailModel.statusDesc)) {
            self.stateLabel.text = _loanDetailModel.statusDesc;
        }
        if (!kStringIsEmpty(_loanDetailModel.remindInfo)) {
            self.stateDescribeLabel.text = _loanDetailModel.remindInfo;
        }
        CGFloat stateDescribeLabelH = [self.stateDescribeLabel.text sizeWithFont:self.stateDescribeLabel.font maxW:(SCREEN_WIDTH - 24.0)].height;
        if (stateDescribeLabelH > 20.0) {
            self.stateDescribeLabel.frame = CGRectMake(12.0, CGRectGetMaxY(self.stateLabel.frame) + 10.0, SCREEN_WIDTH - 24.0, stateDescribeLabelH);
        } else {
            self.stateDescribeLabel.frame = CGRectMake(12.0, CGRectGetMaxY(self.stateLabel.frame) + 10.0, SCREEN_WIDTH - 24.0, 20.0);
        }
         //  等待还款 / 还款逾期 / 已结清 /还款中 这四种状态会有
        if ([self borrowStateValidate]) {
            /** 应还金额 */
            CGFloat returnAmount = _loanDetailModel.returnAmount;
            self.shouldRepayView.bottomStr = [NSString stringWithFormat:@"%.2f", returnAmount];
            /** 已还金额 */
            CGFloat paidAmount = _loanDetailModel.paidAmount;
            self.didRepayView.bottomStr = [NSString stringWithFormat:@"%.2f", paidAmount];
        }
        
        /** 延期还款状态 (Y可延期还款，P延期还款中，N不可延期还款) */
        NSInteger renewState = _loanDetailModel.renewalStatus;
        if (renewState == 1) {
            [self.shouldRepayView.viewButton setTitle:@"申请延期还款" forState:UIControlStateNormal];
        } else if (renewState == 2){
            [self.shouldRepayView.viewButton setTitle:@"延期还款申请中" forState:UIControlStateNormal];
        } else if (renewState == 0){
            [self.shouldRepayView.viewButton setTitle:@"" forState:UIControlStateNormal];
        } else {
            [self.shouldRepayView.viewButton setTitle:@"" forState:UIControlStateNormal];
        }
        
        [self setupViewsFrame];
    }
}

//  等待还款 / 还款逾期 / 已结清 /还款中 这四种状态会有
- (BOOL)borrowStateValidate{
    NSInteger state = self.loanDetailModel.status;
    if (state == 5 || self.loanDetailModel.overdueStatus == 1 || state == 1 || state == 6) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - ALATopBottomLabelViewDelegate
- (void)topBottomLabelViewClickButton:(ALATopBottomLabelView *)view{
    if (self.loanDetailModel.renewalStatus == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(borrowStateViewClickContinueBorrow)]) {
            [self.delegate borrowStateViewClickContinueBorrow];
        }
    }
}

#pragma mark - ALATopBottomButtonViewDelegate
- (void)topBottomButtonViewClickViewDetail{
    if (self.delegate && [self.delegate respondsToSelector:@selector(borrowStateViewClickViewDetail)]) {
        [self.delegate borrowStateViewClickViewDetail];
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
