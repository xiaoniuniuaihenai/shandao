//
//  HomePagePopupView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/5/16.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "HomePagePopupView.h"
#import "LSWebViewController.h"

@interface HomePagePopupView ()


@end

@implementation HomePagePopupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  添加子控件
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    /** 蒙版view */
    self.maskBackgroundView = [[UIView alloc] init];
    self.maskBackgroundView.backgroundColor = [UIColor blackColor];
    self.maskBackgroundView.alpha = 0.5;
    self.maskBackgroundView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.maskBackgroundView];
    
    CGFloat adImageViewW = Main_Screen_Width * 270.0 / 375.0;
    CGFloat adImageViewH = Main_Screen_Height * 332.0 / 667.0;
    CGFloat adImageViewX = (Main_Screen_Width - adImageViewW) / 2.0;
    CGFloat adImageViewY = Main_Screen_Height * 148.0 / 667.0;
    self.adImageView = [self setupImageViewWithImageName:@"" withSuperView:self];
    self.adImageView.frame = CGRectMake(adImageViewX, adImageViewY, adImageViewW, adImageViewH);
    self.adImageView.backgroundColor = [UIColor clearColor];
    
    self.adButton = [self setupButtonWithSuperView:self withObject:self action:@selector(clickAdImageView)];
    self.adButton.frame = self.adImageView.frame;
    self.adButton.backgroundColor = [UIColor clearColor];
    
    self.cancelButton = [self setupButtonWithImageStr:@"XL_cancelPopup" title:nil titleColor:[UIColor whiteColor] titleFont:12 withObject:self action:@selector(hiddenView)];
    self.cancelButton.frame = CGRectMake((Main_Screen_Width - 45.0) / 2.0, CGRectGetMaxY(self.adImageView.frame) + 42.5, 45.0, 45.0);
    [self addSubview:self.cancelButton];

}



- (UIButton *)setupButtonWithSuperView:(UIView *)superView withObject:(NSObject *)obj action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (obj && action) {
        [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    button.backgroundColor = [UIColor clearColor];
    [superView addSubview:button];
    return button;
}

- (UIButton *)setupButtonWithImageStr:(NSString *)imageStr title:(NSString *)title titleColor:(UIColor *)color titleFont:(CGFloat)fontSize withObject:(NSObject *)obj action:(SEL)action{
    
    if (!title) {
        title = @"";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (imageStr) {
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (fontSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    } else {
        button.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    if (obj && action) {
        [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
- (UIImageView *)setupImageViewWithImageName:(NSString *)imageName withSuperView:(UIView *)superView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:imageName];
    //  设置图片显示样式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [superView addSubview:imageView];
    return imageView;
}
//  点击图片广告
- (void)clickAdImageView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(homePagePopupViewClickAdImageView)]) {
        [self.delegate homePagePopupViewClickAdImageView];
    }
    [self hiddenViewWithNoAnimation];
}



- (void)hiddenViewWithNoAnimation{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
//  隐藏优惠view
- (void)hiddenView{
    [UIView animateWithDuration:0.28 animations:^{
        self.maskBackgroundView.alpha = 0.0;
        self.adImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}
//  弹出支付类型view
+ (instancetype)popupView{
    HomePagePopupView *popupView = [[HomePagePopupView alloc] init];
    popupView.frame = [UIScreen mainScreen].bounds;
    popupView.backgroundColor = [UIColor clearColor];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:popupView];
    return popupView;
}

- (void)dealloc{
    NSLog(@"popupView释放了");
}

@end
