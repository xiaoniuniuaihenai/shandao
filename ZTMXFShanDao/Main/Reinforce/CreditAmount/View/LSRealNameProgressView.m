//
//  LSRealNameProgressView.m
//  ZTMXFXunMiaoiOS
//
//  Created by Try on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  68 244


#import "LSRealNameProgressView.h"
#import "LSProgressView.h"
@interface LSRealNameProgressView()
@property (nonatomic,strong) LSProgressView * progressView;
@property (nonatomic,strong) NSMutableArray * arrBtnArr;
@property (nonatomic,strong) NSMutableArray * arrTitleArr;
@property (nonatomic,strong) NSMutableArray *arrProgressArr;

@end
@implementation LSRealNameProgressView
-(instancetype)initWithProgress{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
        NSArray * arrTitle = @[@"身份认证",@"颜值校验",@"绑定银行卡"];
        _arrBtnArr = [[NSMutableArray alloc]init];
        _arrTitleArr = [[NSMutableArray alloc]init];
        _arrProgressArr = [[NSMutableArray alloc] init];
        [self addSubview:self.progressView];
        for (int i=0; i<3; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(0, AdaptedWidth(12), AdaptedWidth(32),AdaptedWidth(32))];
            [btn setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
            btn.centerX = _progressView.left+i*_progressView.width/2.;
            _progressView.centerY = btn.centerY;
            NSString * titleStr = [NSString stringWithFormat:@"%d",i+1];
            [btn setTitle:titleStr forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            NSString * idNStr = [NSString stringWithFormat:@"idfPgN%d",i];
            NSString * idHStr = [NSString stringWithFormat:@"idfPgH%d",i];
            [btn setImage:[UIImage imageNamed:idNStr] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:idHStr] forState:UIControlStateSelected];
            [self addSubview:btn];
            
            NSString * pStr = arrTitle[i];
            UILabel * lbTitle = [[UILabel alloc]init];
            [lbTitle setFont:[UIFont systemFontOfSize:AdaptedWidth(12)]];
            lbTitle.textColor = [UIColor colorWithHexString:@"727272"];
            lbTitle.top = btn.bottom+AdaptedWidth(12);
            lbTitle.text = pStr;
            [lbTitle sizeToFit];
            lbTitle.centerX = btn.centerX;
            [self addSubview:lbTitle];
            
            UIButton *progressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [progressBtn setFrame:CGRectMake(btn.right + AdaptedWidth(13), 0, AdaptedWidth(31),AdaptedWidth(13))];
            [progressBtn setImage:[UIImage imageNamed:@"progress_gray"] forState:UIControlStateNormal];
            [progressBtn setImage:[UIImage imageNamed:@"progress"] forState:UIControlStateSelected];
            progressBtn.centerY = btn.centerY;
            progressBtn.left = btn.right + AdaptedWidth(26);
            [self addSubview:progressBtn];
            if (i==2) {
                progressBtn.hidden = YES;
            }
            
            [_arrBtnArr addObject:btn];
            [_arrTitleArr addObject:lbTitle];
            [_arrProgressArr addObject:progressBtn];
        }
    }
    return self;
}

-(LSProgressView*)progressView{
    if (!_progressView) {
        CGRect rect = CGRectMake(0, 0,Main_Screen_Width-AdaptedWidth(71)*2, 1);
        _progressView = [[LSProgressView alloc]initWithFrame:rect];
        [_progressView setBackgroundColor:[UIColor clearColor]];
//        [_progressView setProgressTintColor:[UIColor colorWithHexString:@"e56647"]];
//        [_progressView setTrackTintColor:[UIColor colorWithHexString:@"d9d9d9"]];
  }
    return _progressView;
}
#pragma mark -- 进度
-(void)updateProgressViewFloatValue:(CGFloat)pgValue{
//    [_progressView setProgress:pgValue animated:NO];
    UIButton * btnOne = _arrBtnArr[0];
    UIButton * btnTwo = _arrBtnArr[1];
    UIButton * btnThree = _arrBtnArr[2];
    UILabel * lbTitleOne = _arrTitleArr[0];
    UILabel * lbTitleTwo = _arrTitleArr[1];
    UILabel * lbTitleThree = _arrTitleArr[2];
    UIButton *progressOne = _arrProgressArr[0];
    UIButton *progressTwo = _arrProgressArr[1];
    lbTitleOne.textColor = [UIColor colorWithHexString:@"e56647"];
    lbTitleTwo.textColor = [UIColor colorWithHexString:@"727272"];
    lbTitleThree.textColor = [UIColor colorWithHexString:@"727272"];

    btnOne.selected = YES;
    btnTwo.selected = NO;
    btnThree.selected = NO;
    progressOne.selected = NO;
    progressTwo.selected = NO;
    if (pgValue==.5) {
        btnTwo.selected = YES;
        lbTitleTwo.textColor = [UIColor colorWithHexString:@"e56647"];
        progressOne.selected = YES;
    }else if(pgValue==1){
        btnTwo.selected = YES;
        btnThree.selected = YES;
        lbTitleTwo.textColor = [UIColor colorWithHexString:@"e56647"];
        lbTitleThree.textColor = [UIColor colorWithHexString:@"e56647"];
        progressOne.selected = YES;
        progressTwo.selected = YES;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _progressView.centerX = self.width/2.;
    for (int i = 0; i < _arrBtnArr.count; i++) {
        UIButton * btn = _arrBtnArr[i];
        UILabel * lbPrompt = _arrTitleArr[i];
        UIButton *progressBtn = _arrProgressArr[i];
        btn.centerX = _progressView.left+i*_progressView.width/2.;
        progressBtn.left = btn.right + AdaptedWidth(26);
        lbPrompt.centerX = btn.centerX;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
