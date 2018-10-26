//
//  ALAIntroduction.h
//  ALAIntroductionView
//
//  Created by Ryan on 2017/8/16.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ALAIntroductionType) {
    ALAIntroductionTypeAlipayOffline = 1,       //   支付宝线下支付
};

@interface ALAIntroduction : NSObject

+ (void)addIntroduction:(ALAIntroductionType)type;

@end
