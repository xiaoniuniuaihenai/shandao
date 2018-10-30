//
//  XHLaunchAdManager.m
//  XHLaunchAdExample
//

#import "XHLaunchAdManager.h"
#import "XHLaunchAd.h"
#import "AppDelegate.h"
#import "LaunchAdModel.h"
#import "UIViewController+Nav.h"
#import "LSWebViewController.h"
#import "ZTMXFLSShareViewLaunchImageApi.h"
#import "TabBarControllerConfig.h"
@interface XHLaunchAdManager()<XHLaunchAdDelegate>

@end

@implementation XHLaunchAdManager
- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
            [self setupXHLaunchAd];
        }];
    }
    return self;
}
+(void)load{
    [self shareManager];
}

+(XHLaunchAdManager *)shareManager{
    static XHLaunchAdManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[XHLaunchAdManager alloc] init];
    });
    return instance;
}



-(void)setupXHLaunchAd{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchImagesSource:LaunchImagesSourceLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:1];
    //广告数据请求
    ZTMXFLSShareViewLaunchImageApi *api = [[ZTMXFLSShareViewLaunchImageApi alloc] init];
        [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSInteger check = [responseDict[@"data"][@"check"] integerValue];
//            check = 1;
            if (check == 1) {
                //  骨头中
                [LoginManager saveAppReviewState:YES];
            } else {
                //  非骨头状态
                [LoginManager saveAppReviewState:NO];
            }
            [TabBarControllerConfig changeTabBar];
            NSDictionary *dataDict = responseDict[@"data"];
            NSString *imageUrlString = [dataDict[@"imageUrl"] description];
            NSString *advertiseUrl = [dataDict[@"advertiseUrl"] description];
            if (![LoginManager appReviewState]) {
                //广告数据转模型
                LaunchAdModel *model = [[LaunchAdModel alloc] init];
                model.duration = 3;
                model.content = imageUrlString;
                model.openUrl = advertiseUrl;
                if ([model.content hasSuffix:@"mp4"]) {
                    model.duration = 5;
                    [self loadLaunchVideoAdvertisement:model];
                } else {
                    [self loadLaunchImageAdvertisement:model];
                }
            }
        } else {
            [LoginManager saveAppReviewState:YES];
            [TabBarControllerConfig changeTabBar];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [LoginManager saveAppReviewState:YES];
        [TabBarControllerConfig changeTabBar];
    }];
}

#pragma mark - 图片开屏广告-网络数据-示例
//  视频广告
- (void)loadLaunchVideoAdvertisement:(LaunchAdModel *)adModel{
    //配置广告数据
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = adModel.duration;
    //广告frame
    
    if (IS_IPHONEX) {
        videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, AdaptedHeight(560.0));
    } else {
        videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, AdaptedHeight(540.0));
    }
    //广告视频URLString/或本地视频名(请带上后缀)
    //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
    videoAdconfiguration.videoNameOrURLString = adModel.content;
    //视频缩放模式
    videoAdconfiguration.scalingMode = MPMovieScalingModeAspectFill;
    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = NO;
    //广告点击打开链接
    videoAdconfiguration.openURLString = adModel.openUrl;
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeTimeText;
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
    
}
//  图片广告
- (void)loadLaunchImageAdvertisement:(LaunchAdModel *)adModel{
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = adModel.duration;
    //广告frame
    if (IS_IPHONEX) {
        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, AdaptedHeight(560.0));
    } else {
        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, AdaptedHeight(540.0));
    }
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = adModel.content;
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //缓存机制(仅对网络图片有效)
    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
    imageAdconfiguration.imageOption = XHLaunchAdImageCacheInBackground;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开链接
    imageAdconfiguration.openURLString = adModel.openUrl;
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}



#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView{
    
    CGFloat y = XH_IPHONEX ? 46:22;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, y, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

-(NSArray<UIView *> *)launchAdSubViews{
    
    CGFloat y = XH_IPHONEX ? 54 : 30;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-170, y, 60, 30)];
    label.text  = @"subViews";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

#pragma mark - customSkipView
//自定义跳过按钮
-(UIView *)customSkipView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor orangeColor];
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    CGFloat y = XH_IPHONEX ? 54 : 30;
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,y, 85, 30);
    [button addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//跳过按钮点击事件
-(void)skipAction{
    //移除广告
    [XHLaunchAd removeAndAnimated:YES];
}

#pragma mark - XHLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration{
    //设置自定义跳过按钮时间
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    //设置时间
    [button setTitle:[NSString stringWithFormat:@"自定义%lds",duration] forState:UIControlStateNormal];
}

#pragma mark - XHLaunchAd delegate - 其他

/**
 *  广告点击事件 回调
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString{
    
    NSLog(@"广告点击");
    LSWebViewController *VC = [[LSWebViewController alloc] init];
    VC.webUrlStr = openURLString;
    //此处不要直接取keyWindow
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.myNavigationController pushViewController:VC animated:YES];
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(nonnull NSData *)imageData{
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}

/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL{
    
    NSLog(@"video下载/加载完成/保存path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current{
    NSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
    
}

/**
 *  广告显示完成
 */
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd{
    
     NSLog(@"广告显示完成");
}

/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理(实现此方法后,图片缓存将不受XHLaunchAd管理)
 
 @param launchAd          XHLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
//-(void)xhLaunchAd:(XHLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url
//{
//    [launchAdImageView sd_setImageWithURL:url];
//
//}

@end
