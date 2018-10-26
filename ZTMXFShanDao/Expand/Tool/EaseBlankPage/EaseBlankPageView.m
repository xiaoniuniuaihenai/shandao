//
//  EaseBlankPageView.m
//  Blossom
//  空白页展示


#import "EaseBlankPageView.h"

@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_monkeyView) {
        _monkeyView = [[UIImageView alloc] init];
        [self addSubview:_monkeyView];
        
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = FONT_Regular(12 * PX);
        _tipLabel.textColor = COLOR_SRT(@"#9B9B9B");
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    //    布局
    [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_top).with.offset(140);
        make.height.mas_equalTo(157);
        make.width.mas_equalTo(155);

    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_monkeyView.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    _reloadButtonBlock = nil;
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
//        [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
        _reloadButton.backgroundColor = K_MainColor;
        [_reloadButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
//        _reloadButton.adjustsImageWhenHighlighted = YES;
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadButton];
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
//            make.top.equalTo(_tipLabel.mas_bottom);
            make.top.mas_equalTo(_tipLabel.mas_bottom).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(228 * PX, 44 * PX));
        }];
        _reloadButton.layer.cornerRadius = X(22);
        _reloadButton.layer.masksToBounds = YES;
    }
    _reloadButton.hidden = NO;
    _reloadButtonBlock = block;
    
    if (hasError) {
        //        加载失败

        [_monkeyView setImage:[UIImage imageNamed:@"blankpage_image_loadFail"]];
        _tipLabel.text = @"貌似出了点差错";
        
        if (blankPageType==EaseBlankPageTypeMaterialScheduling) {
            _reloadButton.hidden=YES;
        }
        
    }else{
        //        空白数据
        if (_reloadButton) {
            _reloadButton.hidden = NO;
        }
        NSString *imageName, *tipStr;
        switch (blankPageType) {
            case EaseBlankPageTypeProject:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前还未有数据";
            }
                break;
            case EaseBlankPageTypeNoButton:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前还未有数据";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
            case EaseBlankPageTypeNoLoanList:
            {
                imageName = @"NO_laonRecord";
                tipStr = @"您还没有提现记录";
                [_reloadButton setTitle:@"去提现" forState:UIControlStateNormal];
            }
                break;
            case EaseBlankPageTypeNoRepaymentList:
            {
                imageName = @"NO_laonRecord";
                tipStr = @"您还没有还款记录";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
            case EaseBlankPageTypeNoPromoteAmountList:
            {
                imageName = @"NO_laonRecord";
                tipStr = @"您还没有提额足迹";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
            case EaseBlankPageTypeNoCouponList:
            {
                imageName = @"XL_couponList_none";
                tipStr = @"暂无优惠券";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
            case EaseBlankPageTypeNoMsgList:{
                imageName = @"nullMsg";
                tipStr = @"您还没有收到消息";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }break;
            case EaseBlankPageTypeNoAddressList:{
                imageName = @"NO_Address";
                tipStr = @"您还没有添加地址哦";
                [_reloadButton setTitle:@"添加地址" forState:UIControlStateNormal];
//                if (_reloadButton) {
//                    _reloadButton.hidden = YES;
//                }
            }break;
            case EaseBlankPageTypeNoOrderList:{
                imageName = @"NO_Order";
                tipStr = @"咦！没有订单～";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }break;
            case EaseBlankPageTypeNoBillHistoryList:{
                imageName = @"NO_Order";
                tipStr = @"咦！没有历史账单～";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }break;
            case EaseBlankPageTypeNoBankList:{
                imageName = @"NO_Bank";
                tipStr = @"您还没有绑定银行卡\n没有银行卡不能进行借款和提现操作哦！";
                [_reloadButton setTitle:@"添加银行卡" forState:UIControlStateNormal];

                
            }break;
                
                
            default://其它页面（这里没有提到的页面，都属于其它）
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前还未有数据";
            }
                break;
        }
        [_monkeyView setImage:[UIImage imageNamed:imageName]];
        NSDictionary *dic = @{NSKernAttributeName:@.5f};
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:tipStr attributes:dic];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [paragraphStyle setLineSpacing:5];//行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tipStr length])];
        
        _tipLabel.attributedText = attributedString;

      
//        _tipLabel.text = tipStr;
    }
}

- (void)reloadButtonClicked:(id)sender{
    /** 1.0.0 -1.2.2 */
//    self.hidden = YES;
//    [self removeFromSuperview];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (_reloadButtonBlock) {
//            _reloadButtonBlock(sender);
//        }
//    });
    /** 134修改 */
    if (_reloadButtonBlock) {
        _reloadButtonBlock(sender);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperview];
    });
    
}
@end
