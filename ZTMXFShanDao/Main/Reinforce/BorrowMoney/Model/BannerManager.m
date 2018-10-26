//
//  BannerManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BannerManager.h"
#import "LSWebViewController.h"
#import "LSBorrowBannerModel.h"
#import "LSHornBarModel.h"
@implementation BannerManager
+(void)bannerManagerActionWithSuperVc:(UIViewController*)superVc andBanner:(LSBorrowBannerModel*)bannerModel{
    if (bannerModel.isNeedLogin==1&&![LoginManager loginState]) {
//        需要登录的未登录 弹出登录
        [LoginManager presentLoginVCWithController:superVc];
    }else{
        if ([bannerModel.type isEqualToString:@"H5_URL"]) {
            //    进入H5
            LSWebViewController * webVc = [[LSWebViewController alloc]init];
            // 去除字符串左右空格
            bannerModel.content = [bannerModel.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            webVc.webUrlStr = bannerModel.content;
            [superVc.navigationController pushViewController:webVc animated:YES];
        }else{
            
        }
    }
}
+(void)hornManagerActionWithSuperVc:(UIViewController*)superVc andHorn:(LSHornBarModel*)bannerModel{
    if (bannerModel.isNeedLogin==1&&![LoginManager loginState]) {
        //        需要登录的未登录 弹出登录
        [LoginManager presentLoginVCWithController:superVc];
    }else{
        if ([bannerModel.type isEqualToString:@"H5_URL"]) {
            //    进入H5
            LSWebViewController * webVc = [[LSWebViewController alloc]init];
            webVc.webUrlStr = bannerModel.wordUrl;
            [superVc.navigationController pushViewController:webVc animated:YES];
        }else{
            
        }
    }
}
@end
