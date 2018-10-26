//
//  XNPushTipView.m
//  ChatDemo
//
//  Created by NTalker-zhou on 16/12/20.
//  Copyright © 2016年 NTalker. All rights reserved.
// 自定义推送提示框（demo演示用）

#import "XNPushTipView.h"
#import "AppDelegate.h"



@interface XNPushTipView ()

@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UILabel  *timLabel;
@property (nonatomic, weak) UILabel  *content;


@end

@implementation XNPushTipView

static XNPushTipView *shareXNPushTipView = nil;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
if (!shareXNPushTipView) {
    shareXNPushTipView = [super allocWithZone:zone];
    }
    return shareXNPushTipView;
}
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareXNPushTipView) {
            shareXNPushTipView = [[XNPushTipView alloc]init];
        }
        
    });
    return shareXNPushTipView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6.0;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor clearColor] CGColor];
        
        self.backgroundColor = [UIColor colorWithRed:(244/255.0) green:(244/255.0) blue:(244/255.0) alpha:0.8];
        UIView *topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, pushViewWidth,pushViewTopBackHeight)];
        topBackView.backgroundColor = [UIColor colorWithRed:(244/255.0) green:(244/255.0) blue:(244/255.0) alpha:1.0];
        
        [self addSubview:topBackView];
        // 图标
        CGFloat rightMargin = 16;
        CGFloat topHeight = 8;
        CGFloat imageWidth = 16;
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = NO;
        imageV.image = [UIImage imageNamed:@"app_icon"];
        imageV.layer.cornerRadius = 5;
        [imageV setFrame:CGRectMake(leftMargin,topHeight,imageWidth, imageWidth)];
        //
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 2.0;
        imageV.layer.borderWidth = 1.0;
        imageV.layer.borderColor = [[UIColor clearColor] CGColor];
        
        [topBackView addSubview:imageV];
        self.imageV = imageV;
       //APP名称
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:12];
        titleLabel.text = @"闪到";
        CGFloat titleWidth = pushViewWidth-CGRectGetMaxX(imageV.frame)-rightMargin-40;
        
        [titleLabel setFrame:CGRectMake(CGRectGetMaxX(imageV.frame)+12, topHeight,titleWidth,imageWidth)];
        [topBackView addSubview:titleLabel];
        [titleLabel sizeToFit];
        //时间
        UILabel *timLabel = [[UILabel alloc] init];
        timLabel.font = [UIFont systemFontOfSize:12];
        timLabel.userInteractionEnabled = NO;
        timLabel.textColor = [UIColor blackColor];
        timLabel.text = @"现在";
        timLabel.textColor = [UIColor lightGrayColor];
        [topBackView addSubview:timLabel];
        self.timLabel = timLabel;
        [timLabel setFrame:CGRectMake(pushViewWidth - rightMargin -40, topHeight, 40, imageWidth)];
        //文本内容
        UILabel *content = [[UILabel alloc] init];
        content.numberOfLines = 2;
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:13];
        content.textColor = [UIColor blackColor];
        content.userInteractionEnabled = NO;
        [self addSubview:content];
        self.content = content;
        [content setFrame:CGRectMake(imageWidth, CGRectGetMaxY(topBackView.frame),pushViewWidth-2*(imageWidth),38)];
        
    }
    return self;
}



+ (void)show{
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    XNPushTipView *pushView = [XNPushTipView shareInstance];
    pushView.hidden = NO;
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.window bringSubviewToFront:pushView];

    [UIView animateWithDuration:0.25 animations:^{
        
        pushView.frame = CGRectMake(leftMargin,leftMargin, pushViewWidth, pushViewHeight);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                
                pushView.frame = CGRectMake(leftMargin, -pushViewHeight, pushViewWidth, pushViewHeight);
                
                
            } completion:^(BOOL finished) {
                
                [UIApplication sharedApplication].statusBarHidden = NO;
                pushView.hidden = YES;
                
            }];
            
        });
        
    }];
}
+ (void)hide{
    XNPushTipView *pushView = [XNPushTipView shareInstance];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        pushView.frame = CGRectMake(0, -pushViewHeight, pushViewWidth, pushViewHeight);
        
    } completion:^(BOOL finished) {
        
        [UIApplication sharedApplication].statusBarHidden = NO;
        pushView.hidden = YES;
        
    }];

}
- (void)setModel:(XNPushTipModel *)model
{
    _model = model;
    self.timLabel.text = @"刚刚";
    self.content.text = model.contentString;
}

@end
