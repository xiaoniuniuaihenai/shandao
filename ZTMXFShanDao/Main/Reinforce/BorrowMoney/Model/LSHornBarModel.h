//
//  LSHornBarModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSHornBarModel : NSObject

@property (nonatomic,copy) NSString * wordUrl;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * content;
/*是否需要登录才能点击，1 是，0 否*/
@property (nonatomic,assign) NSInteger isNeedLogin;

@end
