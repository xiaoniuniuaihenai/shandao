//
//  ZTMXFFirstConfirmLoanView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFFirstConfirmLoanView.h"

@interface ZTMXFFirstConfirmLoanView ()

@property (nonatomic, strong)UILabel * amountLabel;
@property (nonatomic, strong)UILabel * arrivalAmountLabel;

@end


@implementation ZTMXFFirstConfirmLoanView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, KW - X(36), 216 * PX);
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = K_BackgroundColor;
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = K_BackgroundColor;
        [self addSubview:line2];
        
        UILabel * topLabel = [[UILabel alloc] init];
        topLabel.text = @"提现金额（元）";
        topLabel.textColor = K_666666;
        topLabel.font = FONT_Regular(14 * PX);
        topLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:topLabel];
        
        self.amountLabel = [[UILabel alloc] init];
        _amountLabel.textColor = K_333333;
        _amountLabel.font = FONT_Medium(36 * PX);
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_amountLabel];
        
        UIView *leftCor = [[UIView alloc]init];
        leftCor.backgroundColor = K_BackgroundColor;
        leftCor.layer.cornerRadius = X(13)/2;
        [self addSubview:leftCor];
        
        UIView *rightCor = [[UIView alloc]init];
        rightCor.backgroundColor = K_BackgroundColor;
        rightCor.layer.cornerRadius = X(13)/2;
        [self addSubview:rightCor];
        
        UIView *lineImageView = [[UIView alloc]init];
        lineImageView.backgroundColor = UIColor.clearColor;
        [self addSubview:lineImageView];
        
        //lis
        UILabel *youHuiQuanLabel = [[UILabel alloc]init];
        youHuiQuanLabel.font = FONT_Regular(X(16));
        youHuiQuanLabel.textColor = K_333333;
        youHuiQuanLabel.textAlignment = NSTextAlignmentLeft;
        youHuiQuanLabel.text = @"优惠券";
        youHuiQuanLabel.userInteractionEnabled = YES;
        [self addSubview:youHuiQuanLabel];
        
        UITapGestureRecognizer *clickYouHuiQuanGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickYouHuiQuanAction:)];
        [youHuiQuanLabel addGestureRecognizer:clickYouHuiQuanGesture];
        
        //优惠券右边小图片
        UIImageView *rightImageView = [UIImageView new];
        rightImageView.contentMode = UIViewContentModeCenter;
        rightImageView.image = [UIImage imageNamed:@"mine_right_arrow"];
        [self addSubview:rightImageView];
        
        self.couponLabel = [UILabel new];
        _couponLabel.font = FONT_Regular(X(14));
        _couponLabel.textColor = [UIColor colorWithHexString:@"#888888"];
        _couponLabel.textAlignment = NSTextAlignmentRight;
        _couponLabel.text = @"暂无可用";
        [self addSubview:_couponLabel];
        
        
        
        UIView *LineView1 = [UIView new];
        LineView1.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self addSubview:LineView1];
        
//        _successfulImgView = [UIImageView new];
//        _successfulImgView.contentMode = UIViewContentModeCenter;
//        _successfulImgView.image = [UIImage imageNamed:@"mine_right_arrow"];
//        [self.contentView addSubview:_successfulImgView];
//        _successfulImgView.sd_layout
//        .rightSpaceToView(self.contentView, 5)
//        .topEqualToView(self.contentView)
//        .bottomEqualToView(self.contentView)
//        .widthIs(15);
        
        UILabel *daoZhangLabel = [[UILabel alloc]init];
        daoZhangLabel.font = FONT_Regular(X(16));
        daoZhangLabel.textColor = K_333333;
        daoZhangLabel.text = @"到账金额";
        [self addSubview:daoZhangLabel];
        
        _arrivalAmountLabel = [[UILabel alloc]init];
        _arrivalAmountLabel.font = FONT_Regular(X(16));
        _arrivalAmountLabel.textColor = K_333333;
        _arrivalAmountLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_arrivalAmountLabel];
        
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = K_BackgroundColor;
        [self addSubview:bottomLine];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(X(1));
            make.width.mas_equalTo(X(24));
            make.centerY.mas_equalTo(self.mas_top).mas_offset(X(8));
        }];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(X(1));
            make.width.mas_equalTo(X(24));
            make.centerY.mas_equalTo(line1.mas_centerY).mas_offset(X(3));
        }];
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(line2.mas_centerY).mas_offset(X(29));
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(X(20));
        }];
        [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(X(50));
            make.width.mas_equalTo(self);
            make.centerY.mas_equalTo(topLabel.mas_centerY).mas_offset(X(36));
        }];
        
        [leftCor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_top).mas_offset(X(123));
            make.height.width.mas_equalTo(X(13));
            make.centerX.mas_equalTo(self.mas_left);
        }];
        [rightCor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_top).mas_offset(X(123));
            make.height.width.mas_equalTo(X(13));
            make.centerX.mas_equalTo(self.mas_right);
        }];
        [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(X(16));
            make.right.mas_equalTo(self.mas_right).mas_offset(X(-16));
            make.centerY.mas_equalTo(leftCor.mas_centerY);
            make.height.mas_equalTo(0.5);
        }];
        [self draw:lineImageView];
        
        //lis===
        [youHuiQuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(X(16));
            make.centerY.mas_equalTo(lineImageView.mas_centerY).mas_offset(X(22));
            make.right.mas_equalTo(self.mas_right).mas_offset(-X(16));
            make.height.mas_equalTo(X(22));
        }];
        
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(X(-13));
            make.centerY.mas_equalTo(youHuiQuanLabel.mas_centerY);
            make.width.mas_equalTo(X(6));
            make.height.mas_equalTo(X(11));
        }];
        
        [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightImageView.mas_left).offset(X(-6));
            make.centerY.mas_equalTo(youHuiQuanLabel.mas_centerY);
            make.width.mas_equalTo(X(100));
            make.height.mas_equalTo(X(14));
        }];
        
        
        [LineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(X(16));
            make.top.mas_equalTo(lineImageView.mas_bottom).mas_offset(X(44));
            make.right.mas_equalTo(self.mas_right).mas_offset(X(-16));
            make.height.mas_equalTo(1);
        }];
        //====
        
        [daoZhangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(X(16));
            make.centerY.mas_equalTo(LineView1.mas_centerY).mas_offset(X(22));
            make.width.mas_equalTo(X(150));
            make.height.mas_equalTo(X(22));
        }];
        [_arrivalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(X(-16));
            make.left.mas_equalTo(daoZhangLabel.mas_right);
            make.height.mas_equalTo(X(22));
            make.centerY.mas_equalTo(daoZhangLabel.mas_centerY);
        }];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(@8);
        }];
    }
    return self;
}
-(void)clickYouHuiQuanAction:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"点击优惠券");
    if (self.clickCouponBlock) {
        self.clickCouponBlock();
    }
}

//lis
-(void)setCouponFloat:(CGFloat)couponFloat{
    
    if (_couponFloat != couponFloat) {
        _couponFloat = couponFloat;
        
        if (!couponFloat) {
            _couponLabel.text = @"暂无可用";
            _couponLabel.textColor = [UIColor colorWithHexString:@"#888888"];
        }else{
            _couponLabel.text = [NSString stringWithFormat:@"¥%d",(int)couponFloat];
            _couponLabel.textColor = [UIColor colorWithHexString:@"#FF6F00"];
        }
    }
}
- (void)setAmountStr:(NSString *)amountStr
{
    if (_amountStr != amountStr) {
        _amountStr = [amountStr copy];
        //_amountLabel.text = _amountStr;
        _amountLabel.text = [NSString stringWithFormat:@"%.2f", [_amountStr floatValue]];
    }
}
- (void)draw:(UIView *)line{
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    //设置虚线颜色为blackColor
    [dotteShapeLayer setStrokeColor:[COLOR_SRT(@"E6E6E6") CGColor]];
    //设置虚线宽度
    dotteShapeLayer.lineWidth = 0.5f ;
    //10=线的宽度 5=每条线的间距
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, 0 ,0);
    CGPathAddLineToPoint(dotteShapePath, NULL, KW - X(32),0);
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    //把绘制好的虚线添加上来
    [line.layer addSublayer:dotteShapeLayer];
}
- (void)setArrivalAmount:(NSString *)arrivalAmount{
    if (_arrivalAmount != arrivalAmount) {
        _arrivalAmount = [arrivalAmount copy];
        _arrivalAmountLabel.text = [NSString stringWithFormat:@"%@元",arrivalAmount];
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
