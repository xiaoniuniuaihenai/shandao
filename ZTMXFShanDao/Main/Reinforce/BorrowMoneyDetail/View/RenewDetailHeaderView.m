//
//  RenewDetailHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RenewDetailHeaderView.h"
#import "LSRenewDetailModel.h"
#import "LSRepaymentDetailModel.h"
#import "LSBillListModel.h"
#import "NSString+Additions.h"

@interface RenewDetailHeaderView ()

/** title Label */
@property (nonatomic, strong) UILabel *titleLabel;
/** returnBack Button */
@property (nonatomic, strong) UIButton *returnBackButton;

/** renew Amount */
@property (nonatomic, strong) UILabel *renewAmountLabel;
/** renew Status icon */
@property (nonatomic, strong) UIButton *renewStatusIcon;
/** renew Status */
@property (nonatomic, strong) UILabel *renewStatusLabel;
/** renew Dec */
@property (nonatomic, strong) UILabel *renewDecLabel;

@end

@implementation RenewDetailHeaderView

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
    //  背景view
    UIImage *bgImage = [UIImage imageNamed:@"XL_renew_detail_bg"];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = bgImage;
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds = YES;
    bgView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(211.0));
//    [self addSubview:bgView];
    
    //  title
    self.titleLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:17 alignment:NSTextAlignmentCenter];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.frame = CGRectMake(0.0, AdaptedHeight(34), Main_Screen_Width, AdaptedHeight(24));
    [self addSubview:self.titleLabel];
    
    //  返回按钮
    self.returnBackButton = [UIButton setupButtonWithSuperView:self withObject:self action:@selector(returnBackButtonAction)];
    self.returnBackButton.frame = CGRectMake(12.0, CGRectGetMinY(self.titleLabel.frame), 60, CGRectGetHeight(self.titleLabel.frame));
    
    self.renewDecLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
    self.renewDecLabel.font = [UIFont boldSystemFontOfSize:14];
    self.renewDecLabel.frame = CGRectMake(12.0, AdaptedHeight(13.0), Main_Screen_Width - 100.0, AdaptedHeight(20.0));
    [self addSubview:self.renewDecLabel];
    
    //  还款状态
    self.renewStatusLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentRight];
    self.renewStatusLabel.font = [UIFont boldSystemFontOfSize:14];
    self.renewStatusLabel.frame = CGRectMake(Main_Screen_Width - 80.0, CGRectGetMinY(self.renewDecLabel.frame), 60.0, AdaptedHeight(20.0));
    [self addSubview:self.renewStatusLabel];
    
    // 还款状态图标
    self.renewStatusIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.renewStatusIcon setFrame:CGRectMake(self.renewStatusLabel.left - AdaptedHeight(18.0), self.renewStatusLabel.top, 16, 16)];
    self.renewStatusIcon.centerY = self.renewStatusLabel.centerY;
    [self addSubview:self.renewStatusIcon];
    
    // 还款金额
    self.renewAmountLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:28 alignment:NSTextAlignmentLeft];
    self.renewAmountLabel.font = [UIFont boldSystemFontOfSize:28];
    self.renewAmountLabel.frame = CGRectMake(CGRectGetMinX(self.renewDecLabel.frame), CGRectGetMaxY(self.renewDecLabel.frame) + AdaptedHeight(5.0), Main_Screen_Width, AdaptedHeight(50.0));
    [self addSubview:self.renewAmountLabel];
    
}



//  还款详情Header 数据
- (void)setRepaymentDetailModel:(LSRepaymentDetailModel *)repaymentDetailModel{
    if (_repaymentDetailModel != repaymentDetailModel) {
        _repaymentDetailModel = repaymentDetailModel;
    }
    
    self.renewDecLabel.text = @"还款金额（元）";
    self.renewAmountLabel.text = [NSString stringWithFormat:@"%.2f", _repaymentDetailModel.amount];
    self.renewStatusLabel.text = _repaymentDetailModel.statusDesc;
    if (_repaymentDetailModel.status == -1) {
        // 还款失败
        [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_failed"] forState:UIControlStateNormal];
    }else if (_repaymentDetailModel.status == 1){
        // 还款成功
        [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_success"] forState:UIControlStateNormal];
    }else{
        [self.renewStatusIcon setImage:[UIImage imageNamed:@"XL_repay_progress"] forState:UIControlStateNormal];
    }
}
//  设置延期还款详情Header 数据
- (void)setRenewDetailModel:(LSRenewDetailModel *)renewDetailModel{
    if (_renewDetailModel != renewDetailModel) {
        _renewDetailModel = renewDetailModel;
    }
    
    self.renewDecLabel.text = @"续期金额（元）";
    self.renewAmountLabel.text = [NSString stringWithFormat:@"%.2f", _renewDetailModel.renewalPayAmount];
    self.renewStatusLabel.text = _renewDetailModel.statusDesc;
    if ([_renewDetailModel.statusDesc isEqualToString:@"续期失败"]) {
        // 延期还款失败
        [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_failed"] forState:UIControlStateNormal];
    }else if ([_renewDetailModel.statusDesc isEqualToString:@"续期成功"]){
        // 延期还款成功
        [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_success"] forState:UIControlStateNormal];
    }else{
        [self.renewStatusIcon setImage:[UIImage imageNamed:@"XL_repay_progress"] forState:UIControlStateNormal];
    }
}


//  账单详情Header 数据
- (void)setBillDetailModel:(LSBillDetailModel *)billDetailModel{
    _billDetailModel = billDetailModel;
    if (_billDetailModel) {
        self.renewDecLabel.text = @"借款金额";
        self.renewAmountLabel.text = [NSString stringWithFormat:@"%.2f", _billDetailModel.capitalAmount];
        self.renewStatusLabel.text = _billDetailModel.statusDesc;
        CGSize labeSize = [_billDetailModel.statusDesc sizeWithFont:[UIFont systemFontOfSize:14] maxW:SCREEN_WIDTH];
        self.renewStatusLabel.width = labeSize.width;
        self.renewStatusIcon.left = self.renewStatusLabel.left - AdaptedHeight(18.0);
        
        if (_billDetailModel.status == 0) {
            // 未还款
            [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_wait"] forState:UIControlStateNormal];
        } else if (_billDetailModel.status == 1) {
            // 账单已结清
            [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_success"] forState:UIControlStateNormal];
        } else if (_billDetailModel.status == 2){
            // 还款处理中
            [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_process"] forState:UIControlStateNormal];
        } else if (_billDetailModel.status == 4){
            // 账单关闭
            [self.renewStatusIcon setImage:[UIImage imageNamed:@"repay_close"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 点击返回
- (void)returnBackButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(renewDetailHeaderViewClickReturnBack)]) {
        [self.delegate renewDetailHeaderViewClickReturnBack];
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
