//
//  ZTMXFCardManager.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/3/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCardManager.h"
#import "ZTMXFCardDefaultViewController.h"

@implementation ZTMXFCardManager


#pragma mark - Start Detect
- (void)IDCardStartDetection:(UIViewController *)ViewController
                  IdCardSide:(MGIDCardSide)CardSide
                      finish:(void(^)(MGIDCardModel *model))finish
                        errr:(void(^)(MGIDCardError errorType))error{
#if TARGET_IPHONE_SIMULATOR
    if (error) {
        
        error(MGIDCardErrorSimulator);
    }
#else
    MGIDCardDetectManager *cardCheckManager = [MGIDCardDetectManager idCardManagerWithCardSide:CardSide
                                                                             screenOrientation:self.screenOrientation];
    
    NSString *sessionFrame = [MGAutoSessionPreset autoSessionPreset];
    MGVideoManager *videoManager = [MGVideoManager videoPreset:sessionFrame
                                                devicePosition:AVCaptureDevicePositionBack
                                                   videoRecord:NO
                                                    videoSound:NO];
    
    ZTMXFCardDefaultViewController *idcardDetectVC = [[ZTMXFCardDefaultViewController alloc] init];
    [idcardDetectVC setVideoManager:videoManager];
    [idcardDetectVC setCardCheckManager:cardCheckManager];
    [idcardDetectVC setFinishBlock:finish];
    [idcardDetectVC setErrorBlcok:error];
    
    if (MG_WIN_WIDTH <= 320 && MG_WIN_HEIGHT <= 480) {
        [idcardDetectVC setScreenOrientation:MGIDCardScreenOrientationLandscapeLeft];
    } else {
        [idcardDetectVC setScreenOrientation:self.screenOrientation];
    }
    
    [ViewController presentViewController:idcardDetectVC animated:YES completion:nil];
#endif
}


@end
