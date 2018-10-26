//
//  ZTMXFThirdCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFThirdCell.h"
#import "ZTMXFInstructionsView.h"
#import "UILabel+Attribute.h"
#import "LoanModel.h"
#import "UIButton+Attribute.h"
#import "UIViewController+Visible.h"
#import "LSWebViewController.h"
#import "UIButton+JKImagePosition.h"

@interface ZTMXFThirdCell ()

@property (nonatomic, strong)UILabel * amountLabel;

@property (nonatomic, strong)UIButton * maxTextBtn;

@property (nonatomic, strong)UILabel * messageLabel;

@property (nonatomic, strong)ZTMXFInstructionsView * instructionsView;

@property (nonatomic, strong)UIButton * marketBtn;

@property (nonatomic, strong)UILabel  *statusLabel;
@property (nonatomic, strong)UIButton  *statusDetailButton;

@property (nonatomic, strong)UIView *messageBottomLine;

@end


@implementation ZTMXFThirdCell

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
        [self addSubview:_statusDetailButton];
        
        UIView *levelView = [[UIView alloc]init];
        levelView.backgroundColor = K_BackgroundColor;
        [self addSubview:levelView];
        
        _maxTextBtn = [UIButton new];
//        [_maxTextBtn setTitle:@"" forState:UIControlStateNormal];
//        [_maxTextBtn setTitleColor:COLOR_SRT(@"#666666") forState:UIControlStateNormal];
        [_maxTextBtn setTitleColor:K_GoldenColor forState:UIControlStateNormal];

        _maxTextBtn.titleLabel.font = FONT_Regular(18 *  PX);
        [_maxTextBtn setImage:[UIImage imageNamed:@"XL_JQ_ShaLou"] forState:UIControlStateNormal];
        
        _amountLabel = [UILabel new];
        _amountLabel.font = FONT_Medium(48 * PY);
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        
        _messageLabel = [UILabel new];
        _messageLabel.font = FONT_Regular(14 * PY);
        _messageLabel.textColor = COLOR_SRT(@"#666666");
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
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
        
        [self.contentView addSubview:_maxTextBtn];
        [self.contentView addSubview:_amountLabel];
        [self.contentView addSubview:_messageLabel];

        self.instructionsView = [[ZTMXFInstructionsView alloc] initWithFrame:CGRectMake(0, 0, KW - X(64), 108 * PX)];
//        [self.contentView addSubview:_instructionsView];
        
        
        _marketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_marketBtn addTarget:self action:@selector(thirdCellmarketBtnBtnActino) forControlEvents:UIControlEventTouchUpInside];
        _marketBtn.titleLabel.font = FONT_Regular(14 *PX);
        _marketBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_marketBtn];

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
            make.width.mas_equalTo(@(X(150)));
            make.height.mas_equalTo(@(X(20)));
        }];
        [_statusDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(X(-9));
            make.centerY.mas_equalTo(_statusLabel.mas_centerY);
            make.width.mas_equalTo(@(X(150)));
            make.height.mas_equalTo(@(X(20)));
        }];
        
        [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.centerY.mas_equalTo(_statusLabel.mas_centerY).mas_offset(@(X(21)));
            make.height.mas_equalTo(@1);
        }];
        
        [_maxTextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(X(58)));
            make.width.mas_equalTo(@(X(75)));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(levelView.mas_centerY).mas_offset(@(X(69)));
        }];
        
        [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(_maxTextBtn.mas_centerY).mas_offset(@(X(69)));
            make.height.mas_equalTo(@(X(57)));
        }];
        [jinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_amountLabel.mas_left).mas_offset(@(X(-10)));
            make.centerY.mas_equalTo(_amountLabel.mas_centerY);
            make.width.mas_equalTo(@(X(35)));
            make.height.mas_equalTo(@(X(20)));
        }];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(@(X(32)));
            make.right.mas_equalTo(self.mas_right).mas_offset(@(X(-32)));
            make.top.mas_equalTo(_amountLabel.mas_bottom).mas_offset(@(X(15)));
        }];
        _messageLabel.isAttributedContent = YES;
        
//        _instructionsView.sd_layout
//        .topSpaceToView(_amountLabel, X(30))
//        .leftSpaceToView(self.contentView, X(32))
//        .rightSpaceToView(self.contentView, X(32))
//        .heightIs(108 * PX);
        
        _messageBottomLine = [[UIView alloc]init];
        _messageBottomLine.backgroundColor = K_BackgroundColor;
        [self.contentView addSubview:_messageBottomLine];
        [_messageBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(_messageLabel.mas_bottom).mas_offset(@(X(20)));
            make.height.mas_equalTo(@(1));
        }];
        [_marketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_messageBottomLine.mas_centerX);
            make.top.mas_equalTo(_messageBottomLine.mas_bottom);
            make.width.mas_equalTo(X(200));
            make.height.mas_equalTo(X(44));
        }];
        [_marketBtn setTitleColor:K_2B91F0 forState:UIControlStateNormal];
        [_marketBtn setTitle:@"周转不过来？借贷超市来帮你" forState:UIControlStateNormal];
        [_marketBtn setImage:[UIImage imageNamed:@"XL_loan_blue_row"] forState:UIControlStateNormal];
        [_marketBtn jk_setImagePosition:LXMImagePositionRight spacing:3];
        
    }
    return self;
}




- (void)setLoanModel:(LoanModel *)loanModel
{
    _loanModel = loanModel;
    
    NSString * htmlString = _loanModel.statusInfo.msgTig?:@"";
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    //    [ps setAlignment:NSTextAlignmentCenter];
    [attrStr addAttributes:@{
                             NSFontAttributeName:FONT_Regular(14 * PX), NSParagraphStyleAttributeName:ps} range:NSMakeRange(0, attrStr.length)];
    
    _messageLabel.attributedText = [attrStr copy];
    [_messageLabel sizeToFit];
    if ([_loanModel.canBorrow isEqualToString:@"I"]) {
        [_maxTextBtn setImage:[UIImage imageNamed:@"XL_Loan_CanBorrw_StatusI"] forState:UIControlStateNormal];
        _statusLabel.text = @"打款中";
        _messageBottomLine.hidden = YES;
        NSString * amountStr = [NSString stringWithFormat:@"%@", loanModel.statusInfo.arrivalAmount];
        _amountLabel.text = amountStr;
        [_statusDetailButton setTitle:@"请耐心等待..." forState:UIControlStateNormal];
//        [UILabel attributeWithLabel:_amountLabel text:amountStr maxFont:50 * PX minFont:28 * PY attributes:@[@"¥",loanModel.statusInfo.arrivalAmount] attributeFonts:@[FONT_LIGHT(28 * PX), FONT_Medium(48 * PX)]];
        self.marketBtn.hidden = YES;
    }else if ([_loanModel.canBorrow isEqualToString:@"T"]) {
        if (_loanModel.statusInfo.renewalStatus == 2 ) {
            [_maxTextBtn setImage:[UIImage imageNamed:@"XL_Loan_CanBorrw_StatusT"] forState:UIControlStateNormal];
            _statusLabel.text = @"延期还款处理中";
            [_statusDetailButton setTitle:@"请耐心等待..." forState:UIControlStateNormal];
            NSString * amountStr = [NSString stringWithFormat:@"%@", loanModel.statusInfo.repayingMoney?:@"0"];
            _amountLabel.text = amountStr;
//            [UILabel attributeWithLabel:_amountLabel text:amountStr maxFont:50 * PX minFont:28 * PX attributes:@[@"¥",loanModel.statusInfo.repayingMoney?:@"0"] attributeFonts:@[FONT_LIGHT(28 * PX), FONT_Medium(48 * PX)]];
        }if (_loanModel.statusInfo.existRepayingMoney == 1) {
            [_maxTextBtn setImage:[UIImage imageNamed:@"XL_Loan_CanBorrw_StatusT"] forState:UIControlStateNormal];
            [_statusDetailButton setTitle:@"请耐心等待..." forState:UIControlStateNormal];
            _statusLabel.text = @"还款处理中";
            NSString * amountStr = [NSString stringWithFormat:@"%@", loanModel.statusInfo.repayingMoney?:@"0"];
            _amountLabel.text = amountStr;
//            [UILabel attributeWithLabel:_amountLabel text:amountStr maxFont:50 * PX minFont:28 * PY attributes:@[@"¥",loanModel.statusInfo.repayingMoney?:@"0"] attributeFonts:@[FONT_LIGHT(28 * PX), FONT_Medium(48 * PX)]];
        }
    }
}

- (void)thirdCellmarketBtnBtnActino
{
    NSString * loanStatus = @"";
    //    【U 未完成认证， N 不可借钱 ，C 可借款， I 打款中，T 待还款】
    if ([_loanModel.canBorrow isEqualToString:@"I"]) {
        loanStatus = @"打款中";
    }else if ([_loanModel.canBorrow isEqualToString:@"U"]) {
        loanStatus = @"未完成认证";
    }else if ([_loanModel.canBorrow isEqualToString:@"N"]) {
        loanStatus = @"不可借钱";
    }else if ([_loanModel.canBorrow isEqualToString:@"C"]) {
        loanStatus = @"可借款";
    }else if ([_loanModel.canBorrow isEqualToString:@"T"]) {
        loanStatus = @"待还款";
    }
    [ZTMXFUMengHelper mqEvent:k_zhouzhuan_click parameter:@{@"loanStatus":loanStatus}];
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(borrowGoods);
    [[UIViewController currentViewController].navigationController pushViewController:webVC animated:YES];
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
