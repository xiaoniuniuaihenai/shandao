//
//  ZTMXFCertificationHeaderView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationHeaderView.h"
#import "UICountingLabel.h"
#import "LSCreditAuthModel.h"
#import "UILabel+Attribute.h"
@implementation ZTMXFCertificationHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * img = [UIImageView new];
        
//        img.image = [UIImage imageNamed:@"XL_RZ_Top"];
//        img.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:img];
        img.backgroundColor = K_MainColor;
        img.sd_layout
        .leftSpaceToView(self, 15 * PX)
        .rightSpaceToView(self, 15 * PX)
        .topSpaceToView(self, 15 * PX)
        .heightIs(152 * PX);
        
        img.sd_cornerRadius = @5;
        
        NSArray * titles = @[@"授权认证",@"快速审核",@"极速放款"];
        for (int i = 0; i < titles.count; i++) {
            UIView *view = [self viewWithTitle:titles[i]];
            view.frame = CGRectMake(X(22) * (i+1) + X(85) * i, X(113), X(85), X(20));
            [img addSubview:view];
        }

        
        _maxTextLabel = [UILabel new];
        _maxTextLabel.textColor = [UIColor whiteColor];
        _maxTextLabel.font = FONT_Regular(14 * PX);
        [img addSubview:_maxTextLabel];
        
        _maxTextLabel.sd_layout
        .topSpaceToView(img, 20 * PX)
        .leftSpaceToView(img, 20 * PX)
        .rightSpaceToView(img, 20 * PX)
        .heightIs(15 * PX);
        
        _headAmountLabel = [UILabel new];
        [img addSubview:_headAmountLabel];
        
        _headAmountLabel.sd_layout
        .leftEqualToView(_maxTextLabel)
        .heightIs(45 * PX)
        .topSpaceToView(_maxTextLabel, 6 * PX)
        .rightEqualToView(_maxTextLabel);
        
        _headAmountLabel.textColor = [UIColor whiteColor];
        _headAmountLabel.font = FONT_Medium(48 * PX);
        
        
        
//        UIView * garyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 6 * PX, KW, 6 * PX)];
//        garyView.backgroundColor = K_LineColor;
//        [self addSubview:garyView];
        
        
    }
    return self;
}



- (void)setCreditAuthModel:(LSCreditAuthModel *)creditAuthModel{
    if (_creditAuthModel != creditAuthModel) {
        _creditAuthModel = creditAuthModel;
    }
    //  非审核中
    self.maxTextLabel.text = self.creditAuthModel.ballDesc;
    self.headAmountLabel.text = [NSString stringWithFormat:@"%@", self.creditAuthModel.ballNum];
    
//    [UILabel attributeWithLabel:_headAmountLabel text:_headAmountLabel.text textFont:48 * PX attributes:@[@"元"] attributeFonts:@[FONT_Regular(20 * PX)]];
    

}
- (UIView *)viewWithTitle:(NSString *)title{
    UIView *bgView = [[UIView alloc]init];
    
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = UIColor.whiteColor;
    whiteView.layer.cornerRadius = X(2.5);
    whiteView.frame = CGRectMake(0, X(7.5), X(5), X(5));
    [bgView addSubview:whiteView];
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = UIColor.clearColor;
    label.font = FONT_Regular(X(13));
    label.textColor = UIColor.whiteColor;
    label.text = title;
    label.frame = CGRectMake(whiteView.right + X(5), 0, X(60), X(20));
    [bgView addSubview:label];
    return bgView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
