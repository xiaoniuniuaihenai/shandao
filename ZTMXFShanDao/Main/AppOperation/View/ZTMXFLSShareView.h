//
//  LSShareView.h
//  ALAFanBei
//
//  Created by Try on 2017/3/3.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum : NSUInteger {
//    InviteShareType = 998,  //  邀请分享
//} ShareViewType;

@protocol LSShareDelegate <NSObject>

@optional
- (void)shareSuccess;

@end

@interface ZTMXFLSShareView : UIView

@property (nonatomic,weak) id <LSShareDelegate> delegate;

/** 分享类型 */
//@property (nonatomic, assign) ShareViewType shareViewType;
@property (nonatomic,copy) NSString * urlShare;
//二维码
@property (nonatomic,copy) NSString * shareCodeUrl;
@property (nonatomic,copy) NSString * titleStr;
@property (nonatomic,copy) NSString * contentStr;
@property (nonatomic,copy) NSString * iconUrlStr;
//H5控制 是否将分享结果 给后台
@property(nonatomic,assign) BOOL isSubmitResults;
@property(nonatomic,copy) NSString *sharePage;
-(void)hideShareView;
-(void)showShareView;
-(void)showShareViewWithAnimation;
@end
