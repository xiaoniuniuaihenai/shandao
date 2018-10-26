//
//  TextLoopView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFTextLoopView.h"

@interface ZTMXFTextLoopView ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) NSTimer *myTimer;

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger nextIndex;

@end
@implementation ZTMXFTextLoopView

#pragma mark - 初始化方法
+ (instancetype)textLoopViewWith:(NSArray *)dataSource loopInterval:(NSTimeInterval)timeInterval initWithFrame:(CGRect)frame{
    ZTMXFTextLoopView *loopView = [[ZTMXFTextLoopView alloc] initWithFrame:frame];
    loopView.dataSource = dataSource;
    loopView.interval = timeInterval ? timeInterval : 1.0;
    loopView.clipsToBounds = YES;
    return loopView;
}

#pragma mark - priviate method

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupViews];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
- (void)setInterval:(NSTimeInterval)interval {
    _interval = interval;
    // 定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timer) userInfo:nil repeats:YES];
    _myTimer = timer;
}
#pragma mark ---
-(void)tapGestureRecognizer{
    self.userInteractionEnabled = NO;
    if ([_delegate respondsToSelector:@selector(textLoopViewClickWithIndex:)]) {
        [_delegate textLoopViewClickWithIndex:_currentIndex];
    }
    self.userInteractionEnabled = YES;
}
#pragma mark ----
- (void)setupViews{
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
}

- (UILabel *)firstLabel{
    if (_firstLabel == nil) {
        _firstLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _firstLabel.numberOfLines = 1;
    }
    return _firstLabel;
}

- (UILabel *)secondLabel{
    if (_secondLabel == nil) {
        _secondLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _secondLabel.numberOfLines = 1;
    }
    return _secondLabel;
}


- (void)timer {
    if (_dataSource.count > 0) {

        CGFloat viewWidth = self.bounds.size.width;
        CGFloat viewHeight = self.bounds.size.height;
        
        self.currentIndex ++;
        
        [UIView animateWithDuration:1.0 animations:^{
            CGFloat firstLabelY = self.firstLabel.origin.y;
            if (firstLabelY == 0) {
                self.firstLabel.frame = CGRectMake(0.0, -viewHeight, viewWidth, viewHeight);
                self.secondLabel.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
            } else {
                self.secondLabel.frame = CGRectMake(0.0, -viewHeight, viewWidth, viewHeight);
                self.firstLabel.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
            }
        } completion:^(BOOL finished) {
            
            if (self.currentIndex >= _dataSource.count&&_dataSource.count!=0) {
                self.currentIndex = _dataSource.count-1;
            }
            
            CGFloat firstLabelY = self.firstLabel.origin.y;
            if (firstLabelY == -viewHeight) {
                self.firstLabel.frame = CGRectMake(0.0, viewHeight, viewWidth, viewHeight);
                if (self.currentIndex >= 0 && self.currentIndex < _dataSource.count) {
                    self.firstLabel.text = _dataSource[self.currentIndex];
                } else {
                    self.firstLabel.text = @"";
                    self.currentIndex = 0;
                }
            } else {
                self.secondLabel.frame = CGRectMake(0.0, viewHeight, viewWidth, viewHeight);
                if (self.currentIndex >= 0 && self.currentIndex < _dataSource.count) {
                    self.secondLabel.text = _dataSource[self.currentIndex];
                } else {
                    self.secondLabel.text = @"";
                    self.currentIndex = 0;
                }
            }

        }];
    }
}

- (void)configTextLoopArray:(NSArray *)textArray{
    if (textArray.count > 0) {
        _dataSource = textArray;
        if (_dataSource.count > 1) {
            self.firstLabel.text = _dataSource[0];
            self.secondLabel.text = _dataSource[1];
        } else {
            self.firstLabel.text = _dataSource[0];
            self.secondLabel.text = _dataSource[0];
        }
    }
}

- (void)configLabelText{
    if (self.dataSource.count > 0) {
        
        CGFloat viewWidth = self.bounds.size.width;
        CGFloat viewHeight = self.bounds.size.height;

        CGFloat firstLabelY = self.firstLabel.origin.y;
        if (firstLabelY == 0) {
            self.firstLabel.frame = CGRectMake(0.0, viewHeight, viewWidth, viewHeight);
        } else {
            self.secondLabel.frame = CGRectMake(0.0, viewHeight, viewWidth, viewHeight);
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    self.firstLabel.frame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    self.secondLabel.frame = CGRectMake(0.0, viewHeight, viewWidth, viewHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
