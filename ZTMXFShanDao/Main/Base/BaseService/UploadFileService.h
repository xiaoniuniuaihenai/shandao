//
//  UploadFileService.h
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/28.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//  上传文件

#import "BaseRequestSerivce.h"
typedef NS_ENUM(NSInteger,UploadFileType){
    UploadFileTypeDef=0, //文件服务器
    UploadFileTypeYiTuFace,  //人脸识别
    UploadFileTypeFaceForFace, // face++
};
@interface UploadFileService : BaseRequestSerivce

- (instancetype)initWithFileData:(NSArray *)fileDatas andType:(UploadFileType)type andParameter:(NSDictionary*)rqParameter;

@end
