//
//  YPPickerView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFYPPickerView.h"

#define kBackgroundPickerViewHeight  266.0

@interface ZTMXFYPPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
/** 蒙版 view */
@property (nonatomic, strong) UIView                *maskBackgroundView;
/** 点击蒙版手势 */
@property (nonatomic, strong) UITapGestureRecognizer *tapMaskViewGesture;
/** pickerBackgroundView */
@property (nonatomic, strong) UIView *pickerBgView;
/** title */
@property (nonatomic, strong) UILabel *titleLabel;
/** back button */
@property (nonatomic, strong) UIButton *backButton;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *confirmButton;
/** lineView */
@property (nonatomic, strong) UIView *lineView;
/** UIPickerView */
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation ZTMXFYPPickerView



/** 显示数组 */
+ (void)showPickerViewWithData:(NSArray *)dataArray pickerDelegate:(id)delegate{
    ZTMXFYPPickerView *pickerView = [[ZTMXFYPPickerView alloc] init];
    pickerView.frame = [UIScreen mainScreen].bounds;
    pickerView.backgroundColor = [UIColor clearColor];
    pickerView.pickerDataArray = dataArray;
    pickerView.delegate = delegate;
    [kKeyWindow addSubview:pickerView];

    [pickerView showPickerViewWithAnimation:YES];
    [pickerView pickerView:pickerView.pickerView didSelectRow:0 inComponent:0];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    /** 蒙版 view */
    [self addSubview:self.maskBackgroundView];
    [self.maskBackgroundView addGestureRecognizer:self.tapMaskViewGesture];
    /** pickerBackgroundView */
    [self addSubview:self.pickerBgView];
    /** title */
    [self.pickerBgView addSubview:self.titleLabel];
    /** back button */
    [self.pickerBgView addSubview:self.backButton];
    /** 确认按钮 */
    [self.pickerBgView addSubview:self.confirmButton];
    /** lineView */
    [self.pickerBgView addSubview:self.lineView];
    /** UIPickerView */
    [self.pickerBgView addSubview:self.pickerView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}



//  懒加载手势
- (UITapGestureRecognizer *)tapMaskViewGesture{
    if (_tapMaskViewGesture == nil) {
        _tapMaskViewGesture = [[UITapGestureRecognizer alloc] init];
        [_tapMaskViewGesture addTarget:self action:@selector(backButtonAction)];
    }
    return _tapMaskViewGesture;
}
/** 蒙版 view */
- (UIView *)maskBackgroundView{
    if (_maskBackgroundView == nil) {
        _maskBackgroundView = [[UIView alloc] init];
        _maskBackgroundView.backgroundColor = [UIColor blackColor];
        _maskBackgroundView.alpha = 0.4;
        _maskBackgroundView.frame = [UIScreen mainScreen].bounds;
    }
    return _maskBackgroundView;
}
/** pickerBackgroundView */
- (UIView *)pickerBgView{
    if (_pickerBgView == nil) {
        _pickerBgView = [[UIView alloc] init];
        _pickerBgView.backgroundColor = [UIColor whiteColor];
        _pickerBgView.frame = CGRectMake(0.0, Main_Screen_Height, Main_Screen_Width, kBackgroundPickerViewHeight);
    }
    return _pickerBgView;
}



/** back button */
- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton setupButtonWithImageStr:@"nav_back" title:@"" titleColor:[UIColor whiteColor] titleFont:14 withObject:self action:@selector(backButtonAction)];
        _backButton.frame = CGRectMake(0.0, 0.0, 44.0, CGRectGetHeight(self.titleLabel.frame));
    }
    return _backButton;
}
/** title */
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentCenter];
        _titleLabel.text = @"请选择退款原因";
        _titleLabel.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, 49.0);
    }
    return _titleLabel;
}
/** 确定按钮 */
- (UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(Main_Screen_Width - 60.0, 0.0, 60.0, CGRectGetHeight(self.titleLabel.frame));
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_STR] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
/** lineView */
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _lineView.frame = CGRectMake(0.0, CGRectGetMaxY(self.titleLabel.frame), Main_Screen_Width, 0.5);
    }
    return _lineView;
}
/** UIPickerView */
- (UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.frame = CGRectMake(0.0, CGRectGetMaxY(self.lineView.frame), Main_Screen_Width, 216.0);
    }
    return _pickerView;
}

//  设置数组
- (void)setPickerDataArray:(NSArray *)pickerDataArray{
    if (pickerDataArray.count > 0) {
        _pickerDataArray = pickerDataArray;
    }
    
    [self.pickerView reloadAllComponents];
}

#pragma mark - 按钮点击事件
//  点击返回
- (void)backButtonAction{
    [self hiddenPickerViewWithAnimation:YES];
}

//  点击确认按钮
- (void)confirmButtonAction{
    [self hiddenPickerViewWithAnimation:YES];
}

//  显示pickerView
- (void)showPickerViewWithAnimation:(BOOL)animation{
    CGFloat pickerBgViewY = Main_Screen_Height - TabBar_Addition_Height - kBackgroundPickerViewHeight;
    if (animation) {
        [UIView animateWithDuration:0.38 animations:^{
            self.maskBackgroundView.alpha = 0.4;
            self.pickerBgView.frame = CGRectMake(0.0, pickerBgViewY, Main_Screen_Width, kBackgroundPickerViewHeight);
        } completion:^(BOOL finished) {
        }];
    } else {
        self.maskBackgroundView.alpha = 0.4;
        self.pickerBgView.frame = CGRectMake(0.0, pickerBgViewY, Main_Screen_Width, kBackgroundPickerViewHeight);
    }
}

//  取消pickerView
- (void)hiddenPickerViewWithAnimation:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.38 animations:^{
            self.maskBackgroundView.alpha = 0.0;
            self.pickerBgView.frame = CGRectMake(0.0, Main_Screen_Height, Main_Screen_Width, kBackgroundPickerViewHeight);
        } completion:^(BOOL finished) {
            for (UIView *view in self.subviews) {
                [view removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    } else {
        self.maskBackgroundView.alpha = 0.0;
        self.pickerBgView.frame = CGRectMake(0.0, Main_Screen_Height, Main_Screen_Width, kBackgroundPickerViewHeight);
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerDataArray.count;
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString  *selectedReason = [self.pickerDataArray objectAtIndex:row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewSelectValue:)]) {
        if (selectedReason) {
            [self.delegate pickerViewSelectValue:selectedReason];
        }
    }
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerDataArray objectAtIndex:row];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
