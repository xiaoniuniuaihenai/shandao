//
//  FacePlusManager.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/23.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MGIDCard/MGIDCard.h>
@class IdentityFrontInfoModel;
@class IdentityBackInfoModel;

@protocol FacePlusManagerDelgate<NSObject>

@optional
#pragma mark  身份证识别
/** 识别身份证图片成功 */
- (void)fp_scanIdentityIdSuccess:(UIImage *)image cardType:(MGIDCardSide)type;;
/** 正面身份证上传成功 */
- (void)fp_uploadIdentityFrontImageSuccess:(IdentityFrontInfoModel *)frontInfoModel;
/** 反面身份证上传成功 */
- (void)fp_uploadIdentityBackImageSuccess:(IdentityBackInfoModel *)backInfoModel;

/** 提交正反面身份证证信息成功 */
- (void)fp_submitIdentityFrontBackImagesSuccess;

/** 取消身份证识别 */
- (void)fp_scanIdentityIdCancel;

/** 切换身份证扫描 */
- (void)fp_switchScanIdentity:(RealNameAuthenticationType)authType;


#pragma mark 人脸识别
/** 人脸识别成功 */
- (void)fp_faceRecognitionSuccess;
/** 人脸识别失败 */
- (void)fp_faceRecognitionFailure;
/** 人脸识别取消 */
- (void)fp_faceRecognitionCancel;

/** 上传人脸信息成功 */
- (void)fp_uploadFaceRecognitionDataSuccess;

/** 切换人脸扫描 */
- (void)fp_switchFaceReconnition:(RealNameAuthenticationType)authType faceCount:(NSString *)faceCount expireTime:(NSString *)time;

/** 人脸次数限制回调 */
- (void)fp_faceReconnition:(NSString *)faceCount expireTime:(NSString *)time;

@end

@interface ZTMXFFacePlusManager : NSObject
/** 身份证ID */
@property (nonatomic, copy) NSString *citizen_id;
/** 姓名 */
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, weak) id<FacePlusManagerDelgate> delegate;

#pragma 扫描身份证
/** 扫描身份证图片 */
- (void)fp_scanIdentityID:(MGIDCardSide)cardType viewController:(UIViewController *)controller;
/** 上传身份证图片 */
- (void)fp_uploadIdentityIdImage:(UIImage *)image cardType:(MGIDCardSide)cardType;
/** 提交正反面身份证证信息 */
- (void)fp_submitIdentityFrontBackImagesWithEditName:(NSString *)editName;


#pragma mark 人脸识别
/** 开始人脸识别 */
- (void)fp_beginFaceRecognition:(UIViewController *)controller;

@end
