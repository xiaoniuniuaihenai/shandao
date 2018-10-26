//
//  InstallmentCellView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "InstallmentCellView.h"

@interface InstallmentCellView ()

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** subTitle label */
@property (nonatomic, strong) UILabel *subTitleLabel;

/** title image */
@property (nonatomic, strong) UIImageView *titleImageView;
/** value label */
@property (nonatomic, strong) UILabel *valueLabel;

/** view button */
@property (nonatomic, strong) UIButton *viewButton;

/** row Image */
@property (nonatomic, strong) UIImageView *rowImageView;

/* bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation InstallmentCellView
{
    NSObject *target;
    SEL       viewAction;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value target:(NSObject *)obj action:(SEL)action{
    
    self.titleStr = title;
    self.valueStr = value;
    target = obj;
    viewAction = action;
    
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - setter


//  设置title
- (void)setTitleStr:(NSString *)titleStr{
    if (_titleStr != titleStr) {
        _titleStr = titleStr;
    }
    self.titleLabel.text = titleStr;
}
//  设置titleImage 的图片
- (void)setTitleImageStr:(NSString *)titleImageStr
{
    if (_titleImageStr != titleImageStr) {
        _titleImageStr = titleImageStr;
    }
    if ([_titleImageStr rangeOfString:@"http"].location != NSNotFound) {
        //  链接图片
        [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:_titleImageStr]];
    } else {
        self.titleImageView.image = [UIImage imageNamed:_titleImageStr];
    }
}


//  设置subTitle
- (void)setSubTitleStr:(NSString *)subTitleStr{
    if (_subTitleStr != subTitleStr) {
        _subTitleStr = subTitleStr;
    }
    self.subTitleLabel.text = subTitleStr;
    
    if ([subTitleStr rangeOfString:@"认证即可分期"].location !=NSNotFound) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:subTitleStr];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_BLUE_STR]} range:[subTitleStr rangeOfString:@"去认证"]];
        self.subTitleLabel.attributedText = attStr;
    }
}

//  设置value
- (void)setValueStr:(NSString *)valueStr{
    if (_valueStr != valueStr) {
        _valueStr = valueStr;
    }
    self.valueLabel.text = valueStr;
}

//  添加子控件
- (void)setupViews{
    
    /** title */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:14 alignment:NSTextAlignmentLeft];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    
    /** subTitle */
    self.subTitleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:12 alignment:NSTextAlignmentLeft];
    self.subTitleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.subTitleLabel];
    
    /** title image */
    self.titleImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self];
    self.titleImageView.layer.cornerRadius = 5.0f;
    self.titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleImageView.backgroundColor = [UIColor clearColor];
    
    /** value */
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR] fontSize:14 alignment:NSTextAlignmentRight];
    self.valueLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.valueLabel];
    
    /** 箭头 */
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    /** 细线 */
    self.bottomLineView = [UIView setupViewWithSuperView:self withBGColor:COLOR_BORDER_STR];
    
    /** 按钮 */
    self.viewButton = [UIButton setupButtonWithSuperView:self withObject:target action:viewAction];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat viewWidth = self.bounds.size.width;
    
    CGFloat titleImageX = 0.0;
    self.titleImageView.frame = CGRectMake(titleImageX, (cellHeight - 25.0) / 2.0, 25.0, 25.0);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.titleImageView.frame)+8.0, AdaptedHeight(10), 200.0, AdaptedHeight(20));
    
    self.subTitleLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+2.0, self.titleLabel.width, AdaptedHeight(17));
    
    self.valueLabel.frame = CGRectMake(60.0, 0.0, viewWidth - 72.0, cellHeight);
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5,viewWidth - 12.0, 0.5);
    
    self.viewButton.frame = CGRectMake(0.0, 0.0, viewWidth, cellHeight);
}

@end
