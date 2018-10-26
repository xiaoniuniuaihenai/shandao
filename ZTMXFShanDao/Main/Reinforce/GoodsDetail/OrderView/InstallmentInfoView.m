//
//  InstallmentInfoView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "InstallmentInfoView.h"
#import "ALATitleValueCellView.h"
#import "GoodsNperInfoModel.h"


@interface InstallmentInfoView ()

/** title */
@property (nonatomic, strong) UILabel *titleLabel;
/** 分期背景view */
@property (nonatomic, strong) UIView *installmentBgView;
/** 细线 */
@property (nonatomic, strong) UIView *lineView;
/** 月供 */
@property (nonatomic, strong) ALATitleValueCellView *monthPayView;
/** 合集需还 */
@property (nonatomic, strong) ALATitleValueCellView *totalPayView;

/** 当前选中按钮 */
@property (nonatomic, strong) UIButton *currentSelectButton;
/** 当前选中分期Model */
@property (nonatomic, strong) GoodsNperInfoModel *currentNperInfoModel;

@property (nonatomic, assign) CGFloat installmentH;

@end

@implementation InstallmentInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
        self.installmentH = AdaptedHeight(105);
    }
    return self;
}

- (void)setupViews{
    /** title */
    [self addSubview:self.titleLabel];
    /** 分期背景view */
    [self addSubview:self.installmentBgView];
    /** 细线 */
    [self addSubview:self.lineView];
    /** 月供 */
    [self addSubview:self.monthPayView];
    /** 合计需还 */
    [self addSubview:self.totalPayView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    /** title */
    self.titleLabel.frame = CGRectMake(AdaptedWidth(14), 0.0, 200, AdaptedHeight(44.0));
    /** 分期背景view */
    self.installmentBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.titleLabel.frame), viewWidth, _installmentH);
    /** 细线 */
    self.lineView.frame = CGRectMake(0.0, CGRectGetMaxY(self.installmentBgView.frame) - 0.5, CGRectGetWidth(self.installmentBgView.frame), 0.5);
    /** 月供 */
    self.monthPayView.frame = CGRectMake(0.0, CGRectGetMaxY(self.installmentBgView.frame), viewWidth, AdaptedHeight(50.0));
    /** 合集需还 */
    self.totalPayView.frame = CGRectMake(0.0, CGRectGetMaxY(self.monthPayView.frame), viewWidth, AdaptedHeight(60.0));
    
    self.height = self.totalPayView.bottom;
}

/** title */
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _titleLabel.text = @"分期期数";
    }
    return _titleLabel;
}
/** 分期背景view */
- (UIView *)installmentBgView
{
    if (_installmentBgView == nil) {
        _installmentBgView = [[UIView alloc] init];
        _installmentBgView.backgroundColor = [UIColor whiteColor];
    }
    return _installmentBgView;
}
/** 细线 */
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

/** 月供 */
- (ALATitleValueCellView *)monthPayView{
    if (_monthPayView == nil) {
        _monthPayView = [[ALATitleValueCellView alloc] initWithTitle:@"月供" value:@"680" target:nil action:nil];
        _monthPayView.backgroundColor = [UIColor whiteColor];
        _monthPayView.titleColorStr = COLOR_GRAY_STR;
        _monthPayView.valueColorStr = COLOR_RED_STR;
        _monthPayView.titleFont = [UIFont systemFontOfSize:14];
        _monthPayView.valueFont = [UIFont systemFontOfSize:14];
        _monthPayView.showRowImageView = NO;
        _monthPayView.showBottomLineView = YES;
    }
    return _monthPayView;
}
/** 合集需还 */
- (ALATitleValueCellView *)totalPayView{
    if (_totalPayView == nil) {
        _totalPayView = [[ALATitleValueCellView alloc] initWithTitle:@"合计需还" value:@"" target:nil action:nil];
        _totalPayView.backgroundColor = [UIColor whiteColor];
        _totalPayView.titleColorStr = COLOR_GRAY_STR;
        _totalPayView.valueColorStr = COLOR_BLACK_STR;
        _totalPayView.titleFont = [UIFont systemFontOfSize:14];
        _totalPayView.valueFont = [UIFont systemFontOfSize:15];
        _totalPayView.showRowImageView = NO;
        _totalPayView.showBottomLineView = NO;
    }
    return _totalPayView;
}

- (void)configInstallmentView{
    if (self.installmentBgView.subviews.count > 0) {
        [self.installmentBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    CGFloat buttonPaddingMargin = 0.0;
    CGFloat buttonRowMargin = AdaptedHeight(16.0);
    CGFloat leftMargin = AdaptedWidth(14.0);
    CGFloat buttonMargin = AdaptedWidth(26.0);
    CGFloat buttonWidth = (Main_Screen_Width - (leftMargin + buttonMargin) * 2) / 3.0;
    CGFloat buttonHeight = AdaptedHeight(34.0);
    for (int i = 0; i < _installmentArray.count; i ++) {
        GoodsNperInfoModel *goodsNperInfoModel = _installmentArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%ld期", goodsNperInfoModel.nper] forState:UIControlStateNormal];
        button.layer.cornerRadius = 3.0;
        button.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
        button.layer.borderWidth = 1.0;
        button.tag = i;
        [button addTarget:self action:@selector(nperButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger row = i / 3;
        NSInteger line = i % 3;
        CGFloat buttonX = leftMargin + (buttonMargin + buttonWidth) * line;
        CGFloat buttonY = buttonPaddingMargin + (buttonHeight + buttonRowMargin) * row;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        [self.installmentBgView addSubview:button];
        
        if (i == (_installmentArray.count - 1)) {
            [self nperButtonAction:button];
            self.installmentH = button.bottom + 10;
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//  分期按钮点击
- (void)nperButtonAction:(UIButton *)sender{
    //  1. 如果有选中按钮, 先设置成不选中状态
    if (self.currentSelectButton) {
        [self setupButtonUnselectState:self.currentSelectButton];
    }
    
    //  2. 设置当前按钮选中状态
    [self setupButtonSelectState:sender];
    
    //  3. 设置该按钮为当前按钮
    self.currentSelectButton = sender;
    
    //  4. 设置当前分期Model
    NSInteger currentIndex = sender.tag;
    if (_installmentArray.count > 0 && currentIndex < _installmentArray.count) {
        self.currentNperInfoModel = _installmentArray[currentIndex];
    }
    
    // 5. 设置分期显示月供, 合集需还信息
    [self setupCurrentNperInfo];
    
    //  触发代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(installmentInfoViewSelectNperInfoModel:)]) {
        if (self.currentNperInfoModel) {
            [self.delegate installmentInfoViewSelectNperInfoModel:self.currentNperInfoModel];
        }
    }
}

//  设置选中状态
- (void)setupButtonSelectState:(UIButton *)sender{
    [sender setTitleColor:K_MainColor forState:UIControlStateNormal];
    sender.layer.borderColor = K_MainColor.CGColor;
}

//  设置非选中状态
- (void)setupButtonUnselectState:(UIButton *)sender{
    [sender setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
    sender.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
}

//  设置分期显示月供, 合集需还信息
- (void)setupCurrentNperInfo{
    if (self.currentNperInfoModel) {
        //  月供
        self.monthPayView.valueStr = [NSString stringWithFormat:@"￥%.2f", self.currentNperInfoModel.monthAmount];
        //  合集需还
        NSString *serviceStr = [NSString stringWithFormat:@"(含服务费￥%.2f)",self.currentNperInfoModel.pdgAmount];
        NSString *allStr = [NSString stringWithFormat:@"￥%.2f\n%@",self.currentNperInfoModel.repayAmount,serviceStr];
        
        NSMutableAttributedString * arrStr = [[NSMutableAttributedString alloc]initWithString:allStr];
        [arrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_GRAY_STR] range:[allStr rangeOfString:serviceStr]];
        [arrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_GRAY_STR],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:[allStr rangeOfString:serviceStr]];
    
        self.totalPayView.valueLabel.attributedText = arrStr;
    }
}

/** 设置分期数据 */
- (void)setInstallmentArray:(NSArray *)installmentArray{
    if (_installmentArray != installmentArray) {
        _installmentArray = installmentArray;
    }
    
    if (_installmentArray.count > 0) {
        [self configInstallmentView];
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
