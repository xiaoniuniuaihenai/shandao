//
//  LSReminderButton.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSReminderButton.h"

@implementation LSReminderButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

//  添加子视图
- (void)setupViews{
    self.reminderCountLabel = [UILabel labelWithTitleColorStr:@"fe8228" fontSize:12 alignment:NSTextAlignmentCenter];
    self.reminderCountLabel.layer.cornerRadius = 5;
    self.reminderCountLabel.clipsToBounds = YES;
    self.reminderCountLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.reminderCountLabel];
    self.reminderCountLabel.hidden = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat viewWidth = self.bounds.size.width;
    self.reminderCountLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) - 5, CGRectGetMinY(self.imageView.frame) - 5, 10, 10);
//    self.reminderCountLabel.frame = CGRectMake(viewWidth - 20.0, 5.0, 10.0, 10.0);
}

- (void)showReminderCount:(NSString *)count{
    self.reminderCountLabel.textColor = [UIColor colorWithHexString:@"fe8228"];
    self.reminderCountLabel.backgroundColor = [UIColor redColor];
    NSInteger reminderCount = [count integerValue];
    if (reminderCount > 0) {
        self.reminderCountLabel.hidden = NO;
//        self.reminderCountLabel.text = count;
    } else {
        self.reminderCountLabel.hidden = YES;
    }
}

- (void)showRedReminderCount:(NSString *)count{
    self.reminderCountLabel.textColor = [UIColor whiteColor];
    self.reminderCountLabel.backgroundColor = K_MainColor;
    NSInteger reminderCount = [count integerValue];
    if (reminderCount > 0) {
        self.reminderCountLabel.hidden = NO;
//        self.reminderCountLabel.text = count;
    } else {
        self.reminderCountLabel.hidden = YES;
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
