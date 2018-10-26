//
//  LSBasicsBottomView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBasicsBottomView.h"
#import "NSObject+GCDDate.h"
@interface LSBasicsBottomView()
{
    dispatch_source_t _timer;
}
@end
@implementation LSBasicsBottomView
-(void)dealloc{
    if (_timer) {
        dispatch_source_cancel(_timer);
        NSLog(@"倒计时 销毁-===");
    }
    NSLog(@"慢必赔提示 销毁-===");
}


-(void)updateTimer:(CGFloat)timer riskStatus:(NSInteger)riskStatus stopTimerBlock:(LSStopCountdownBlock)stopTimerBlock  {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
//    审核中  显示倒计时
    if(timer>0&&riskStatus==2){
        _viTimeView.hidden = NO;
        _lbTitleLb.text = @"认证中";
        _btnRightIconBtn.selected = NO;

        _lbTitleLb.textColor = [UIColor colorWithHexString:@"333333"];
        NSInteger timeout = ceil(timer);
        _timer = [NSObject queryGCDWithTimeout:timeout handleChangeCountdownBlock:^(NSInteger minutes, NSInteger seconds, NSString *changeTime) {
            NSInteger oneDate   = 0;
            NSInteger twoDate   = 0;
            NSInteger threeDate = 0;
            NSInteger fourDate  = 0;
            //        分钟
            if (minutes>9) {
                oneDate = minutes/10;
                NSString * twoDateStr = [NSString stringWithFormat:@"%ld",minutes];
                twoDate = [[twoDateStr substringFromIndex:twoDateStr.length-1]integerValue];
            }else{
                twoDate = minutes;
            }
            if (seconds>9) {
                threeDate = seconds/10;
                NSString * fourDateStr = [NSString stringWithFormat:@"%ld",seconds];
                fourDate = [[fourDateStr substringFromIndex:fourDateStr.length-1]integerValue];
                
            }else{
                fourDate = seconds;
            }
            NSString * oneStr = [NSString stringWithFormat:@"%ld",oneDate];
            NSString * twoStr = [NSString stringWithFormat:@"%ld",twoDate];
            NSString * threeStr = [NSString stringWithFormat:@"%ld",threeDate];
            NSString * fourStr = [NSString stringWithFormat:@"%ld",fourDate];
            [_btnOneTime setTitle:oneStr forState:UIControlStateNormal];
            [_btnTwoTime setTitle:twoStr forState:UIControlStateNormal];
            [_btnThreeTime setTitle:threeStr forState:UIControlStateNormal];
            [_btnFourTime setTitle:fourStr forState:UIControlStateNormal];
            
        } handleStopCountdownBlock:^(NSInteger minutes, NSInteger seconds, NSString *stopTime) {
            _viTimeView.hidden = YES;
            stopTimerBlock();
        }];
    }else{
        _viTimeView.hidden = YES;
        
//        if (riskStatus==0) {
//            未认证
            NSString * strOne = @"认证";
            NSString * strTwo = @"慢必赔";
            _lbTitleLb.textColor = [UIColor colorWithHexString:@"333333"];
            strOne = [NSString stringWithFormat:@"%@%@",strOne,strTwo];
            NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:strOne];
            [att addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ed8546"] range:[strOne rangeOfString:strTwo]];
            _lbTitleLb.attributedText = att;
            _btnRightIconBtn.selected = NO;

//        }else{
////            审核中
//            _btnRightIconBtn.selected = YES;
//            _lbTitleLb.textColor = [UIColor colorWithHexString:@"ed8546"];
//            _lbTitleLb.text = @"认证中···";
//        }

    }
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [_btnOneTime.layer setCornerRadius:5];
    [_btnTwoTime.layer setCornerRadius:5];
    [_btnThreeTime.layer setCornerRadius:5];
    [_btnFourTime.layer setCornerRadius:5];
    [self.layer setCornerRadius:5];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = _btnOneTime.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHexString:@"f7b989"] CGColor],(id)[[UIColor colorWithHexString:@"ea6f51"] CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0,1);
    [_btnOneTime.layer addSublayer:gradientLayer];
    [_btnTwoTime.layer addSublayer:gradientLayer];
    [_btnThreeTime.layer addSublayer:gradientLayer];
    [_btnFourTime.layer addSublayer:gradientLayer];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
