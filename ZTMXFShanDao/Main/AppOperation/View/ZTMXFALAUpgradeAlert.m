//
//  ALAUpgradeAlert.m
//  ALAFanBei
//
//  Created by Ryan on 2017/8/18.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ZTMXFALAUpgradeAlert.h"
#import "HomePagePopupView.h"
#import <UIKit/UIKit.h>

#define Is_up_Ios_9  [[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0
#define DefaultFont Is_up_Ios_9 ? [UIFont fontWithName:@"PingFangSC-Light" size:14] : [UIFont systemFontOfSize:14]

typedef NS_ENUM(NSUInteger, ALAUpgradeType) {
    ALAUpgradeTypeNormal = 1,
    ALAUpgradeTypeForce = 2
};

@interface ALAUpgradeTapView : UIView

@property (nonatomic, copy) void(^tapBlock)(void);

@end

@implementation ALAUpgradeTapView

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end

@interface ALAUpgradeMessageCell : UITableViewCell

@end

@implementation ALAUpgradeMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.numberOfLines = 0;
        self.textLabel.font = DefaultFont;
        self.textLabel.textColor = [UIColor colorWithRed: 51/255.0 green: 51/255.0 blue: 51/255.0 alpha: 1];
    }
    return self;
}

@end



@interface ALAUpgradeForceMessageCell : ALAUpgradeMessageCell

@property (nonatomic, strong) UIView *redPoint;

@property (nonatomic, assign) CGFloat defaultHeight;

@end

@implementation ALAUpgradeForceMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.redPoint = [[UIView alloc] init];
        self.redPoint.backgroundColor = [UIColor colorWithRed: 250/255.0 green: 113/255.0 blue: 33/255.0 alpha: 1];
        self.redPoint.layer.masksToBounds = YES;
        [self addSubview:self.redPoint];
    }
    return self;
}

- (CGFloat)defaultHeight {
    if (!_defaultHeight) {
        return ([self heightForString:@"升级" andFont:DefaultFont andWidth:30] + 4) / 2;
    }
    return _defaultHeight;
}

-(float)heightForString:(NSString*)valueStr andFont:(UIFont*)font andWidth:(float)width
{
    //    计算文本的大小
    CGSize sizeToFit = [valueStr boundingRectWithSize:CGSizeMake(width , MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return sizeToFit.height;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.redPoint.frame = CGRectMake(0, 0, 5, 5);
    self.redPoint.centerY = self.defaultHeight + CGRectGetMinY(self.textLabel.frame);
    self.redPoint.layer.cornerRadius = CGRectGetHeight(self.redPoint.frame) / 2;
}

@end

@interface ALAUpgradeMessageView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) ALAUpgradeType type;
@property (nonatomic, strong) NSArray *message;

@end

@implementation ALAUpgradeMessageView

- (instancetype)initWithMessageType:(ALAUpgradeType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _type = type;
        [self commonInit];
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}



- (void)setMessage:(NSArray *)message {
    _message = message;
    [self.tableView reloadData];
}
- (void)commonInit {
    [self addSubview:self.tableView];
    
    Class cls = _type == ALAUpgradeTypeNormal ? [ALAUpgradeMessageCell class] : [ALAUpgradeForceMessageCell class];
    [self.tableView registerClass:[cls class] forCellReuseIdentifier:NSStringFromClass([cls class])];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.message.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = _type == ALAUpgradeTypeNormal ? NSStringFromClass([ALAUpgradeMessageCell class]) : NSStringFromClass([ALAUpgradeForceMessageCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.message objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *message = [self.message objectAtIndex:indexPath.row];
    if (!message.length) {
        return 0.0;
    }
    CGFloat height = [self heightForString:message andFont:DefaultFont andWidth:CGRectGetWidth(tableView.frame) - 30];
    return 2 + 2 + height;
}

-(float)heightForString:(NSString*)valueStr andFont:(UIFont*)font andWidth:(float)width
{
    //    计算文本的大小
    CGSize sizeToFit = [valueStr boundingRectWithSize:CGSizeMake(width , MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return sizeToFit.height;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

@end


@interface ALAUpgradeAlertView : UIView

@property (nonatomic, assign) ALAUpgradeType type;
@property (nonatomic, strong) NSArray *message;
@property (nonatomic, copy) NSString *version;

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) ALAUpgradeMessageView *messageView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) void(^cancelBlock)();
@property (nonatomic, copy) void(^confirmBlock)();

- (instancetype)initWithType:(ALAUpgradeType)type message:(NSArray *)message version:(NSString *)version;

@end

@implementation ALAUpgradeAlertView

- (instancetype)initWithType:(ALAUpgradeType)type message:(NSArray *)message version:(NSString *)version {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _type = type;
        _message = message;
        _version = version;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundView = [[UIImageView alloc] init];
    
    self.versionLabel = [[UILabel alloc] init];
    self.versionLabel.text = self.version;
    self.versionLabel.font = [UIFont systemFontOfSize:10];
    self.versionLabel.textAlignment = NSTextAlignmentLeft;
    
    self.messageView = [[ALAUpgradeMessageView alloc] initWithMessageType:self.type];
    //self.messageView.backgroundColor = [UIColor lightGrayColor];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton addTarget:self action:@selector(actionCancel) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton addTarget:self action:@selector(actionConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.versionLabel];
    [self addSubview:self.messageView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.confirmButton];
    
    self.messageView.message = self.message;
}

- (void)actionCancel {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)actionConfirm {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
}

@end

@interface ALANormalUpgradeAlertView : ALAUpgradeAlertView

@end

@implementation ALANormalUpgradeAlertView

- (instancetype)initWithType:(ALAUpgradeType)type message:(NSArray *)message version:(NSString *)version {
    self = [super initWithType:type message:message version:version];
    if (self) {
        self.backgroundView.image = [UIImage imageNamed:@"normalUpgrade"];
        self.versionLabel.textColor = [UIColor colorWithRed:255/255.f green:215/255.f blue:186/255.f alpha:1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.versionLabel.frame = CGRectMake(73, 34, 40, 8);
    self.messageView.frame = CGRectMake(20, 135, CGRectGetWidth(self.bounds)-40 + 10, 120);
    self.cancelButton.frame = CGRectMake(0, CGRectGetHeight(self.frame)-50, CGRectGetWidth(self.frame)/2, 50);
    self.confirmButton.frame = CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-50, CGRectGetWidth(self.frame)/2, 50);
}

@end

@interface ALAForceUpgradeAlertView : ALAUpgradeAlertView

@end

@implementation ALAForceUpgradeAlertView

- (instancetype)initWithType:(ALAUpgradeType)type message:(NSArray *)message version:(NSString *)version {
    self = [super initWithType:type message:message version:version];
    if (self) {
//        self.backgroundView.image = [UIImage imageNamed:@"forceUpgrade"];
        self.versionLabel.textAlignment = NSTextAlignmentCenter;
        self.versionLabel.textColor = [UIColor colorWithRed:235/255.f green:69/255.f blue:43/255.f alpha:1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.versionLabel.frame = CGRectMake(155, 90, 40, 10);
    self.messageView.frame = CGRectMake(32, 138, CGRectGetWidth(self.bounds)-64 + 16, 95);
    self.confirmButton.frame = CGRectMake(38, CGRectGetHeight(self.bounds)-15-38.5, 194.5, 38.5);
}

@end

@interface ZTMXFALAUpgradeAlert ()

@property (nonatomic, strong) ALAUpgradeTapView *tapView;
@property (nonatomic, strong) UIView *alertView;

@end

@implementation ZTMXFALAUpgradeAlert

+ (void)showForceUpgradeAlertWithMessage:(NSArray *)message version:(NSString *)version confirmBlock:(void (^)())confirmBlock {
    ZTMXFALAUpgradeAlert *alert = [[ZTMXFALAUpgradeAlert alloc] init];
    [alert showForceUpgradeAlertWithMessage:message version:version confirmBlock:confirmBlock];
}

- (void)showForceUpgradeAlertWithMessage:(NSArray *)message version:(NSString *)version confirmBlock :(void (^)())confirmBlock {
    ALAForceUpgradeAlertView *alertView = [[ALAForceUpgradeAlertView alloc] initWithType:ALAUpgradeTypeForce message:message version:version];
    alertView.confirmBlock = ^{
        if (confirmBlock) {
            confirmBlock();
        }
    };
    [self showAlertView:alertView isClose:NO confirmBlock:confirmBlock cancelBlock:nil];
}

+ (void)showNormalUpgradeAlertWithMessage:(NSArray *)message version:(NSString *)version confirmBlock:(void (^)())confirmBlock cancelBlock:(void (^)())cancelBlock {
    ZTMXFALAUpgradeAlert *alert = [[ZTMXFALAUpgradeAlert alloc] init];
    [alert showNormalUpgradeAlertWithMessage:message version:version confirmBlock:confirmBlock cancelBlock:cancelBlock];
}

- (void)showNormalUpgradeAlertWithMessage:(NSArray *)message version:(NSString *)version confirmBlock:(void (^)())confirmBlock cancelBlock:(void (^)())cancelBlock {
    ALANormalUpgradeAlertView *alertView = [[ALANormalUpgradeAlertView alloc] initWithType:ALAUpgradeTypeNormal message:message version:version];
    alertView.cancelBlock = ^{
        [self dismiss];
    };
    alertView.confirmBlock = ^{
        if (confirmBlock) {
            confirmBlock();
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        }
    };
    [self showAlertView:alertView isClose:YES confirmBlock:confirmBlock cancelBlock:cancelBlock];
}

- (void)showAlertView:(ALAUpgradeAlertView *)alertView isClose:(BOOL)isClose confirmBlock:(void (^)())confirmBlock cancelBlock:(void (^)())cancelBlock {
    UIView *sourceView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    alertView.frame = CGRectMake(0, 0, 540/2, 660/2);
    alertView.center = CGPointMake(sourceView.frame.size.width/2, sourceView.frame.size.height/2);
    
    ALAUpgradeTapView *tapView = [[ALAUpgradeTapView alloc] initWithFrame:sourceView.bounds];
    tapView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    tapView.tapBlock = ^{
        if (isClose) {
            [self dismiss];
        }
    };

    [sourceView addSubview:tapView];
    [sourceView addSubview:alertView];
    
    self.tapView = tapView;
    self.alertView = alertView;
}

- (void)dismiss {
    [self.alertView removeFromSuperview];
    [self.tapView removeFromSuperview];
}

@end
