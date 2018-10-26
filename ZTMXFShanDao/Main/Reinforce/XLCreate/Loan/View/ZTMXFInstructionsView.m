//
//  ZTMXFInstructionsView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFInstructionsView.h"

@interface ZTMXFInstructionsView ()

@property (nonatomic, strong)UIImageView * imgView;

@property (nonatomic, strong)UILabel * textLabel;

@end


@implementation ZTMXFInstructionsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"XL_JX_TiShi"]];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = FONT_Regular(14 * PX);
        _textLabel.textColor = COLOR_SRT(@"999999");
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
//        _textLabel.backgroundColor = DEBUG_COLOR;
//        _imgView.sd_layout
//        .leftSpaceToView(self, 17)
//        .topSpaceToView(self, 35 * PY)
//        .widthIs(12)
//        .heightIs(12);
        
//        _textLabel.sd_layout
//        .leftSpaceToView(_imgView, 12)
//        .rightSpaceToView(self, 20)
//        .topSpaceToView(self, 29 * PY)
//        .autoHeightRatio(0);
        
        _textLabel.sd_layout
        .leftSpaceToView(self, 40)
        .centerYEqualToView(self)
        .rightSpaceToView(self, 20)
        .autoHeightRatio(0);
        
        _imgView.sd_layout
        .leftSpaceToView(self, 17)
        .topEqualToView(_textLabel)
        .widthIs(12)
        .heightIs(18);
        
        
    }
    return self;
}


- (void)setTextString:(NSString *)textString
{
    _textString = [textString copy];
    _textLabel.text = _textString;
   
}

- (void)setAttributedTextString:(NSString *)attributedTextString
{
    _attributedTextString = [attributedTextString copy];
    _textLabel.attributedText = _attributedTextString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
