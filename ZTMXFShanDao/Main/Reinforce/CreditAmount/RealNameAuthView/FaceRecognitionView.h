//
//  FaceRecognitionView.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceRecognitionViewDelegate <NSObject>

/** 点击人脸识别 */
- (void)faceRecognitionViewClickFace;
/** 去认证 */
- (void)faceRecognitionViewClickAuthen;

@end

@interface FaceRecognitionView : UIView

@property (nonatomic, weak) id<FaceRecognitionViewDelegate> delegate;

@end
