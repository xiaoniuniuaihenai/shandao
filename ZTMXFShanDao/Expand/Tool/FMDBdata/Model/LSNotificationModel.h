//
//  LSNotificationModel.h
//  Himalaya
//
//  Created by 苏伟丽 on 16/8/20.
//  Copyright © 2016年 ala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSCustomBaseModel.h"

@interface LSNotificationModel : LSCustomBaseModel
/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 推送时间
 */
@property (nonatomic, copy) NSString *time;
/**
 
 */
@property (nonatomic, copy) NSString *message;
/**
 
 */
@property (nonatomic, copy) NSString *userName;
/**
 
 */
@property (nonatomic, copy) NSString *pid;
/**
 消息推送类型
 */
@property (nonatomic, copy) NSString *pushJumpType;
/**
 补充数据
 */
@property (nonatomic, copy) NSString *data;
/**
 落地页
 */
@property (nonatomic, copy) NSString *pushLandingPage;
/**
 消息类型
 */
@property (nonatomic, copy) NSString *pushNoticeType;


@property (nonatomic, copy) NSString *isRead;//0、未读 1、已读

@end
