//
//  FaceRecognitionView.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "FaceRecognitionView.h"

@interface FaceRecognitionView ()

@property (nonatomic, strong) UILabel *faceDescribeLabel;
@property (nonatomic, strong) UIButton *faceRecognitionButton;

@property (nonatomic, strong) UIImageView *imageViewOne;
@property (nonatomic, strong) UILabel *labelOne;
@property (nonatomic, strong) UIImageView *imageViewTwo;
@property (nonatomic, strong) UILabel *labelTwo;
@property (nonatomic, strong) UIImageView *imageViewThree;
@property (nonatomic, strong) UILabel *labelThree;

/** 去认证 */
@property (nonatomic, strong) ZTMXFButton *authenButton;

@end

@implementation FaceRecognitionView



- (void)setupViews{
    
    self.faceDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentCenter];
    self.faceDescribeLabel.text = @"请将头部置于取景框内, 并按照提示操作";
    [self addSubview:self.faceDescribeLabel];
    
    self.faceRecognitionButton = [UIButton setupButtonWithSuperView:self withObject:self action:@selector(faceRecognitionButtonAction)];
    [self.faceRecognitionButton setImage:[UIImage imageNamed:@"face_recognition"] forState:UIControlStateNormal];
    
    self.imageViewOne = [UIImageView setupImageViewWithImageName:@"face_recognition_light" withSuperView:self];
    self.imageViewOne.contentMode = UIViewContentModeScaleAspectFit;

    self.imageViewTwo = [UIImageView setupImageViewWithImageName:@"face_recognition_phone" withSuperView:self];
    self.imageViewTwo.contentMode = UIViewContentModeScaleAspectFit;

    self.imageViewThree = [UIImageView setupImageViewWithImageName:@"face_recognition_action" withSuperView:self];
    self.imageViewThree.contentMode = UIViewContentModeScaleAspectFit;

    self.labelOne = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentCenter];
    self.labelOne.text = @"光线充足";
    [self addSubview:self.labelOne];

    self.labelTwo = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentCenter];
    self.labelTwo.text = @"正对手机";
    [self addSubview:self.labelTwo];

    self.labelThree = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentCenter];
    self.labelThree.text = @"动作标准";
    [self addSubview:self.labelThree];

    
    self.authenButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
    [self.authenButton setTitle:@"去认证" forState:UIControlStateNormal];
    [self.authenButton addTarget:self action:@selector(authenButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.authenButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.faceDescribeLabel.frame = CGRectMake(0.0, 30.0, Main_Screen_Width, 20.0);
    self.faceRecognitionButton.frame = CGRectMake((Main_Screen_Width - 100) / 2.0, CGRectGetMaxY(self.faceDescribeLabel.frame) + 30.0, 100.0, 100.0);
    
    CGFloat imageViewWidth = 80.0;
    CGFloat imageViewHeight = 68.0;
    CGFloat imageMargin = 30.0;
    CGFloat imageViewOriginX = (Main_Screen_Width - 3 * imageViewWidth - 2 * imageMargin) / 2.0;
    CGFloat imageViewOriginY = CGRectGetMaxY(self.faceRecognitionButton.frame) + 58.0;
    self.imageViewOne.frame = CGRectMake(imageViewOriginX, imageViewOriginY, imageViewWidth, imageViewHeight);
    self.imageViewTwo.frame = CGRectMake(CGRectGetMaxX(self.imageViewOne.frame) + imageMargin, imageViewOriginY, imageViewWidth, imageViewHeight);
    self.imageViewThree.frame = CGRectMake(CGRectGetMaxX(self.imageViewTwo.frame) + imageMargin, imageViewOriginY, imageViewWidth, imageViewHeight);

    self.labelOne.frame = CGRectMake(CGRectGetMinX(self.imageViewOne.frame), CGRectGetMaxY(self.imageViewOne.frame) + 10.0, imageViewWidth, 20.0);
    self.labelTwo.frame = CGRectMake(CGRectGetMinX(self.imageViewTwo.frame), CGRectGetMaxY(self.imageViewTwo.frame) + 10.0, imageViewWidth, 20.0);
    self.labelThree.frame = CGRectMake(CGRectGetMinX(self.imageViewThree.frame), CGRectGetMaxY(self.imageViewThree.frame) + 10.0, imageViewWidth, 20.0);

    self.authenButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.labelOne.frame) + 60.0, Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
}

#pragma mark - 按钮点击事件
//  点击人脸识别
- (void)faceRecognitionButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(faceRecognitionViewClickFace)]) {
        [self.delegate faceRecognitionViewClickFace];
    }
}

/** 去认证 */
- (void)authenButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(faceRecognitionViewClickAuthen)]) {
        [self.delegate faceRecognitionViewClickAuthen];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
