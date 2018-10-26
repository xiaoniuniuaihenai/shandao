//
//  BaseViewController.h
//  MobileProject 基控制器


#import <UIKit/UIKit.h>
#import "UIImage+Color.h"
#import "Reachability.h"

@protocol  BBBaseViewControllerDataSource<NSObject>

@optional
-(NSMutableAttributedString*)setTitle;
-(UIButton*)set_leftButton;
-(UIButton*)set_rightButton;
-(UIColor*)set_colorBackground;
-(CGFloat)set_navigationHeight;
-(UIView*)set_bottomView;
-(UIImage*)navBackgroundImage;
-(BOOL)hideNavigationBottomLine;
-(UIImage*)set_leftBarButtonItemWithImage;
-(UIImage*)set_rightBarButtonItemWithImage;
@end


@protocol BBBaseViewControllerDelegate <NSObject>

@optional
-(void)left_button_event:(UIButton*)sender;
-(void)right_button_event:(UIButton*)sender;
-(void)title_click_event:(UIView*)sender;
@end

@interface BaseViewController : UIViewController<BBBaseViewControllerDataSource , BBBaseViewControllerDelegate>

//版本1.3.4新增需求,需保存当前页面的显示时间
@property (nonatomic, strong) NSDate *creatTime;
@property (nonatomic, strong) NSString *pageName;

@property (nonatomic, copy) NSString *navBarTitle;
//网络监听
@property (nonatomic,weak) Reachability *hostReach;

-(void)changeNavigationBarTranslationY:(CGFloat)translationY;

-(void)set_Title:(NSMutableAttributedString *)title;
//返回上一个页面
-(void)clickReturnBackEvent;


/** 设置右侧导航栏的右侧title按钮 */
- (void)setNavgationBarRightTitle:(NSString *)title;
/** 设置右侧导航栏的右侧图片按钮 */
- (void)setNavgationBarRightImageStr:(NSString *)imageStr;

/** 设置右侧导航栏的左侧title按钮 */
- (void)setNavgationBarLeftTitle:(NSString *)title;
/** 设置右侧导航栏的左侧图片按钮 */
- (void)setNavgationBarLeftImageStr:(NSString *)imageStr;

@end
