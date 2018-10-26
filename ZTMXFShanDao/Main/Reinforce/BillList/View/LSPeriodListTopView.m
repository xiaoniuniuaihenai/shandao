//
//  LSPeriodListTopView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodListTopView.h"
#import "LSLoanListTopMenu.h"
#import "LSPeriodBillModel.h"

@interface LSPeriodListTopView () <LSLoanListTopMenuDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *descriptLabel;

@property (nonatomic, strong) LSPeriodNoDataView *noDataView;

@property (nonatomic, strong) LSLoanListTopMenu *topMenuView;

@end

@implementation LSPeriodListTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self configueSubViews];
    }
    return self;
}

#pragma mark - LSLoanListTopMenuDelegate


- (void)setTabNum:(NSInteger)tabNum{
    _tabNum = tabNum;
    if (_tabNum == 2) {
        self.topMenuView.menuList = @[@"本期应还",@"剩余应还"];
    } else if (_tabNum == 3) {
        self.topMenuView.menuList = @[@"本期应还",@"剩余应还",@"还款中"];
    }
}
- (void)uploadLoanListDataWithIndex:(NSInteger)index{
    
    NSString *titleStr = @"";
    if (index == 1) {
        // 剩余应还账单
        titleStr = @"剩余应还";
        [self.titleLabel setFrame:CGRectMake(0, AdaptedHeight(27), SCREEN_WIDTH, AdaptedHeight(20))];
        [self.amountLabel setFrame:CGRectMake(0, self.titleLabel.bottom, SCREEN_WIDTH, AdaptedHeight(50))];
        [self.descriptLabel setFrame:CGRectMake(0.0, self.amountLabel.bottom, Main_Screen_Width, AdaptedHeight(20.0))];
    } else{
        titleStr = index == 0 ? @"本期应还" : @"还款处理中";
        [self.titleLabel setFrame:CGRectMake(0, AdaptedHeight(17), SCREEN_WIDTH, AdaptedHeight(20))];
        [self.amountLabel setFrame:CGRectMake(0, self.titleLabel.bottom, SCREEN_WIDTH, AdaptedHeight(50))];
        [self.descriptLabel setFrame:CGRectMake(0.0, self.amountLabel.bottom, Main_Screen_Width, AdaptedHeight(20.0))];
    }
    self.titleLabel.text = titleStr;
    
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickTopMenu:)]) {
        [self.delegete clickTopMenu:index];
    }
}



#pragma mark - setter
- (void)setPeriodBillModel:(LSPeriodBillModel *)periodBillModel{
    _periodBillModel = periodBillModel;

    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:periodBillModel.allAmount];
    self.amountLabel.text = [NSString stringWithFormat:@"%.2f",[decNumber doubleValue]];
    if ([self.titleLabel.text isEqualToString:@"剩余应还"]) {
        self.descriptLabel.text = @"";
    } else {
        self.descriptLabel.text = periodBillModel.desc;
    }
    if (periodBillModel.billList.count == 0) {
        self.noDataView.hidden = NO;
        self.noDataView.titleLabel.text = periodBillModel.desc;
    } else {
        self.noDataView.hidden = YES;
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.topMenuView = [[LSLoanListTopMenu alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, AdaptedHeight(50.0))];
    self.topMenuView.delegate = self;
    [self addSubview:self.topMenuView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.topMenuView.frame), SCREEN_WIDTH, AdaptedHeight(120.0))];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bgView];
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"4A4A4A"] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
    [self.titleLabel setFrame:CGRectMake(0, AdaptedHeight(17), SCREEN_WIDTH, AdaptedHeight(20))];
    self.titleLabel.text = @"本期应还";
    [bgView addSubview:self.titleLabel];
    
    self.amountLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(36) alignment:NSTextAlignmentCenter];
    [self.amountLabel setFrame:CGRectMake(0, self.titleLabel.bottom, SCREEN_WIDTH, AdaptedHeight(50))];
    [self.amountLabel setFont:[UIFont boldSystemFontOfSize:AdaptedWidth(36)]];
    self.amountLabel.text = @"0.00";
    [bgView addSubview:self.amountLabel];
    
    self.descriptLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:AdaptedWidth(14.0) alignment:NSTextAlignmentCenter];
    [self.descriptLabel setFrame:CGRectMake(0.0, self.amountLabel.bottom, Main_Screen_Width, AdaptedHeight(20.0))];
    [bgView addSubview:self.descriptLabel];
    
    [bgView addSubview:self.noDataView];
    self.noDataView.hidden = YES;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(bgView.frame), Main_Screen_Width, AdaptedHeight(10.0))];
    [bottomView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self addSubview:bottomView];
}

- (LSPeriodNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LSPeriodNoDataView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(120.0))];
        _noDataView.periodType = LSPeriodNoMonthDataType;
    }
    return _noDataView;
}

@end
