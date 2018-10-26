//
//  GoodsDetailBottomView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "GoodsDetailBottomView.h"
#import "UILabel+Attribute.h"

@interface GoodsDetailBottomView ()

/** lineView */
@property (nonatomic, strong) UIView      *lineView;
/** 购买按钮 */
@property (nonatomic, strong) UIButton    *purchaseButton;
/** 月供 */
@property (nonatomic, strong) UILabel     *monthPayLabel;

@end

@implementation GoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.purchaseButton];
    [self addSubview:self.monthPayLabel];
    [self addSubview:self.lineView];
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

- (UILabel *)monthPayLabel{
    if (_monthPayLabel == nil) {
        _monthPayLabel = [[UILabel alloc] init];
        _monthPayLabel.textColor = [UIColor colorWithHexString:@"232323"];
        _monthPayLabel.font = [UIFont systemFontOfSize:14];
        _monthPayLabel.lineBreakMode = 0;
        if ([LoginManager appReviewState]) {
            _monthPayLabel.hidden = YES;
        }
    }
    return _monthPayLabel;
}

- (UIButton *)purchaseButton{
    if (_purchaseButton == nil) {
        _purchaseButton = [UIButton setupButtonWithSuperView:self withTitle:@"立即购买" titleFont:17 corner:0 withObject:self action:@selector(submitPurchaseButtonAction)];
        _purchaseButton.backgroundColor = K_MainColor;
        [_purchaseButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
    }
    return _purchaseButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.purchaseButton.frame = CGRectMake(viewWidth - 160.0, 0.0, 160.0, viewHeight);
    self.monthPayLabel.frame = CGRectMake(16.0, 0.0, viewWidth - 180.0, viewHeight);
    self.lineView.frame = CGRectMake(0.0, 0.0, viewWidth, 0.5);
}

//  立即购买按钮点击事件
- (void)submitPurchaseButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsDetailBottomViewClickPurchase)]) {
        [self.delegate goodsDetailBottomViewClickPurchase];
    }
}

/** 配置月供 */
- (void)configMonthPay:(NSString *)monthPay{
    if (!kStringIsEmpty(monthPay)) {
        NSString *monthPayStr = [NSString stringWithFormat:@"￥%@", monthPay];
        NSString *payString = [NSString stringWithFormat:@"月供 %@ 起", monthPayStr];
        UIColor *redColor = [UIColor colorWithHexString:COLOR_RED_STR];
        [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributes:@[monthPayStr] attributeColors:@[redColor]];
    }
//    if (!kStringIsEmpty(monthPay)) {
//        NSString *monthPayStr = [NSString stringWithFormat:@"%@元", monthPay];
//        NSString *payString = [NSString stringWithFormat:@"最高减免 %@", monthPayStr];
//        NSArray * arr =[payString componentsSeparatedByString:@"."];
//        NSString * lastStr = arr.count > 1?[arr lastObject]:@"";
//        [UILabel attributeWithLabel:self.monthPayLabel text:payString textColor:COLOR_GRAY_STR attributesOriginalColorStrs:@[monthPayStr] attributeNewColors:@[K_MainColor] textFont:16 * PX attributesOriginalFontStrs:@[lastStr] attributeNewFonts:@[FONT_Regular(12 * PX)]];
    
    
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
