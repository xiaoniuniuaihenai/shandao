//
//  BannerManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSBorrowBannerModel;
@class LSHornBarModel;
@interface BannerManager : NSObject
+(void)bannerManagerActionWithSuperVc:(UIViewController*)superVc andBanner:(LSBorrowBannerModel*)bannerModel;
+(void)hornManagerActionWithSuperVc:(UIViewController*)superVc andHorn:(LSHornBarModel*)bannerModel;

@end
