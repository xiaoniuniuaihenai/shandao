//
//  LSMsgListTableViewCell.h
//  ALAFanBei
//
//  Created by Try on 2017/2/15.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//  消息

#import <UIKit/UIKit.h>
@class LSNotificationModel;
@interface LSMsgListTableViewCell : UITableViewCell
@property (nonatomic,strong) LSNotificationModel * notModel;
@end
