//
//  JBFaceRecognitionViewController.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ZTMXFJBFaceRecognitionViewController.h"
#import "LSIdfBindCardViewController.h"
#import "FaceRecognitionView.h"
#import "ZTMXFFacePlusManager.h"
#import "RealNameManager.h"
#import "LSFaceAlertView.h"
#import "LSFaceTimesLimitAlertView.h"
#import "JBScanIdentityCardViewController.h"
#import "ZTMXFRateAlertView.h"
#import "ZTMXFFaceFailerAlertView.h"

@interface ZTMXFJBFaceRecognitionViewController ()<FaceRecognitionViewDelegate, FacePlusManagerDelgate,LSFaceAlertViewDelegete,LSFaceLimitAlertViewDelegete>{
    NSDictionary                *_latitudeAndLongitude;
}
@property (nonatomic, strong) FaceRecognitionView *faceRecognitionView;
/** face++ */
@property (nonatomic, strong) ZTMXFFacePlusManager *facePlusManager;

@end

@implementation ZTMXFJBFaceRecognitionViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脸识别";
    self.view.backgroundColor = [UIColor clearColor];
//    [self configueSubviews];
    self.fd_interactivePopDisabled = YES;
//    self.pageTag = 3003;
    // 人脸识别页面uv
    [self enterIdCardPageStatistics];
    [XLServerBuriedPointHelper longitudeAndLatitude:^(NSDictionary *latitudeAndLongitude) {
        _latitudeAndLongitude = latitudeAndLongitude;
    }];
}



/** 返回最开始的页面 */
- (void)clickReturnBackEvent{
    [RealNameManager realNameBackSuperVc:self];
}

#pragma mark - 自定义代理方法
#pragma mark - LSFaceAlertViewDelegete
#pragma mark - 点击再试试按钮
- (void)clickTryButton{
    
        //  face++ 人脸识别
    [self.facePlusManager fp_beginFaceRecognition:self];
}

#pragma mark - LSFaceLimitAlertViewDelegete
#pragma mark - 点击我知道了按钮


/** 开始人脸识别 */
- (void)startFaceRecognition{
    [self.facePlusManager fp_beginFaceRecognition:self];
   
}

/** 点击人脸识别 */
- (void)faceRecognitionViewClickFace{
    [self.facePlusManager fp_beginFaceRecognition:self];
  
}

/** 去认证 */
- (void)faceRecognitionViewClickAuthen{
    [self.facePlusManager fp_beginFaceRecognition:self];
}

- (void)clickKnowButton
{
    [RealNameManager realNameBackSuperVc:self];
}

/** 切换人脸扫描 */


#pragma mark 人脸识别
/** 人脸识别成功 */
- (void)fp_faceRecognitionSuccess{
    [self dismissViewControllerAnimated:YES completion:nil];

}
/** 人脸识别失败 */
- (void)fp_faceRecognitionFailure{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view makeCenterToast:@"人脸识别失败，请重新提交识别"];
}
/** 人脸识别取消 */
- (void)fp_faceRecognitionCancel{
    [self dismissViewControllerAnimated:YES completion:nil];

}

/** 上传人脸信息成功 */
- (void)fp_uploadFaceRecognitionDataSuccess{
    // 跳转到绑卡页面
    if (_isAddBankCard) {
        LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
        bankVc.isAddBankCard = _isAddBankCard;
        bankVc.bindCardType = BindBankCardTypeMain;
        bankVc.loanType = _loanType;
        [self.navigationController pushViewController:bankVc animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/** 切换人脸扫描 */
- (void)fp_switchFaceReconnition:(RealNameAuthenticationType)authType faceCount:(NSString *)faceCount expireTime:(NSString *)time{
    _authType = authType;
    // 显示人脸认证次数弹窗
    [self alertFaceViewWithFaceCount:faceCount expireTime:time];
    
    JBScanIdentityCardViewController *scanIdVC = (JBScanIdentityCardViewController *)self.parentViewController;
    scanIdVC.authType = _authType;
}

/** 人脸次数认证 */
- (void)fp_faceReconnition:(NSString *)faceCount expireTime:(NSString *)time{
    // 显示人脸认证次数弹窗
    [self alertFaceViewWithFaceCount:faceCount expireTime:time];
}

#pragma mark - 根据返回状态弹出不同的提示框
- (void)alertFaceViewWithFaceCount:(NSString *)faceCount expireTime:(NSString *)time{
    if ([faceCount isEqualToString:@"0"]) {

        [ZTMXFRateAlertView showWithTitle:@"识别次数超限" message:time style:ZTMXFRateAlertViewNoNumber clickBlock:^{
            [RealNameManager realNameBackSuperVc:self];
        }];

    }else{
        @WeakObj(self);
        [ZTMXFFaceFailerAlertView showWithCountStr:faceCount click:^{
            NSMutableDictionary *pointInfo = [[NSMutableDictionary alloc]init];
            [pointInfo setObject:[XLServerBuriedPointHelper wifiName] forKey:@"wifiName"];
            [pointInfo setObject:[XLServerBuriedPointHelper wifiMac] forKey:@"wifiMac"];
            [_latitudeAndLongitude enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [pointInfo setObject:obj forKey:key];
            }];
            //后台打点
            [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_smrz_zcrz" OtherDict:pointInfo];
            [selfWeak clickTryButton];
        }];
    }
}

#pragma mark - 添加子视图
- (void)configueSubviews{
//    [self.view addSubview:self.faceRecognitionView];
//    self.faceRecognitionView.frame = CGRectMake(0.0, 0, KW, KH);
}



- (FaceRecognitionView *)faceRecognitionView{
    if (_faceRecognitionView == nil) {
        _faceRecognitionView = [[FaceRecognitionView alloc] init];
        _faceRecognitionView.delegate = self;
    }
    return _faceRecognitionView;
}

- (ZTMXFFacePlusManager *)facePlusManager{
    if (_facePlusManager == nil) {
        _facePlusManager = [[ZTMXFFacePlusManager alloc] init];
        _facePlusManager.delegate = self;
        _facePlusManager.citizen_id = _citizen_id;
        _facePlusManager.realName = _realName;
    }
    return _facePlusManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"JBFaceRecognitionViewController---------------");
}

#pragma mark - 扫脸页面uv
- (void)enterIdCardPageStatistics{
   
}


@end
