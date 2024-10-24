#import <MBProgressHUD/MBProgressHUD.h>


@interface MBProgressHUD (LC)
#pragma mark - 显示在window

//window显示文字
+ (void)showInWindowMessage:(NSString *)message;

//window显示文字延时
+ (void)showInWindowMessage:(NSString *)message delayTime:(NSInteger)time;

//window加载
+ (void)showInWindowActivityWithMessage:(NSString *)message;

//window加载延时
+ (void)showInWindowActivityWithMessage:(NSString *)message delayTime:(NSInteger)time;

//window自定义图片
+ (void)showInWindowCustomImage:(NSString *)imageName message:(NSString *)message;

#pragma mark - 显示在view
//view显示文字
+ (void)showInViewMessage:(NSString *)message;

//view显示文字延时
+ (void)showInViewMessage:(NSString *)message delayTime:(NSInteger)time;

//view加载
+ (void)showInViewActivityWithMessage:(NSString *)message;

//view加载延时
+ (void)showInViewActivityWithMessage:(NSString *)message delayTime:(NSInteger)time;

//view自定义图片
+ (void)showInViewCustomImage:(NSString *)imageName message:(NSString *)message;

#pragma mark - 操作结果提示
//成功提示
+ (void)showSuccessMessage:(NSString *)message;

//失败提示
+ (void)showFailMessage:(NSString *)message;

//警告提示
+ (void)showWarnMessage:(NSString *)message;

//信息提示
+ (void)showInfoMessage:(NSString *)message;

//显示进度条
+ (void)showProgressHudWithMessage:(NSString *)message;

//显示进度条网络请求
+ (void)showHUD;
//显示自定义提示内容进度条网络请求
+ (void)showHUDText:(NSString *)message;
/// 显示透明背景状态中状态
+(void)showTransparentHUD;
#pragma mark - 隐藏
//隐藏
+ (void)hideHUD;

@end
