//
//  ZTMXFMineTableFooterView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMineTableFooterView.h"
#import "UIViewController+Visible.h"
#import "NTalkerChatViewController.h"
#import "NTalker.h"
#import "UIButton+JKImagePosition.h"

@implementation ZTMXFMineTableFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Xl_Mine_Ad"]];
    imgView.frame = CGRectMake(0, 10, KW, 66 * PX);
    [self addSubview:imgView];
    imgView.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    if (_customerServiceButtonClickBlock) {
//        _customerServiceButtonClickBlock();
//    }
}
- (void)pushTo
{
   
}

@end
