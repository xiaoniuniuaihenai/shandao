//
//  XHLaunchAd.h
//  XHLaunchAdExample
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XHLaunchAdConfiguration.h"
#import "XHLaunchAdConst.h"
#import "XHLaunchImageView.h"

NS_ASSUME_NONNULL_BEGIN
@class XHLaunchAd;
@protocol XHLaunchAdDelegate <NSObject>
@optional

/**
 *  广告点击
 *
 *  @param launchAd      launchAd
 *  @param openURLString  打开页面地址
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString;

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image;

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData;

/**
 *  video本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  本地保存路径
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL;

/**
 视频下载进度回调

 @param launchAd XHLaunchAd
 @param progress 下载进度
 @param total    总大小
 @param current  当前已下载大小
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current;

/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration;

/**
  广告显示完成

 @param launchAd XHLaunchAd
 */
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd;

/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理,注意:实现此方法后,图片缓存将不受XHLaunchAd管理

 @param launchAd          XHLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url;

#pragma mark - 过期
/** 请使用xhLaunchAdShowFinish: */
-(void)xhLaunchShowFinish:(XHLaunchAd *)launchAd;
@end

@interface XHLaunchAd : NSObject

@property(nonatomic,assign) id<XHLaunchAdDelegate> delegate;

/**
 设置你工程的启动页使用的是LaunchImage还是LaunchScreen(default:LaunchImagesSourceLaunchImage)
 注意:请在设置等待数据及配置广告数据前调用此方法
 @param launchImagesSource launchImagesSource
 */
+(void)setLaunchImagesSource:(LaunchImagesSource)launchImagesSource;

/**
 *  设置等待数据源时间(建议值:3)
 *
 *  @param waitDataDuration waitDataDuration
 */
+(void)setWaitDataDuration:(NSInteger )waitDataDuration;

/**
 *  图片开屏广告数据配置
 *
 *  @param imageAdconfiguration 数据配置
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)imageAdWithImageAdConfiguration:(XHLaunchImageAdConfiguration *)imageAdconfiguration;

/**
 *  图片开屏广告数据配置
 *
 *  @param imageAdconfiguration 数据配置
 *  @param delegate             delegate
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)imageAdWithImageAdConfiguration:(XHLaunchImageAdConfiguration *)imageAdconfiguration delegate:(nullable id)delegate;
/**
 *  视频开屏广告数据配置
 *
 *  @param videoAdconfiguration 数据配置
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)videoAdWithVideoAdConfiguration:(XHLaunchVideoAdConfiguration *)videoAdconfiguration;

/**
 *  视频开屏广告数据配置
 *
 *  @param videoAdconfiguration 数据配置
 *  @param delegate             delegate
 *
 *  @return XHLaunchAd
 */
+(XHLaunchAd *)videoAdWithVideoAdConfiguration:(XHLaunchVideoAdConfiguration *)videoAdconfiguration delegate:(nullable id)delegate;

#pragma mark -批量下载并缓存
/**
 *  批量下载并缓存image(异步) - 已缓存的image不会再次下载缓存
 *
 *  @param urlArray image URL Array
 */
+(void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray;

/**
 批量下载并缓存image,并回调结果(异步)- 已缓存的image不会再次下载缓存

 @param urlArray image URL Array
 @param completedBlock 回调结果为一个字典数组,url:图片的url字符串,result:0表示该图片下载缓存失败,1表示该图片下载并缓存完成或本地缓存中已有该图片
 */
+(void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray completed:(nullable XHLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;

/**
 *  批量下载并缓存视频(异步) - 已缓存的视频不会再次下载缓存
 *
 *  @param urlArray 视频URL Array
 */
+(void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray;

/**
 批量下载并缓存视频,并回调结果(异步) - 已缓存的视频不会再次下载缓存
 
 @param urlArray 视频URL Array
 @param completedBlock 回调结果为一个字典数组,url:视频的url字符串,result:0表示该视频下载缓存失败,1表示该视频下载并缓存完成或本地缓存中已有该视频
 */
+(void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray completed:(nullable XHLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;

#pragma mark - Action

/**
 *  跳过按钮事件
 */
+(void)skipAction XHLaunchAdDeprecated("请使用removeAndAnimated:");

/**
 手动移除广告

 @param animated 是否需要动画
 */
+(void)removeAndAnimated:(BOOL)animated;

#pragma mark - 是否已缓存
/**
 *  是否已缓存在该图片
 *
 *  @param url image url
 *
 *  @return BOOL
 */
+(BOOL)checkImageInCacheWithURL:(NSURL *)url;

/**
 *  是否已缓存该视频
 *
 *  @param url video url
 *
 *  @return BOOL
 */
+(BOOL)checkVideoInCacheWithURL:(NSURL *)url;

#pragma mark - 获取缓存url
/**
 从缓存中获取上一次的ImageURLString(XHLaunchAd 会默认缓存imageURLString)
 
 @return imageUrlString
 */
+(NSString *)cacheImageURLString;

/**
 从缓存中获取上一次的videoURLString(XHLaunchAd 会默认缓存VideoURLString)
 
 @return videoUrlString
 */
+(NSString *)cacheVideoURLString;

#pragma mark - 缓存/清理相关
/**
 *  清除XHLaunchAd本地所有缓存(异步)
 */
+(void)clearDiskCache;

/**
 清除指定Url的图片本地缓存(异步)

 @param imageUrlArray 需要清除缓存的图片Url数组
 */
+(void)clearDiskCacheWithImageUrlArray:(NSArray<NSURL *> *)imageUrlArray;

/**
 清除指定Url除外的图片本地缓存(异步)
 
 @param exceptImageUrlArray 此url数组的图片缓存将被保留
 */
+(void)clearDiskCacheExceptImageUrlArray:(NSArray<NSURL *> *)exceptImageUrlArray;

/**
 清除指定Url的视频本地缓存(异步)

 @param videoUrlArray 需要清除缓存的视频url数组
 */
+(void)clearDiskCacheWithVideoUrlArray:(NSArray<NSURL *> *)videoUrlArray;

/**
 清除指定Url除外的视频本地缓存(异步)
 
 @param exceptVideoUrlArray 此url数组的视频缓存将被保留
 */
+(void)clearDiskCacheExceptVideoUrlArray:(NSArray<NSURL *> *)exceptVideoUrlArray;

/**
 *  获取XHLaunch本地缓存大小(M)
 */
+(float)diskCacheSize;

/**
 *  缓存路径
 */
+(NSString *)xhLaunchAdCachePath;

@end
NS_ASSUME_NONNULL_END
