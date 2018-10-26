//
//  LSBaseAuthView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBaseAuthView.h"
#import "LSCreditRowCellView.h"
#import "LSPromoteCreditInfoModel.h"

@interface LSBaseAuthView ()

/** 芝麻信用 */
@property (nonatomic, strong) LSCreditRowCellView *zhiMaCreditView;
/** 手机运营商 */
@property (nonatomic, strong) LSCreditRowCellView *phoneOperationView;

@end

@implementation LSBaseAuthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    // cell frame
    CGFloat viewHeight = AdaptedHeight(60.0);
    NSString * titleColor = @"5c5c5c";
    NSString * valueColor = @"f6a623";
    CGFloat titleFont = 17;
    CGFloat valueFont = 15;

    /** 芝麻信用 */
    self.zhiMaCreditView = [[LSCreditRowCellView alloc]initWithTitle:@"芝麻信用" value:@"未认证" target:self action:@selector(zhiMaCreditViewAction)];
    self.zhiMaCreditView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, viewHeight);
    self.zhiMaCreditView.titleImageStr = @"zhiMaIcon";
    self.zhiMaCreditView.imgLeftSize = AdaptedWidth(30);
    self.zhiMaCreditView.contentMargin = AdaptedWidth(18);
    self.zhiMaCreditView.titleMarginImgLeft = AdaptedWidth(20);
    self.zhiMaCreditView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0, AdaptedWidth(5));
    self.zhiMaCreditView.titleColor =  titleColor;
    self.zhiMaCreditView.valueColor = valueColor;
    self.zhiMaCreditView.titleFontSize = titleFont;
    self.zhiMaCreditView.valueFontSize = valueFont;
    self.zhiMaCreditView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.zhiMaCreditView];
    
    /** 营运商认证 */
    self.phoneOperationView = [[LSCreditRowCellView alloc] initWithTitle:@"手机运营商认证" value:@"未认证" target:self action:@selector(phoneOperationAction)];
    self.phoneOperationView.frame = CGRectMake(0.0, CGRectGetMaxY(self.zhiMaCreditView.frame) , Main_Screen_Width, viewHeight);
    self.phoneOperationView.titleImageStr = @"yunYingShangIcon";
    self.phoneOperationView.imgLeftSize = AdaptedWidth(30);
    self.phoneOperationView.contentMargin = AdaptedWidth(18);
    self.phoneOperationView.titleMarginImgLeft = AdaptedWidth(20);
    self.phoneOperationView.lineEdgeInsets = UIEdgeInsetsMake(0, AdaptedWidth(72), 0.0, AdaptedWidth(5));
    self.phoneOperationView.titleColor =  titleColor;
    self.phoneOperationView.valueColor = valueColor;
    self.phoneOperationView.titleFontSize = titleFont;
    self.phoneOperationView.valueFontSize = valueFont;
    self.phoneOperationView.separatorStyle = LSCreditSeparatorStyleDefault;
    [self addSubview:self.phoneOperationView];
}


#pragma mark - 点击事件


//  运营商认证
- (void)phoneOperationAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseAuthViewClickPhoneOperation)]) {
        [self.delegate baseAuthViewClickPhoneOperation];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewHeight = AdaptedHeight(60.0);
    self.zhiMaCreditView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, viewHeight);
    self.phoneOperationView.frame = CGRectMake(0.0, CGRectGetMaxY(self.zhiMaCreditView.frame) , Main_Screen_Width, viewHeight);
}
//  芝麻信用认证
- (void)zhiMaCreditViewAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseAuthViewClickZhiMaCredit)]) {
        [self.delegate baseAuthViewClickZhiMaCredit];
    }
}



#pragma mark - setter getter
- (void)setConsumeLoanInfoModel:(LSPromoteCreditInfoModel *)consumeLoanInfoModel{
    if (_consumeLoanInfoModel != consumeLoanInfoModel) {
        _consumeLoanInfoModel = consumeLoanInfoModel;
    }
    
    if (_consumeLoanInfoModel == nil) {
        self.zhiMaCreditView.valueStr = @"未认证";
        self.phoneOperationView.valueStr = @"未认证";
        self.zhiMaCreditView.titleImageStr = @"zhiMaIcon";
        self.phoneOperationView.titleImageStr = @"yunYingShangIcon";
        self.zhiMaCreditView.valueColor = COLOR_BLUE_STR;
        self.phoneOperationView.valueColor = COLOR_BLUE_STR;
    } else {
        //  芝麻信用
        NSString *zhimaCreditStr = @"";
        if (_consumeLoanInfoModel.zmModel.zmStatus == 1) {
            zhimaCreditStr = [NSString stringWithFormat:@"%ld",(long)_consumeLoanInfoModel.zmModel.zmScore];
            self.zhiMaCreditView.titleImageStr = @"zhiMaIconSelect";
            self.zhiMaCreditView.valueColor = COLOR_ORANGE_STR;
        } else {
            zhimaCreditStr = @"未认证";
            self.zhiMaCreditView.titleImageStr = @"zhiMaIcon";
            self.zhiMaCreditView.valueColor = COLOR_BLUE_STR;
        }
        self.zhiMaCreditView.valueStr = zhimaCreditStr;
        
        // 运营商认证
        NSString *mobileStatusStr = [NSString string];
        if (_consumeLoanInfoModel.mobileStatus == 1) {
            mobileStatusStr = @"已认证";
            self.phoneOperationView.titleImageStr = @"yunYingShangIconSelect";
            self.phoneOperationView.valueColor = COLOR_ORANGE_STR;
        } else if (_consumeLoanInfoModel.mobileStatus == 0) {
            mobileStatusStr = @"未认证";
            self.phoneOperationView.titleImageStr = @"yunYingShangIcon";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        }else if (_consumeLoanInfoModel.mobileStatus == -1){
            mobileStatusStr = @"认证失败";
            self.phoneOperationView.titleImageStr = @"yunYingShangIcon";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        } else  if (_consumeLoanInfoModel.mobileStatus == 2) {
            mobileStatusStr = @"认证中";
            self.phoneOperationView.titleImageStr = @"yunYingShangIcon";
            self.phoneOperationView.valueColor = COLOR_BLUE_STR;
        }
        self.phoneOperationView.valueStr = mobileStatusStr;
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
