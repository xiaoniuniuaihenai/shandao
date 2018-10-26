//
//  ZTMXFLoanSecondCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "SDCycleScrollView.h"
#import "ZTMXFLoanSecondCell.h"
//#import "ZTMXFInstructionsView.h"
#import "UILabel+Attribute.h"
#import "UIButton+Attribute.h"
#import "UIButton+JKImagePosition.h"
#import "LoanModel.h"
#import "NSDate+Extension.h"
#import "LSLoanRepayViewController.h"
#import "UIViewController+Visible.h"
#import "LSLoanRenewalViewController.h"

@interface ZTMXFLoanSecondCell ()

@property (nonatomic, strong)UILabel * amountLabel;

@property (nonatomic, strong)UILabel * promptLabel;

@property (nonatomic, strong)UIButton * renewBtn;

@property (nonatomic, strong)UIButton * submitBtn;

//@property (nonatomic, strong)ZTMXFInstructionsView * instructionsView;

@property (nonatomic, strong)UIButton * marketBtn;

@property (nonatomic, strong)UILabel  *statusLabel;
@property (nonatomic, strong)UIButton  *statusDetailButton;
/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView * bottomCycleScrollView;

@end


@implementation ZTMXFLoanSecondCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *topLine = [[UIView alloc]init];
        topLine.backgroundColor = K_BackgroundColor;
        [self addSubview:topLine];
        
        UIView *verticalView = [[UIView alloc]init];
        verticalView.backgroundColor = COLOR_SRT(@"EFEFEF");
        verticalView.layer.cornerRadius = X(1);
        [self addSubview:verticalView];
        
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = FONT_Medium(X(16));
        _statusLabel.textColor = K_333333;
        [self addSubview:_statusLabel];
        
        _statusDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _statusDetailButton.titleLabel.font = FONT_Regular(X(14));
        [_statusDetailButton setTitleColor:K_MainColor forState:UIControlStateNormal];
        [_statusDetailButton setTitleColor:K_MainColor forState:UIControlStateHighlighted];
        _statusDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_statusDetailButton setImage:[UIImage imageNamed:@"XL_Confirm_Loan_YanQi"] forState:UIControlStateHighlighted];
        [_statusDetailButton setImage:[UIImage imageNamed:@"XL_Confirm_Loan_YanQi"] forState:UIControlStateNormal];
        [_statusDetailButton setTitle:@"申请延期还款" forState:UIControlStateHighlighted];
        [_statusDetailButton setTitle:@"申请延期还款" forState:UIControlStateNormal];
        [_statusDetailButton jk_setImagePosition:LXMImagePositionRight spacing:X(5)];
        [_statusDetailButton addTarget:self action:@selector(renewBtnActino) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_statusDetailButton];
        
        UIView *levelView = [[UIView alloc]init];
        levelView.backgroundColor = K_BackgroundColor;
        [self addSubview:levelView];
        
        UILabel *jinELabel = [[UILabel alloc]init];
        jinELabel.text = @"金额";
        jinELabel.textColor = K_888888;
        jinELabel.layer.cornerRadius = 2;
        jinELabel.layer.borderColor = K_888888.CGColor;
        jinELabel.layer.borderWidth = 1;
        jinELabel.layer.masksToBounds = YES;
        jinELabel.font = FONT_Regular(X(14));
        jinELabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:jinELabel];
        
        _amountLabel = [UILabel new];
        _amountLabel.font = FONT_Medium(48 * PX);
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel = [UILabel new];
        _promptLabel.numberOfLines = 0;
        _promptLabel.font = FONT_Regular(14 *PX);
        _renewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_renewBtn addTarget:self action:@selector(renewBtnActino) forControlEvents:UIControlEventTouchUpInside];
        _renewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _renewBtn.titleLabel.font = FONT_Regular(14 * PX);
        
        _marketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_marketBtn addTarget:self action:@selector(marketBtnBtnActino) forControlEvents:UIControlEventTouchUpInside];
        _marketBtn.titleLabel.font = FONT_Regular(14 *PX);
        [_marketBtn setImage:[UIImage imageNamed:@"XL_Confirm_Loan_DaiChao"] forState:UIControlStateHighlighted];
        [_marketBtn setImage:[UIImage imageNamed:@"XL_Confirm_Loan_DaiChao"] forState:UIControlStateNormal];
        [_marketBtn setTitle:@"周转不开,试试其他借款" forState:UIControlStateNormal];
        [_marketBtn setTitle:@"周转不开,试试其他借款" forState:UIControlStateHighlighted];
//        [_marketBtn setTitle:@"周转不开,试试其他借款" forState:UIControlStateNormal];
        [_marketBtn setTitleColor:COLOR_SRT(@"4285E9") forState:UIControlStateHighlighted
         ];
        [_marketBtn setTitleColor:COLOR_SRT(@"4285E9") forState:UIControlStateNormal];
        [_marketBtn jk_setImagePosition:LXMImagePositionRight spacing:X(5)];
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(repayBtnActino) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.titleLabel.font = FONT_Medium(16);
        _submitBtn.backgroundColor = K_MainColor;
        [_submitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = X(22);
        
        UIView *levelView2 = [[UIView alloc]init];
        levelView2.backgroundColor = K_BackgroundColor;
        [self addSubview:levelView2];
        //版本1.2新增
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"EDEFF0"];
        
        UIView *aliBGView = [[UIView alloc]init];
        aliBGView.backgroundColor = [UIColor colorWithHexString:@"EDEFF0"];

        [self.contentView addSubview:_amountLabel];
        [self.contentView addSubview:_promptLabel];
        [self.contentView addSubview:_renewBtn];
        [self.contentView addSubview:_submitBtn];
        [self.contentView addSubview:_marketBtn];
        [self.contentView addSubview:line];
        [self.contentView addSubview:aliBGView];
        
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.height.mas_equalTo(@(X(8)));
        }];
        
        [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(@(X(15)));
            make.top.mas_equalTo(topLine.mas_bottom).mas_offset(@(X(14)));
            make.width.mas_equalTo(@(X(4)));
            make.height.mas_equalTo(@(X(16)));
        }];
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(verticalView.mas_left).mas_offset(X(9));
            make.centerY.mas_equalTo(topLine.mas_bottom).mas_offset(@(X(21)));
            make.width.mas_equalTo(@(X(80)));
            make.height.mas_equalTo(@(X(20)));
        }];
        [_statusDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(X(-15));
            make.centerY.mas_equalTo(_statusLabel.mas_centerY);
            make.width.mas_equalTo(@(X(150)));
            make.height.mas_equalTo(@(X(20)));
        }];
        
        [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.centerY.mas_equalTo(_statusLabel.mas_centerY).mas_offset(@(X(21)));
            make.height.mas_equalTo(@1);
        }];
        [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(levelView.mas_bottom).mas_offset(@(X(40)));
            make.height.mas_equalTo(@(X(57)));
        }];
        
        [jinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_amountLabel.mas_left).mas_offset(@(X(-10)));
            make.centerY.mas_equalTo(_amountLabel.mas_centerY);
            make.width.mas_equalTo(@(X(35)));
            make.height.mas_equalTo(@(X(20)));
        }];
        [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(@(X(32)));
            make.right.mas_equalTo(self.mas_right).mas_offset(@(X(-32)));
            make.top.mas_equalTo(_amountLabel.mas_bottom).mas_offset(@(X(15)));
        }];
        _promptLabel.isAttributedContent = YES;
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_promptLabel.mas_bottom).mas_offset(@(X(15)));
            make.left.mas_equalTo(self.mas_left).mas_offset(@(X(21)));
            make.right.mas_equalTo(self.mas_right).mas_offset(@(X(-21)));
            make.height.mas_equalTo(@(X(44)));
        }];
        [levelView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_submitBtn.mas_bottom).mas_offset(@(X(10)));
            make.left.mas_equalTo(self.mas_left).mas_offset(@(X(15)));
            make.right.mas_equalTo(self.mas_right).mas_offset(@(X(-15)));
            make.height.mas_equalTo(@1);
        }];
        
        [_marketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(levelView2.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(@(X(43)));
        }];
        
        aliBGView.sd_layout
        .topSpaceToView(_marketBtn, 5)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(62);
        
        
        [self.contentView addSubview:self.bottomCycleScrollView];
        self.bottomCycleScrollView.sd_layout
        .topSpaceToView(aliBGView, 15)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(80);
        {
            UIView *whiteBGView = [[UIView alloc]init];
            whiteBGView.backgroundColor = UIColor.whiteColor;
            
            UILabel *aliLabel = [[UILabel alloc]init];
            aliLabel.font = FONT_Regular(14 *PX);
            aliLabel.text = @"我已支付宝还款，点击提交转账订单号";
            aliLabel.textColor = COLOR_SRT(@"4A4A4A");
            
            UIButton *rightArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [rightArrowButton setTitle:@"查看" forState:UIControlStateNormal];
            [rightArrowButton setTitleColor:K_MainColor forState:UIControlStateNormal];
            [rightArrowButton.titleLabel setFont:FONT_Regular(X(14))];
            rightArrowButton.userInteractionEnabled = NO;
            
            UIButton *pushToAliButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [pushToAliButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
            [pushToAliButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
            [pushToAliButton addTarget:self action:@selector(pushToAliIntroduction) forControlEvents:UIControlEventTouchUpInside];
            
            [aliBGView addSubview:whiteBGView];
            [whiteBGView addSubview:aliLabel];
            [whiteBGView addSubview:rightArrowButton];
            [whiteBGView addSubview:pushToAliButton];
            
            whiteBGView.sd_layout
            .leftEqualToView(aliBGView)
            .rightEqualToView(aliBGView)
            .topSpaceToView(aliBGView, 5)
            .bottomSpaceToView(aliBGView, 5);
            
            aliLabel.sd_layout
            .leftSpaceToView(whiteBGView, 18)
            .widthIs(250 * PX)
            .centerYEqualToView(whiteBGView)
            .heightIs(25 * PX);
            
            rightArrowButton.sd_layout
            .rightSpaceToView(whiteBGView, 0)
            .widthIs(60)
            .topEqualToView(whiteBGView)
            .bottomEqualToView(whiteBGView);
            
            pushToAliButton.sd_layout
            .topEqualToView(whiteBGView)
            .bottomEqualToView(whiteBGView)
            .leftEqualToView(whiteBGView)
            .rightEqualToView(whiteBGView);
        }
    }
    return self;
}


- (void)setBotBannerList:(NSArray<BannerList *> *)botBannerList{
    _botBannerList = botBannerList;
    if (_botBannerList && _botBannerList.count > 0) {
        _bottomCycleScrollView.hidden = NO;
        NSLog(@"++++++----------\n%@",_botBannerList[0]);
        NSMutableArray *imgs   = [NSMutableArray new];
        for (int i = 0; i < _botBannerList.count; i ++ ) {
            //            [titles addObject:[_botBannerList[i] titleName]];
            [imgs   addObject:[_botBannerList[i] imageUrl]];
        }
        _bottomCycleScrollView.imageURLStringsGroup = imgs;
    }else{
        _bottomCycleScrollView.hidden = YES;
    }
}

- (void)setStatusInfo:(StatusInfo *)statusInfo
{
    _statusInfo = statusInfo;
    NSString * amountStr = [NSString stringWithFormat:@"%@", _statusInfo.returnAmount];
    _amountLabel.text = amountStr;
//    [UILabel attributeWithLabel:_amountLabel text:amountStr maxFont:50 * PX minFont:28 * PX attributes:@[@"¥",_statusInfo.returnAmount] attributeFonts:@[FONT_LIGHT(28 * PX), FONT_Medium(48 * PX)]];
//    _instructionsView.textString = [_statusInfo.repayTypeDesc componentsJoinedByString:@"\n"];
    if (_statusInfo.overdueStatus == 1) {
        _statusLabel.text = @"已逾期";
    } else {
        _statusLabel.text = @"待还款";
    }
    if (!_statusInfo.renewalStatus) {
        self.statusDetailButton.hidden = YES;
    }else{
        self.statusDetailButton.hidden = NO;
    }
    //  最后判断有没有逾期
    NSString * htmlString = _statusInfo.msgTig;
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [attrStr addAttributes:@{
                                NSFontAttributeName:FONT_Regular(14 * PX), NSParagraphStyleAttributeName:ps} range:NSMakeRange(0, attrStr.length)];
   
    
    _promptLabel.attributedText = attrStr;
    [_promptLabel sizeToFit];
}
- (void)pushToAliIntroduction
{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"click.hq_yjfk" OtherDict:nil];
    LSWebViewController * webVC = [[LSWebViewController alloc] init];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@?borrowMoney=%@&borrowId=%@",BaseHtmlUrl,alipayPayment, _statusInfo.returnAmount, _statusInfo.rid];
    webVC.webUrlStr = urlStr;
    //版本1.3.4新增,目的是获取在页面的持续时间及用户路径统计
    webVC.pageName = @"bs_ym_zfbhk";
    [[UIViewController currentViewController].navigationController pushViewController:webVC animated:YES];
}
/**
 还款btn
 */
- (void)repayBtnActino
{
    [ZTMXFUMengHelper mqEvent:k_Payback_click_xf];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"click.hq_ljhk" OtherDict:nil];
    LSLoanRepayViewController *loanRepayVC = [[LSLoanRepayViewController alloc] init];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:_statusInfo.returnAmount];
    loanRepayVC.repayAmount = [decNumber doubleValue];
    loanRepayVC.borrowId = _statusInfo.rid;
//    loanRepayVC.loanType = CashLoanType;
    if (self.statusInfo.borrowType == 1) {
        loanRepayVC.loanType = CashLoanType;
    } else {
        loanRepayVC.loanType = ConsumeLoanType;
    }
    [[UIViewController currentViewController].navigationController pushViewController:loanRepayVC animated:YES];
}

/** 其他借款方式 */
- (void)marketBtnBtnActino
{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"click.hq_dkcs" OtherDict:nil];
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(borrowGoods);
    [[UIViewController currentViewController].navigationController pushViewController:webVC animated:YES];
    NSString * loanStatus = @"待还款";
    [ZTMXFUMengHelper mqEvent:k_zhouzhuan_click parameter:@{@"loanStatus":loanStatus}];
}


/**
 延期还款btn
 */
- (void)renewBtnActino
{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"hq" PointSubCode:@"click.hq_yqhk" OtherDict:nil];
    LSLoanRenewalViewController *renewalVC = [[LSLoanRenewalViewController alloc] init];
    renewalVC.borrowId = self.statusInfo.rid;
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:_statusInfo.noReturnAmount];
    renewalVC.repaymentAmount = [decNumber doubleValue];
    if (self.statusInfo.borrowType == 1) {
        renewalVC.loanType = CashLoanType;
    } else {
        renewalVC.loanType = ConsumeLoanType;
    }
    [[UIViewController currentViewController].navigationController pushViewController:renewalVC animated:YES];
}

/** 轮播网络图片 */
-(SDCycleScrollView *)bottomCycleScrollView{
    if (!_bottomCycleScrollView) {
        @WeakObj(self);
        _bottomCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, KW, 180 * PX)];
        [_bottomCycleScrollView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _bottomCycleScrollView.autoScrollTimeInterval = 5;
        //设置轮播视图的分页控件的显示
        _bottomCycleScrollView.placeholderImage = [UIImage imageNamed:@"banner_placeholder_180"];
        _bottomCycleScrollView.showPageControl = YES;
        _bottomCycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置轮播视图分也控件的位置
        //        _topCycleScrollView.pageControlBottomOffset = 25 * PX;
        _bottomCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //        _topCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _bottomCycleScrollView.pageControlDotSize = CGSizeMake(8, 3);
        _bottomCycleScrollView.pageDotImage = [UIImage imageNamed:@"XL_first_qiu"];
        _bottomCycleScrollView.currentPageDotImage = [UIImage imageNamed:@"XL_first_qiushi"];
        _bottomCycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            [selfWeak bannerPushToNextPage:currentIndex];
        };
    }
    return _bottomCycleScrollView;
}

- (void)bannerPushToNextPage:(NSInteger)index{
    if ((NSUInteger)index < _botBannerList.count) {
        BannerList * bannerModel = _botBannerList[index];
        if (!bannerModel.titleName) {
            bannerModel.titleName = @"";
        }
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"dcjq" PointSubCode:@"click.dcjq_db" OtherDict:[@{@"picName":_botBannerList[index].titleName,@"overdueDays":_statusInfo.overdueDay} mutableCopy]];
        if (bannerModel.isNeedLogin == 1 && ![LoginManager loginState]) {
            //        需要登录的未登录 弹出登录
            [LoginManager presentLoginVCWithController:[UIViewController currentViewController]];
        }else{
            if ([bannerModel.type isEqualToString:@"H5_URL"]) {
                //    进入H5
                LSWebViewController * webVc = [[LSWebViewController alloc]init];
                // 去除字符串左右空格
                bannerModel.content = [bannerModel.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                webVc.webUrlStr = bannerModel.content;
                [[UIViewController currentViewController].navigationController pushViewController:webVc animated:YES];
            }
        }
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


