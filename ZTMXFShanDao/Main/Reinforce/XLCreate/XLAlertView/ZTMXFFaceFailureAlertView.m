//
//  ZTMXFFaceFailureAlertView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFFaceFailureAlertView.h"
#import "UILabel+Attribute.h"
@interface ZTMXFFaceFailureAlertView ()

@property (nonatomic, strong)UIButton * whiteView;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UILabel * descLabel;

@property (nonatomic, copy)NSString * countStr;


@property (nonatomic, copy)void(^clickBtn)(void);

@end




@implementation ZTMXFFaceFailureAlertView


+ (void)showWithCountStr:(NSString *)countStr click:(clickHandle)click;
{
    ZTMXFFaceFailureAlertView * alert = [[ZTMXFFaceFailureAlertView alloc] init];
    alert.clickBtn = ^{
        click();
    };
    alert.countStr = countStr;
    [kKeyWindow addSubview:alert];
    [alert show];
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KW, KH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        _whiteView = [UIButton buttonWithType:UIButtonTypeCustom];
        _whiteView.frame = CGRectMake(0, KH, KW, 390 * PX);
        _whiteView.userInteractionEnabled = YES;
        [self addSubview:_whiteView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KW, 45 * PX)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = COLOR_SRT(@"#000000");
        _titleLabel.font = FONT_Regular(16 * PX);
        _titleLabel.text = @"人脸识别失败";
        [_whiteView addSubview:_titleLabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _titleLabel.bottom + 1 * PX, _whiteView.width - 40, 20 * PX)];
        _descLabel.text = @"仅剩3次机会，超限将7天后再试";
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.textColor = COLOR_SRT(@"#333333");
        _descLabel.numberOfLines = 0;
        _descLabel.font = FONT_Regular(16 * PX);
        [_whiteView addSubview:_descLabel];
        
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = COLOR_SRT(@"#F4F4F4");
        [_whiteView addSubview:lineView];
        
        lineView.sd_layout
        .leftSpaceToView(_whiteView, 21)
        .rightSpaceToView(_whiteView, 21)
        .bottomSpaceToView(_whiteView, 191*PX)
        .heightIs(1);
        
        UIImageView * topImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prompt_correct_image"]];
        [_whiteView addSubview:topImg];
        topImg.sd_layout
        .leftSpaceToView(_whiteView, 30)
        .widthIs(62 * PX)
        .heightIs(62 * PX)
        .bottomSpaceToView(lineView, 21 * PX);
        
        UIImageView * bottomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prompt_error_image"]];
        [_whiteView addSubview:bottomImg];
        bottomImg.sd_layout
        .leftEqualToView(topImg)
        .widthIs(62 * PX)
        .heightIs(62 * PX)
        .topSpaceToView(lineView, 21 * PX);
        
        
        UILabel * topLabel = [[UILabel alloc] init];
        topLabel.font = FONT_Regular(14 * PX);
        topLabel.textColor = K_888888;
        [_whiteView addSubview:topLabel];
        
        topLabel.sd_layout
        .centerYEqualToView(topImg)
        .leftSpaceToView(topImg, 40 * PX)
        .rightEqualToView(_whiteView)
        .autoHeightRatio(0);

        topLabel.isAttributedContent = YES;

        NSString * topText  = @"竖直紧握手机\n手机与面部相同高度";
        [topLabel setAttributedText:[self getAttributedString:topText]];
        
        UILabel * bottomLabel = [[UILabel alloc] init];
        bottomLabel.font = FONT_Regular(14 * PX);
        bottomLabel.textColor = K_888888;
        [_whiteView addSubview:bottomLabel];
        
        bottomLabel.sd_layout
        .leftEqualToView(topLabel)
        .centerYEqualToView(bottomImg)
        .rightEqualToView(topLabel)
        .autoHeightRatio(0);
        
        bottomLabel.isAttributedContent = YES;
        
        
        NSString * bottomText  = @"不要斜视手机\n不要低头 斜靠  卧躺";
        [bottomLabel setAttributedText:[self getAttributedString:bottomText]];
        
       UIButton * _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setBtn.frame = CGRectMake(25, _whiteView.height - 66 * PX, _whiteView.width - 50, 44 * PX );
        [_setBtn setTitle:@"再试试" forState:UIControlStateNormal];
        _setBtn.backgroundColor = K_MainColor;
        [_setBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _setBtn.layer.cornerRadius = 3;
        [_whiteView addSubview:_setBtn];
        
    }
    return self;
}
- (void)setCountStr:(NSString *)countStr
{
    _countStr = countStr;
    _descLabel.text = [NSString stringWithFormat:@"仅剩%@次机会，超限将7天后再试", countStr];
    NSString * str = [NSString stringWithFormat:@"%@次", countStr];
    [UILabel attributeWithLabel:_descLabel text:_descLabel.text textColor:@"#333333" attributes:@[str] attributeColors:@[K_MainColor]];
}
- (void)setBtnAction
{
    if (_clickBtn) {
        _clickBtn();
    }
    [self removeFromSuperview];
}

- (void)show
{
    [UIView animateWithDuration:.3f animations:^{
        _whiteView.frame = CGRectMake(0, KH - 390 * PX, KW, 390 * PX);
    }];
}

- (NSAttributedString * )getAttributedString:(NSString *)str
{
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineSpacing:4];//行间距
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, [str length])];
    return attributedStr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
