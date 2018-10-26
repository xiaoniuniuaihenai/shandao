//
//  LSBasicsBottomView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/10/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LSStopCountdownBlock)();

@interface LSBasicsBottomView : UIView

/**认证中*/
@property (weak, nonatomic) IBOutlet UILabel *lbTitleLb;

/** 时间*/
@property (weak, nonatomic) IBOutlet UIView *viTimeView;
@property (weak, nonatomic) IBOutlet UIButton *btnOneTime;
@property (weak, nonatomic) IBOutlet UIButton *btnTwoTime;
@property (weak, nonatomic) IBOutlet UIButton *btnThreeTime;
@property (weak, nonatomic) IBOutlet UIButton *btnFourTime;

@property (weak, nonatomic) IBOutlet UILabel *lbPromptOne;
@property (weak, nonatomic) IBOutlet UILabel *lbPromptTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnRightIconBtn;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmitBtn;

/**
 倒计时

 @param timer 倒计时时长
 @param riskStatus 审核状态
 @param stopTimerBlock 倒计时结束
 */
-(void)updateTimer:(CGFloat)timer riskStatus:(NSInteger)riskStatus stopTimerBlock:(LSStopCountdownBlock)stopTimerBlock ;
@end
