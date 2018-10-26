//
//  XLUmengShareHelper.m
//  YWLTMeiQiiOS
//
//  Created by 凉 on 2018/6/25.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLUmengShareHelper.h"
#import <UShareUI/UShareUI.h>
#import "UIViewController+Visible.h"
@implementation XLUmengShareHelper

+(void)startShareWithDic:(NSDictionary *)dic
{
     [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)]];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [XLUmengShareHelper shareWebPageToPlatformType:platformType parameters:dic];
    }];
}

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType parameters:(NSDictionary *)parameters
{
    
    
    //lis分享
    NSString * urlShare = [parameters[@"shareAppUrl"] description];
    NSString * shareAppImage = [parameters[@"shareAppImage"] description];
    NSString * shareAppTitle = [parameters[@"shareAppTitle"] description];
    NSString * shareAppContent = [parameters[@"shareAppContent"] description];
    
    
    //                //   是否提交
    //                NSString * isSubmit = [resultDict[@"isSubmit"]description];
    //                if ([isSubmit integerValue]==1) {
    //                    shareView.sharePage = [resultDict[@"sharePage"]description];
    //                    shareView.isSubmitResults = YES;
    //                }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  shareAppImage;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareAppTitle descr:shareAppContent thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = urlShare;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController currentViewController] completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"00000失败Error: %@",error);
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@" 分享结果消息 %@", resp.message);
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                NSLog(@"00000成功");

                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
                NSLog(@"00000成0000000");

            }
        }
    }];
}

//+(void)submitShareType:(NSString *)


@end
