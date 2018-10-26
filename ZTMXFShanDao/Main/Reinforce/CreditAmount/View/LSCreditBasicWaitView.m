//
//  LSCreditBasicWaitView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditBasicWaitView.h"
#import "UIImage+GIF.h"
#import "NSObject+GCDDate.h"
#import "CADisplayLineImageView.h"
@interface LSCreditBasicWaitView ()
{
    dispatch_source_t _timerGcd;
}
@property (nonatomic,strong) CADisplayLineImageView * imgWaitView;
@property (nonatomic,strong) UILabel * lbPromptLb;

@end
@implementation LSCreditBasicWaitView
-(void)dealloc{
    if (_timerGcd) {
        dispatch_source_cancel(_timerGcd);
    }
}

-(void)removeTimer{
    if (_timerGcd) {
        dispatch_source_cancel(_timerGcd);
    }

}

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.imgWaitView];
        [self addSubview:self.lbPromptLb];
    }
    return self;
}

-(CADisplayLineImageView*)imgWaitView{
    if (!_imgWaitView) {
        _imgWaitView = [[CADisplayLineImageView alloc]init];
        [_imgWaitView setFrame:CGRectMake(0, 100, 255 * PX, 184 * PX)];
        _imgWaitView.contentMode = UIViewContentModeScaleAspectFit;
//        _imgWaitView.backgroundColor = DEBUG_COLOR;
        [_imgWaitView setImage:[CADisplayLineImage imageNamed:[@"SH_loading"stringByAppendingString:@".gif"]]];
    }
    return _imgWaitView;
}
-(UILabel *)lbPromptLb{
    if (!_lbPromptLb) {
        _lbPromptLb = [[UILabel alloc]init];
        [_lbPromptLb setFrame:CGRectMake(50,0 , KW - 100, 80)];
        _lbPromptLb.textAlignment = NSTextAlignmentCenter;
        _lbPromptLb.numberOfLines = 0;
        _lbPromptLb.font = FONT_Regular(14);
        _lbPromptLb.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _lbPromptLb.text = @"温馨提示，我们正在拼命加急审核您的消费贷申请，最晚3分钟给出审核结果，不急不急~请耐心等待";
    }
    return _lbPromptLb;
}


-(void)startCountdownWithTimerOut:(NSUInteger)timeOut block:(TimerEndBlock)endBlock{
    if (_timerGcd) {
        dispatch_source_cancel(_timerGcd);
    }
    _timerGcd =  [NSObject queryGCDWithTimeout:timeOut handleChangeCountdownBlock:^(NSInteger minutes, NSInteger seconds, NSString *changeTime) {
        NSLog(@"倒计时---------------- %@",changeTime);
    } handleStopCountdownBlock:^(NSInteger minutes, NSInteger seconds, NSString *stopTime) {
        NSLog(@"倒计时-停止--------------- %@",stopTime);
        endBlock();
    }];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    _imgWaitView.top = 50;
    _imgWaitView.centerX = self.width/2.;
    _lbPromptLb.top = _imgWaitView.bottom+20;
    _lbPromptLb.centerX = self.width/2.;
}


@end
