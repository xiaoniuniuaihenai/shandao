//
//  ZTMXFCertificationPromptView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationPromptView.h"

@interface ZTMXFCertificationPromptView()

@property (nonatomic, strong)    NSTimer *timer;
@property (nonatomic, strong)    UILabel *secondsLabel;
@property (nonatomic, strong)    UIButton *startButton;

@end


@implementation ZTMXFCertificationPromptView

+ (void)showCertificationPromptViewWithTimerInterval:(NSTimeInterval)timerInterval Success:(Success)success{
    ZTMXFCertificationPromptView *view = [[ZTMXFCertificationPromptView alloc]initWithFrame:CGRectMake(0, 0, KW, KH)];
    view.timerInterval = timerInterval;
    view.success = success;
    [kKeyWindow addSubview:view];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        
        [self addTimer1];
        
    }
    return self;
}

- (void)addTimer1{
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerFunc{
    self.timerInterval --;
    self.secondsLabel.text = [NSString stringWithFormat:@"%d",(int)self.timerInterval];
    if (self.timerInterval < 1) {
        [self.timer invalidate];
        self.timer = nil;
        if (self.success) {
            self.success();
        }
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
}

- (void)setTimerInterval:(NSTimeInterval)timerInterval{
    _timerInterval = timerInterval ;
    self.secondsLabel.text = [NSString stringWithFormat:@"%d",(int)self.timerInterval];
}

- (void)setUpUI{
    self.backgroundColor = UIColor.whiteColor;
    
//    CGFloat topSpacing = X(90);
    UIColor *textColor = [UIColor colorWithHexString:@"333333"];
    /** label */
    UILabel *label = [[UILabel alloc]init];
    label.text = @"人脸识别即将开始";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"333333"];
    label.font = [UIFont systemFontOfSize:X(16)];
    [self addSubview:label];
    /** 倒计时背景框 */
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"prompt_BG_image"];
    [self addSubview:imageView];
    /** 读秒 */
    self.secondsLabel = [[UILabel alloc]init];
    self.secondsLabel.text = [NSString stringWithFormat:@"%f",self.timerInterval];
    self.secondsLabel.textAlignment = NSTextAlignmentCenter;
    self.secondsLabel.textColor = K_2B91F0;
    self.secondsLabel.font = [UIFont systemFontOfSize:X(80)];
    [self addSubview:self.secondsLabel];
    /** 正确的imageView */
    UIImageView *correctImageView = [[UIImageView alloc]init];
    correctImageView.image = [UIImage imageNamed:@"prompt_correct_image"];
    [self addSubview:correctImageView];
    /** 错误的imageView */
    UIImageView *errorImageView = [[UIImageView alloc]init];
    errorImageView.image = [UIImage imageNamed:@"prompt_error_image"];
    [self addSubview:errorImageView];
    //中间灰色的线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = K_BackgroundColor;
    [self addSubview:line];
    /** 共四个label */
    UILabel *label1  = [[UILabel alloc]init];
    label1.text      = @"竖直紧握手机";
    label1.textColor = textColor;
    label1.font      = [UIFont systemFontOfSize:X(15)];
    
    UILabel *label2  = [[UILabel alloc]init];
    label2.text      = @"手机与面部相同高度";
    label2.textColor = textColor;
    label2.font      = [UIFont systemFontOfSize:X(15)];
    
    UILabel *label3  = [[UILabel alloc]init];
    label3.text      = @"不要斜视手机";
    label3.textColor = textColor;
    label3.font      = [UIFont systemFontOfSize:X(14)];
    
    UILabel *label4  = [[UILabel alloc]init];
    label4.text      = @"不要低头  斜靠  卧躺";
    label4.textColor = textColor;
    label4.font      = [UIFont systemFontOfSize:X(14)];
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:label4];
    
    /** 不再提示 */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"不再提示" forState:UIControlStateNormal
     ];
    [button setTitle:@"不再提示" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(bunZaiTiShi) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    /** 马上开始 */
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startButton setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
    [_startButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_startButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateHighlighted];
    [_startButton setBackgroundImage:[UIImage imageWithColor:K_MainColor] forState:UIControlStateNormal];
    _startButton.layer.cornerRadius = 3;
    _startButton.layer.masksToBounds = YES;
    [_startButton setTitle:@"马上开始" forState:UIControlStateNormal];
    [_startButton setTitle:@"马上开始" forState:UIControlStateHighlighted];
    [_startButton addTarget:self action:@selector(startScanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startButton];
    
    label.sd_layout
    .centerXIs(KW/2)
    .topEqualToView(self)
    .widthIs(KW)
    .heightIs(X(100));
    imageView.sd_layout
    .centerXIs(KW/2)
    .widthIs(X(150))
    .heightIs(X(150))
    .topSpaceToView(label, 2);
    
    self.secondsLabel.sd_layout
    .centerXEqualToView(imageView)
    .centerYEqualToView(imageView)
    .widthIs(X(150))
    .heightIs(X(150));
    correctImageView.sd_layout
    .leftSpaceToView(self, X(25))
    .widthIs(X(100))
    .heightIs(X(100))
    .topSpaceToView(imageView, X(50));
    label1.sd_layout
    .leftSpaceToView(correctImageView,X(40))
    .topSpaceToView(imageView, X(90))
    .heightIs(X(17))
    .widthIs(KW);
    label2.sd_layout
    .leftSpaceToView(correctImageView, X(40))
    .topSpaceToView(label1, X(10))
    .heightIs(X(17))
    .widthIs(KW);
    line.sd_layout
    .leftEqualToView(correctImageView)
    .topSpaceToView(correctImageView, X(10))
    .widthIs(KW)
    .heightIs(1);
    errorImageView.sd_layout
    .leftEqualToView(correctImageView)
    .topSpaceToView(line, X(10))
    .widthRatioToView(correctImageView, 1)
    .heightRatioToView(correctImageView, 1);
    label3.sd_layout
    .leftSpaceToView(errorImageView, X(40))
    .topSpaceToView(line, X(40))
    .heightIs(X(17))
    .widthIs(KW);
    label4.sd_layout
    .leftSpaceToView(errorImageView, X(40))
    .topSpaceToView(label3, X(10))
    .heightIs(X(17))
    .widthIs(KW);
    _startButton.sd_layout
    .leftSpaceToView(self, X(20))
    .rightSpaceToView(self, X(20))
    .heightIs(X(45))
    .bottomSpaceToView(self, X(30));
    button.sd_layout
    .centerXEqualToView(_startButton)
    .bottomSpaceToView(_startButton, X(15))
    .heightIs(X(20))
    .widthIs(X(100));
}
- (void)startScanButtonClick{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_smrz_ks" OtherDict:nil];
    [self.timer invalidate];
    self.timer = nil;
    if (self.success) {
        self.success();
    }
    self.userInteractionEnabled = NO;
    _startButton.alpha = .5f;
    [_startButton setTitle:@"设备启动中,请稍后..." forState:UIControlStateNormal];
    [_startButton setTitle:@"设备启动中,请稍后..." forState:UIControlStateHighlighted];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
- (void)bunZaiTiShi{
    if (self.success) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ZTMXFCertificationPromptViewShow"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.timer invalidate];
        self.timer = nil;
        self.success();
    }
    self.userInteractionEnabled = NO;
    _startButton.alpha = .5f;
    [_startButton setTitle:@"设备启动中,请稍后..." forState:UIControlStateNormal];
    [_startButton setTitle:@"设备启动中,请稍后..." forState:UIControlStateHighlighted];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}



@end
