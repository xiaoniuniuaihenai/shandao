//
//  XLLoanRenewalCenterCell.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/5/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLLoanRenewalCenterCell.h"
#import "ASValueTrackingSlider.h"

@interface XLLoanRenewalCenterCell()
@property (nonatomic, strong) UILabel *reimbursementLabel;
@property (nonatomic, strong) UILabel *delayLabel;
@property (nonatomic, strong) ASValueTrackingSlider *slider;
@end

@implementation XLLoanRenewalCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    UIView *topBGView = [UIView new];
    topBGView.backgroundColor = UIColor.redColor;
    
    //  滑竿
    _slider = [[ASValueTrackingSlider alloc] init];
    _slider.font = [UIFont systemFontOfSize:13];
    _slider.minimumTrackTintColor = K_MainColor;
    _slider.maximumTrackTintColor = COLOR_SRT(@"#F2F2F2");
    [_slider setThumbImage:[UIImage imageNamed:@"renewal_slider_thumb"] forState:UIControlStateNormal];
    _slider.popUpViewColor = [UIColor whiteColor];
    _slider.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
//    _slider.minimumValue = [_minRepaymentCapitalAmount doubleValue];
//    _slider.maximumValue = [_maxRepaymentCapitalAmount doubleValue];
//    _slider.dataSource = self;
    [self addSubview:self.slider];
    
    [self addSubview:topBGView];
    
    topBGView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(120);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
