//
//  ZTMXFCertificationListFooterView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationListFooterView.h"

@implementation ZTMXFCertificationListFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        UIView * whiteView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:whiteView];
        whiteView.backgroundColor = K_BackgroundColor;
        UIButton * promptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [promptBtn setImage:[UIImage imageNamed:@"XL_JX_TiShi"] forState:UIControlStateNormal];
        [promptBtn setTitle:@"" forState:UIControlStateNormal];
        [promptBtn setTitleColor:COLOR_SRT(@"#999999") forState:UIControlStateNormal];
        promptBtn.userInteractionEnabled = NO;
        [self addSubview:promptBtn];
        promptBtn.frame = CGRectMake(23, 13 * PX, 20, 20);
        promptBtn.titleLabel.font = FONT_Regular(14 * PX);
        

        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(46, 9 * PX, KW - 90, 70 * PX)];
        _descLabel.numberOfLines = 0;
        _descLabel.font = FONT_Regular(14 * PX);
        _descLabel.textColor = COLOR_SRT(@"#999999");
        [self addSubview:_descLabel];
        promptBtn.centerY = _descLabel.centerY;

        _submitBtn = [XLButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        [self addSubview:_submitBtn];
        _submitBtn.frame = CGRectMake(22, _descLabel.bottom + 20, KW - 44, 44 * PX);
        _submitBtn.layer.masksToBounds = YES;
    }
    return self;
}



- (void)setAuthTypeStatus:(int)authTypeStatus
{
    _authTypeStatus = authTypeStatus;
    if (authTypeStatus == 0) {
        self.submitBtn.hidden = NO;
        self.submitBtn.userInteractionEnabled = YES;
    }else{
        self.submitBtn.hidden = YES;
        self.submitBtn.userInteractionEnabled = NO;
    }
    switch (authTypeStatus) {
        case 0:
            _descLabel.text = @"认证中的状态会在1分钟左右更新。";
            break;
        case 1:
            _descLabel.text = @"恭喜您消费贷审核通过啦~不再为“钱”这件小事而发愁，闪到助您“钱”路畅通！快去申请吧~";
            break;
        case 2:
            _descLabel.text = @"温馨提示，我们正在拼命加急审核您的消费贷申请，最晚3分钟给出审核结果，不急不急~请耐心等待";
            break;
        case -1:
//            _descLabel.text = @"认证中的状态会在1分钟左右更新，需全部认证项为“已认证”状态才可提交审核。认证疑问可至“我的-服务中心”寻找答案。";

            break;
            
        default:
            break;
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
