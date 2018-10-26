//
//  ZTMXFCertificationCenterTopView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/7.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationCenterTopView.h"
#import "UIColor+Gradient.h"

@interface ZTMXFCertificationCenterTopView()
@end

@implementation ZTMXFCertificationCenterTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self configUI];
    }
    return self;
}

//- (void)setNumber:(int)number{
//    NSString *str = [NSString stringWithFormat:@"已完成  %d  项认证",number];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
//    [attributedString addAttributes:@{NSFontAttributeName:FONT_Regular(X(48))} range:[str rangeOfString:[NSString stringWithFormat:@"%d",number]]];
//    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (X(16) - X(48))) range:[str rangeOfString:[NSString stringWithFormat:@"%d",number]]];
//    _topLabel.attributedText = attributedString;
//}



- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = FONT_Regular(X(13));
        _topLabel.textColor = UIColor.whiteColor;
        _topLabel.textAlignment = NSTextAlignmentCenter;
//        NSString *str = @"已完成 0 项认证";
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
//        [attributedString addAttributes:@{NSFontAttributeName:FONT_Regular(X(48))} range:[str rangeOfString:@"0"]];
//        [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (X(16) - X(48))) range:[str rangeOfString:@"0"]];
//        _topLabel.attributedText = attributedString;
    }
    return _topLabel;
}
- (void)configUI{
    
    self.backgroundColor = [UIColor gradientFromColor:COLOR_SRT(@"FFD156") toColor:COLOR_SRT(@"FF9233") withWidth:self.frame.size.width];
    [self addSubview:self.topLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(X(25));
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(X(18));
    }];
    _bottomLabel = [[UILabel alloc]init];
    _bottomLabel.textColor = UIColor.whiteColor;
    _bottomLabel.font = FONT_Medium(X(48));
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_bottomLabel];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.topLabel.mas_bottom);
        make.height.mas_equalTo(X(50));
    }];
}
@end
