//
//  FacePlusManager.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/23.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ZTMXFFacePlusManager.h"
#import "WJYAlertView.h"
#import "AuthenPopupManager.h"
#import "ImageCompressHelper.h"
#import "UploadSingleImageService.h"
#import "UploadFileService.h"
#import "LSIdfSubmitInfoApi.h"
#import "UIView+Toast.h"
#import "AuthenBuryPoint.h"
#import <MGLivenessDetection/MGLivenessDetection.h>

#import "IdentityFrontInfoModel.h"
#import "IdentityBackInfoModel.h"
#import "ZTMXFCardManager.h"

@interface ZTMXFFacePlusManager ()

/** 正反面 */
@property (nonatomic, assign) MGIDCardSide cardType;
/** 是否超过次数 */
@property (nonatomic, assign) BOOL overTimes;

/** 正面身份证信息model */
@property (nonatomic, strong) IdentityFrontInfoModel *identityFrontInfoModel;
/** 正面身份证信息model */
@property (nonatomic, strong) IdentityBackInfoModel *identityBackInfoModel;

@end

@implementation ZTMXFFacePlusManager

/** 扫描身份证图片 */
- (void)fp_scanIdentityID:(MGIDCardSide)cardType viewController:(UIViewController *)controller{
    
        BOOL license = [MGIDCardManager getLicense];
    if (!license) {
        [ZTMXFUMengHelper mqEvent:k_idcard_sdk_fail_faceplus_xf];
        [WJYAlertView showOneButtonWithTitle:@"温馨提示" Message:@"SDK授权失败，请检查" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{
        }];
        return;
    }
    //V1.3.4新增埋点友盟已添加
    if (cardType == IDCARD_SIDE_FRONT)[ZTMXFUMengHelper mqEvent:k_idcard_frontpace_faceplus_pv_xf];
    //  进入facee ++ 扫描身份证埋点
    [AuthenBuryPoint requestAuthBuryPointWithType:AuthMaidianTypeFaceIdBackScan];
    WeakSelf(self)
    ZTMXFCardManager *cardManager = [[ZTMXFCardManager alloc] init];
    [cardManager setScreenOrientation:MGIDCardScreenOrientationLandscapeLeft];
    [cardManager IDCardStartDetection:controller IdCardSide:cardType finish:^(MGIDCardModel *model) {
        UIImage * idcardImage  = [model croppedImageOfIDCard];
        
        //  身份证扫描成功
        if (self.delegate && [self.delegate respondsToSelector:@selector(fp_scanIdentityIdSuccess:cardType:)]) {
            [self.delegate fp_scanIdentityIdSuccess:idcardImage cardType:cardType];
        }
        //  图片上传
        [weakself fp_uploadIdentityIdImage:idcardImage cardType:cardType];
        
    } errr:^(MGIDCardError errorType) {
        if (errorType==MGIDCardErrorCancel) {
            NSLog(@"取消检测");
        }
        //  取消扫描身份证
        if (self.delegate && [self.delegate respondsToSelector:@selector(fp_scanIdentityIdCancel)]) {
            [self.delegate fp_scanIdentityIdCancel];
        }
    }];
}

#pragma mark - 上传身份证图片
/** 上传身份证图片 */
- (void)fp_uploadIdentityIdImage:(UIImage *)image cardType:(MGIDCardSide)cardType{
    if (self.overTimes) {
        // 身份证扫描次数超限
        [AuthenPopupManager showScanIdentityOverTimes];
        return;
    }
    
    NSData *compressImageData = [ImageCompressHelper returnDataCompressedImageToLimitSizeOfKB:20 image:image];
    NSArray *imageFileNameArray = nil;
    if (cardType == IDCARD_SIDE_FRONT) {
        //  正面
        imageFileNameArray = @[@"front.jpg"];
    } else {
        //  反面
        imageFileNameArray = @[@"back.jpg"];
    }
    [SVProgressHUD showLoading];
    //氪信点击事件
    [CreditXAgent onClick:cardType == IDCARD_SIDE_FRONT?CXClickVerifyIDPicFrnt:CXClickVerifyIDPicBak];
    UploadSingleImageService * uploadImageApi = [[UploadSingleImageService alloc] initWithImageDatas:@[compressImageData] andUploadType:UploadSingleTypeFaceIdCard andFileName:imageFileNameArray];
    [uploadImageApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            if (cardType == IDCARD_SIDE_FRONT) {
                    [ZTMXFUMengHelper mqEvent:k_idcard_front_succ_faceplus_xf];
                //  正面
                self.identityFrontInfoModel = [IdentityFrontInfoModel mj_objectWithKeyValues:dataDict];
                //  正面上传身份证成功
                if (self.delegate && [self.delegate respondsToSelector:@selector(fp_uploadIdentityFrontImageSuccess:)]) {
                    
                    [self.delegate fp_uploadIdentityFrontImageSuccess:self.identityFrontInfoModel];
                }
            } else {
                //  反面

                self.identityBackInfoModel = [IdentityBackInfoModel mj_objectWithKeyValues:dataDict];
                //  反面上传身份证成功
                if (self.delegate && [self.delegate respondsToSelector:@selector(fp_uploadIdentityBackImageSuccess:)]) {
                    [self.delegate fp_uploadIdentityBackImageSuccess:self.identityBackInfoModel];
                }
            }
        } else if([codeStr isEqualToString:@"1307"]) {
            // 身份证扫描次数超限
            self.overTimes = YES;
            [AuthenPopupManager showScanIdentityOverTimes];
        } else if ([codeStr isEqualToString:@"7001"]) {
            NSString *messageStr = [responseDict[@"msg"] description];
            [kKeyWindow makeCenterToast:messageStr];
            //  切换用依图识别
            if (self.delegate && [self.delegate respondsToSelector:@selector(fp_switchScanIdentity:)]) {
                [self.delegate fp_switchScanIdentity:YiTuAuthentication];
            }
        } else if([codeStr isEqualToString:@"7002"]){
            NSString *messageStr = [responseDict[@"msg"] description];
            [kKeyWindow makeCenterToast:messageStr];
            //  切换用face++识别
            if (self.delegate && [self.delegate respondsToSelector:@selector(fp_switchScanIdentity:)]) {
                [self.delegate fp_switchScanIdentity:FacePlusAuthentication];
            }
        }
        if (![codeStr isEqualToString:@"1000"]) {
            if (cardType == IDCARD_SIDE_FRONT) {
                [ZTMXFUMengHelper mqEvent:k_idcard_front_fail_faceplus_xf parameter:@{@"error":[responseDict[@"msg"] description]?:@""}];
            }
        }
        //  上传身份证埋点
        [self uploadIdentityIdImage:cardType result:codeStr];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        if (cardType == IDCARD_SIDE_FRONT) {
            [ZTMXFUMengHelper mqEvent:k_idcard_front_fail_faceplus_xf parameter:@{@"error":request.error.localizedDescription?:@""}];
        }
        [SVProgressHUD dismiss];
    }];
}




/** 提交正反面身份证证信息 */
- (void)fp_submitIdentityFrontBackImagesWithEditName:(NSString *)editName{
    [SVProgressHUD showLoading];
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setValue:self.identityFrontInfoModel.cardInfo.address forKey:@"address"];
    [paramDict setValue:self.identityFrontInfoModel.cardInfo.citizen_id forKey:@"citizenId"];
    [paramDict setValue:self.identityFrontInfoModel.cardInfo.gender forKey:@"gender"];
    [paramDict setValue:self.identityFrontInfoModel.cardInfo.nation forKey:@"nation"];
    [paramDict setValue:self.identityBackInfoModel.cardInfo.agency forKey:@"agency"];
    [paramDict setValue:self.identityBackInfoModel.cardInfo.valid_date_begin forKey:@"validDateBegin"];
    [paramDict setValue:self.identityBackInfoModel.cardInfo.valid_date_end forKey:@"validDateEnd"];
    [paramDict setValue:self.identityFrontInfoModel.cardInfo.birthday forKey:@"birthday"];
    [paramDict setValue:self.identityFrontInfoModel.cardInfo.name forKey:@"name"];
    [paramDict setValue:editName forKey:@"editName"];
    [paramDict setValue:self.identityFrontInfoModel.imgInfo.url forKey:@"idFrontUrl"];
    [paramDict setValue:self.identityBackInfoModel.imgInfo.url forKey:@"idBehindUrl"];
    [paramDict setValue:@"FACE_PLUS_CARD" forKey:@"type"];
    LSIdfSubmitInfoApi * subInfoApi = [[LSIdfSubmitInfoApi alloc] initWithParameter:paramDict saveInfoType:SubmitIdCardInfoTypeFace];
    [subInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"submit.xfd_smrz_sfrz" OtherDict:[@{@"identityAuthentication":[responseDict[@"msg"]description]?:@""} mutableCopy]];
        //氪信提交事件
        [CreditXAgent onSubmit:CXSubmitVerifyID result:[codeStr isEqualToString:@"1000"]?YES:NO withMessage:[responseDict[@"msg"]description]?:@""];
        if ([codeStr isEqualToString:@"1000"]) {
            //   统计提交识别信息
            //  提交正反面身份证图片成功
            if (self.delegate && [self.delegate respondsToSelector:@selector(fp_submitIdentityFrontBackImagesSuccess)]) {
                [self.delegate fp_submitIdentityFrontBackImagesSuccess];
            }
        }else{
            NSString * msg = [responseDict[@"msg"]description];
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            [window makeCenterToast:msg];
        }
        [SVProgressHUD dismiss];

        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

/** 上传身份证埋点 */
- (void)uploadIdentityIdImage:(MGIDCardSide)type result:(NSString *)result{
    NSString *cardType = [NSString string];
    if (type == IDCARD_SIDE_FRONT) {
        //  正面
        cardType = @"1";
    } else {
        //  反面
        cardType = @"2";
    }
    NSString * resultString = [NSString string];
    if ([result isEqualToString:@"1000"]) {
        resultString = @"1";
    } else {
        resultString = @"2";
    }
    [AuthenBuryPoint requestUploadIdentityIdImageWithType:cardType result:resultString];
}
#pragma mark - 人脸识别
/** 开始人脸识别 */
- (void)fp_beginFaceRecognition:(UIViewController *)controller{
    if (![MGLiveManager getLicense]) {
        [WJYAlertView showOneButtonWithTitle:NSLocalizedString(@"title_remind", nil) Message:NSLocalizedString(@"key_sdk_license_failure", nil) ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:NSLocalizedString(@"title_sure", nil) Click:^{
        }];
        return;
    }
    //  埋点 人脸识别
    [AuthenBuryPoint requestAuthBuryPointWithType:AuthMaidianTypeFaceFaceRecognition];
    [ZTMXFUMengHelper mqEvent:k_facescan_faceplus_pv];
//    友盟统计
    //  人脸识别匹配
    MGLiveManager *liveManager = [[MGLiveManager alloc] init];
    WeakSelf(self)
    [liveManager startFaceDecetionViewController:controller finish:^(FaceIDData *finishDic, UIViewController *viewController) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
        
        NSData *resultData = [[finishDic images] valueForKey:@"image_best"];
        NSData *image_Env = [[finishDic images] valueForKey:@"image_env"];
        NSData *image_action1 = [[finishDic images] valueForKey:@"image_action1"];
        NSData *image_action2 = [[finishDic images] valueForKey:@"image_action2"];
        NSData *image_action3 = [[finishDic images] valueForKey:@"image_action3"];

        NSArray * faceArr = @[];
        if (resultData && image_Env && image_action1 && image_action2 && image_action3) {
            faceArr = @[resultData, image_Env, image_action1, image_action2, image_action3];
        }
       
        NSMutableDictionary * dicRq = [[NSMutableDictionary alloc] init];
        [dicRq setValue:finishDic.delta forKey:@"delta"];
        [dicRq setValue:self.realName forKey:@"idCardName"];
        [dicRq setValue:self.citizen_id forKey:@"idCardNumber"];
        
        NSString * dicRqJson = [dicRq mj_JSONString];
        NSMutableDictionary * dicPara = [[NSMutableDictionary alloc]init];
        [dicPara setValue:dicRqJson forKey:@"reqData"];
        //  上传人脸
        [weakself requestUploadFaceData:faceArr faceType:UploadFileTypeFaceForFace parametDic:dicPara];
        
    } error:^(MGLivenessDetectionFailedType errorType, UIViewController *viewController) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
        [weakself showErrorString:errorType];
        NSString * errorStr = @"错误";
//        获取活体图片失败
        switch (errorType) {
            case DETECTION_FAILED_TYPE_ACTIONBLEND:
            {
                errorStr = @"动作错误";
            }
                break;
            case DETECTION_FAILED_TYPE_NOTVIDEO:{
                errorStr = @"NOTVIDEO";
            }break;
            case DETECTION_FAILED_TYPE_TIMEOUT:{
                errorStr = @"超时";
            }break;
            case DETECTION_FAILED_TYPE_FACELOSTNOTCONTINUOUS:{
                errorStr = @"面部失去不连续";
            }break;
            case DETECTION_FAILED_TYPE_TOOMANYFACELOST:{
                errorStr = @"太多的脸失去了";
            }break;
            case DETECTION_FAILED_TYPE_FACENOTCONTINUOUS:{
                errorStr = @"脸不是连续的";
            }break;
            case DETECTION_FAILED_TYPE_MASK:{
                errorStr = @"面具";
            }break;
            default:
                break;
        }
        [self faceVerifyFailStatistics:errorStr];

    }];
}

- (void)showErrorString:(MGLivenessDetectionFailedType)errorType {
    switch (errorType) {
        case DETECTION_FAILED_TYPE_ACTIONBLEND: {
            NSString * msgStr =  [NSString stringWithFormat:@"%@ %@\n%@", NSLocalizedString(@"key_action_live_detect", nil), NSLocalizedString(@"title_unsuccess", nil), NSLocalizedString(@"key_message_remind_complete_action", nil)];
            [kKeyWindow makeCenterToast:msgStr];
        }
            break;
        case DETECTION_FAILED_TYPE_NOTVIDEO: {
            NSString * msgStr = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"key_action_live_detect", nil), NSLocalizedString(@"title_unsuccess", nil)];
            [kKeyWindow makeCenterToast:msgStr];
        }
            break;
        case DETECTION_FAILED_TYPE_TIMEOUT: {
            NSString * msgStr = [NSString stringWithFormat:@"%@ %@\n%@", NSLocalizedString(@"key_action_live_detect", nil), NSLocalizedString(@"title_unsuccess", nil), NSLocalizedString(@"key_message_time_complete_action", nil)];
            [kKeyWindow makeCenterToast:msgStr];
        }
            break;
        default: {
            NSString * msgStr = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"key_action_live_detect", nil), NSLocalizedString(@"title_failure", nil)];
            [kKeyWindow makeCenterToast:msgStr];
        }
            break;
    }
}

#pragma mark --  人脸识别之后 人脸信息
-(void)requestUploadFaceData:(NSArray*)arrFace faceType:(UploadFileType)fileType parametDic:(NSMutableDictionary*)dicPara{
    UploadFileService * fileFace = [[UploadFileService alloc] initWithFileData:arrFace andType:fileType andParameter:dicPara];
    [fileFace requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        [SVProgressHUD dismiss];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            NSMutableDictionary * dicSave = [[NSMutableDictionary alloc] init];
            dicSave = [dicData mutableCopy];
            [dicSave setValue:@"FACE_PLUS_FACE" forKey:@"type"];
            NSString * confidenceStr = [NSString decimalNumberWithAmountStr:[dicData[@"confidence"] doubleValue]] ;
            //  公安比对成功后埋点
            [self faceVerifySucceedStatistics:confidenceStr];
            //  识别成功之后上传至服务器
            [self saveFaceInfoWithDicData:dicSave];
        } else {
            //   识别异常处理
            NSString *jsonStr = [responseDict[@"msg"] description];
            NSData* infoJsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *msgDict = infoJsonData?[NSJSONSerialization JSONObjectWithData:infoJsonData options:kNilOptions error:nil]:[[NSDictionary alloc] init];
            NSString *faceCount = [msgDict[@"count"] description];
            NSString *expireTime = [msgDict[@"expireTime"] description];
            NSString *msg = [msgDict[@"msg"] description] ? :@"";

            //  公安比对失败后埋点
            [self faceVerifyFailStatistics:msg];
            
            if ([codeStr isEqualToString:@"7001"]) {
                //  切换依图人脸识别
                if (self.delegate && [self.delegate respondsToSelector:@selector(fp_switchFaceReconnition:faceCount:expireTime:)]) {
                    [self.delegate fp_switchFaceReconnition:YiTuAuthentication faceCount:faceCount expireTime:expireTime];
                }
            } else if([codeStr isEqualToString:@"7002"]){
                //  切换face++人脸识别
                if (self.delegate && [self.delegate respondsToSelector:@selector(fp_switchFaceReconnition:faceCount:expireTime:)]) {
                    [self.delegate fp_switchFaceReconnition:FacePlusAuthentication faceCount:faceCount expireTime:expireTime];
                }
            } else if ([codeStr isEqualToString:@"1310"]){
                // 人脸识别次数
                if (self.delegate && [self.delegate respondsToSelector:@selector(fp_faceReconnition:expireTime:)]) {
                    [self.delegate fp_faceReconnition:faceCount expireTime:expireTime];
                }
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}



#pragma mark - 公安比对成功埋点
- (void)faceVerifySucceedStatistics:(NSString *)score{
    [ZTMXFUMengHelper mqEvent:k_facescan_success_faceplus_xf];
}

#pragma mark - 公安比对失败埋点
- (void)faceVerifyFailStatistics:(NSString *)error{
    [ZTMXFUMengHelper mqEvent:k_facescan_fail_faceplus_xf parameter:@{@"error":error?:@""}];
}
#pragma mark - 保存  活体识别信息
-(void)saveFaceInfoWithDicData:(NSDictionary*)dicSave{
    [SVProgressHUD showLoading];
    LSIdfSubmitInfoApi * subFaceApi = [[LSIdfSubmitInfoApi alloc]initWithParameter:dicSave saveInfoType:SubmitIdCardInfoTypeFace];
    [subFaceApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeSaveStr = [responseDict[@"code"] description];
        //氪信提交事件
        [CreditXAgent onSubmit:CXSubmitBiometricAuth result:[codeSaveStr isEqualToString:@"1000"]?YES:NO withMessage:[codeSaveStr isEqualToString:@"1000"]?@"成功":[responseDict[@"msg"] description]?:@""];
        [SVProgressHUD dismiss];
        if ([codeSaveStr isEqualToString:@"1000"]) {
            // 友盟统计 人脸识别结果
            //  上传人脸信息成功
            if (self.delegate && [self.delegate respondsToSelector:@selector(fp_uploadFaceRecognitionDataSuccess)]) {
                [self.delegate fp_uploadFaceRecognitionDataSuccess];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

@end
