//
//  ALAIntroduction.m
//  ALAIntroductionView
//
//  Created by Ryan on 2017/8/16.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "ALAIntroduction.h"
#import <UMAnalytics/MobClick.h>

@interface ALATapView : UIView

@property (nonatomic, copy) void(^tapBlock)(void);

@end

@implementation ALATapView

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end

@interface ALAIntroductionView : UIView

@property (nonatomic, strong) NSMutableArray<UIImage *> *images;
@property (nonatomic, strong) NSArray<NSValue *> *frames;

@property (nonatomic, copy) void(^finishedBlock)(void);

@end

@implementation ALAIntroductionView



- (void)commonInit {
    [self displayNextImage];
}
- (instancetype)initWithFrame:(CGRect)frame Images:(NSArray<UIImage *> *)images frames:(NSArray<NSValue *> *)frames {
    self = [super initWithFrame:frame];
    if (self) {
        _images = [images mutableCopy];
        _frames = frames;
        [self commonInit];
    }
    return self;
}
- (void)displayNextImage {
    if (!self.images.count) {
        if (self.finishedBlock) {
            self.finishedBlock();
        }
        return;
    }
    UIImage *image = [self.images firstObject];
    CGRect rect = self.bounds;
    UIButton *button = [self createIntroductionImageButton:image frame:rect];
    [self addSubview:button];
}



- (void)removeSubView {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}
- (void)actionTapImage {
    [self removeSubView];
    if (self.images.count) {
        [self.images removeObjectAtIndex:0];
    }
    [self displayNextImage];
}
- (UIButton *)createIntroductionImageButton:(UIImage *)image frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    button.adjustsImageWhenDisabled = NO;
    [button addTarget:self action:@selector(actionTapImage) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end

@interface ALAIntroduction ()

@property (nonatomic, strong) ALATapView *backgroundView;
@property (nonatomic, strong) ALAIntroductionView *introductionView;

@end

@implementation ALAIntroduction



+ (void)addIntroduction:(ALAIntroductionType)type {
//    if ([ALAIntroduction needShowIntroduction:type]) {
//        return;
//    }
    NSArray *images = [ALAIntroduction introductionImages:type];
    ALAIntroduction *introduction = [[ALAIntroduction alloc] init];
    [introduction showIntroductionView:images];
    
    NSString *key = [ALAIntroduction introductionKey:type];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //  开始停留在教程页面
    [MobClick beginLogPageView:@"ALAIntroductionView"];
}
+ (NSArray *)introductionImages:(ALAIntroductionType)type {
    NSArray *images = nil;
    switch (type) {
        case ALAIntroductionTypeAlipayOffline:
            images = @[[UIImage imageNamed:@"alipay_course1"],[UIImage imageNamed:@"alipay_course2"],[UIImage imageNamed:@"alipay_course3"],[UIImage imageNamed:@"alipay_course4"],[UIImage imageNamed:@"alipay_course5"],[UIImage imageNamed:@"alipay_course6"],[UIImage imageNamed:@"alipay_course7"]];
            break;
        default:
            break;
    }
    return images;
}
- (void)showIntroductionView:(NSArray<UIImage *> *)images {
    [self showIntroductionView:images frames:nil];
}

- (void)dealloc{
    //  开始停留在教程页面
    [MobClick endLogPageView:@"ALAIntroductionView"];
}

- (void)showIntroductionView:(NSArray<UIImage *> *)images frames:(NSArray<NSValue *> *)frames {
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIView *inView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    ALATapView *backgroundView = [[ALATapView alloc] initWithFrame:frame];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.784];//#C8000000
    backgroundView.tapBlock = ^{
        [self dismiss];
    };
    self.backgroundView = backgroundView;
    
    ALAIntroductionView *introductionView = [[ALAIntroductionView alloc] initWithFrame:frame Images:images frames:frames];
    introductionView.finishedBlock = ^{
        [self dismiss];
    };
    self.introductionView = introductionView;
    
    [inView addSubview:backgroundView];
    [inView addSubview:introductionView];
}

- (void)dismiss {
    [self.introductionView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
}

#pragma mark - private methods

+ (NSString *)introductionKey:(ALAIntroductionType)type {
    return [[NSString alloc] initWithFormat:@"ALAIntroduction_%lu",(unsigned long)type];
}

+ (BOOL)needShowIntroduction:(ALAIntroductionType)type {
    NSString *key = [ALAIntroduction introductionKey:type];
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
