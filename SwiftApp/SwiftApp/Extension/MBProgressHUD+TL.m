#import "MBProgressHUD+TL.h"
//#import "JZMyLove-Swift.h"

//设置RGB颜色
#define ZKRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]//用10进制表示颜色，例如（255,255,255）黑色

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define DelayTime  2.0f

@implementation MBProgressHUD (LC)
//window显示文字
+ (void)showInWindowMessage:(NSString *)message {
    [self showMessage:message delayTime:DelayTime isWindow:YES];
}

//window显示文字延时
+ (void)showInWindowMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showMessage:message delayTime:time isWindow:YES];
}

//window加载
+ (void)showInWindowActivityWithMessage:(NSString *)message {
    [self showActivityMessage:message isWindow:YES delayTime:DelayTime];
}

//window加载延时
+ (void)showInWindowActivityWithMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showActivityMessage:message isWindow:YES delayTime:time];
}

//window自定义图片
+ (void)showInWindowCustomImage:(NSString *)imageName message:(NSString *)message {
    [self showCustomImage:imageName message:message isWindow:YES];
}

#pragma mark - 显示在view
//view显示文字
+ (void)showInViewMessage:(NSString *)message {
    [self showMessage:message delayTime:DelayTime isWindow:NO];
}

//view显示文字延时
+ (void)showInViewMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showMessage:message delayTime:time isWindow:NO];
}

//view加载
+ (void)showInViewActivityWithMessage:(NSString *)message {
    [self showActivityMessage:message isWindow:NO delayTime:DelayTime];
    
}

//view加载延时
+ (void)showInViewActivityWithMessage:(NSString *)message delayTime:(NSInteger)time {
    [self showActivityMessage:message isWindow:NO delayTime:time];
}

//view自定义图片
+ (void)showInViewCustomImage:(NSString *)imageName message:(NSString *)message {
    [self showCustomImage:imageName message:message isWindow:NO];
}

#pragma mark - 操作结果提示
//成功提示
+ (void)showSuccessMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Success" message:message];
}

//失败提示
+ (void)showFailMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Error" message:message];
}

//警告提示
+ (void)showWarnMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Warn" message:message];
}

//信息提示
+ (void)showInfoMessage:(NSString *)message {
    [self showCustomImage:@"MBHUD_Info" message:message];
}

//默认显示在window
+ (void)showCustomImage:(NSString *)imageName message:(NSString *)message {
    [self showCustomImage:imageName message:message isWindow:YES];
}

+ (void)showProgressHudWithMessage:(NSString *)message {
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:message isWindow:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = [UIColor  blackColor];
    hud.contentColor = [UIColor whiteColor];
}

//显示进度条网络请求
+ (void)showHUD{
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:@"正在请求请稍后" isWindow:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = [UIColor  blackColor];
    hud.contentColor = [UIColor whiteColor];
}

//显示自定义提示内容进度条网络请求
+ (void)showHUDText:(NSString *)message {
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:message isWindow:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = [UIColor  blackColor];
    hud.contentColor = [UIColor whiteColor];
}

/// 显示透明背景状态中状态
+(void)showTransparentHUD {
    UIView *view = (UIView *)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.textColor = ZKRGBColor(255, 255, 255);
    hud.label.font = [UIFont systemFontOfSize:12.0f];
    hud.label.text = @"";
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.hidden = true;
    hud.contentColor = [UIColor clearColor];
}
//iOS13之后
+ (UIViewController *)currentUIViewController {
    UIWindow *keyWindow = nil;
    
    // 获取当前激活的场景
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {
            // 获取当前激活场景中的 keyWindow
            keyWindow = windowScene.windows.firstObject;
            break;
        }
    }
    
    if (!keyWindow) {
        return nil;
    }

    UIViewController *rootViewController = keyWindow.rootViewController;
    return [self topViewControllerWithRootViewController:rootViewController];
}

// 辅助方法，递归查找顶层 ViewController
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController presentedViewController]) {
        return [self topViewControllerWithRootViewController:rootViewController.presentedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBar = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBar.selectedViewController];
    } else {
        return rootViewController;
    }
}


#pragma mark - 隐藏
//隐藏
+ (void)hideHUD {
    UIView *windowView = (UIView *)[UIApplication sharedApplication].delegate.window;
    
    NSEnumerator *subviewsEnum = [windowView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subview;
            if (hud.mode == MBProgressHUDModeIndeterminate) {
                [self hideHUDForView:windowView animated:YES];
            }
        }
    }
 
    UIViewController *currentVC = [self currentUIViewController];
        if (currentVC) {
            [self hideHUDForView:currentVC.view animated:YES];
        }
}



#pragma mark - Private
/**
 加载动态图片
 */
+ (void)showActivityMessage:(NSString*)message
                   isWindow:(BOOL)isWindow
                  delayTime:(NSInteger)delayTime {
    
    MBProgressHUD *hud  = [self createMBProgerssHUDWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.activityIndicatorColor = [UIColor whiteColor];
    hud.label.textColor=[UIColor whiteColor];
    hud.bezelView.color = [UIColor  blackColor];
    hud.square = YES;
    if (delayTime > 0) {
        [hud hideAnimated:YES afterDelay:0.7];
    }
  
}

/**
 自定义图片
 */
+ (void)showCustomImage:(NSString *)imageName
                message:(NSString *)message
               isWindow:(BOOL)isWindow {
    
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeCustomView;
    hud.square = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = ZKRGBColor(30, 30, 30);
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    [hud hideAnimated:YES afterDelay:2.0];
}

/**
 显示信息延时
 */
+ (void)showMessage:(NSString *)message
          delayTime:(NSInteger)delayTime
           isWindow:(BOOL)isWindow {
    
    MBProgressHUD *hud = [self createMBProgerssHUDWithMessage:nil isWindow:isWindow];
    hud.detailsLabel.text=message;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor =ZKRGBColor(30, 30, 30);
    hud.detailsLabel.font = [UIFont systemFontOfSize:15.0f];
    //设置大小
    hud.minSize = CGSizeMake(200,50);
    [hud hideAnimated:YES afterDelay:delayTime];
}

/**
 显示信息
 */
+ (MBProgressHUD *)createMBProgerssHUDWithMessage:(NSString *)message isWindow:(BOOL)isWindow {
    
    UIView *view = isWindow ? (UIView *)[UIApplication sharedApplication].delegate.window : [self currentUIViewController].view;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.textColor = ZKRGBColor(255, 255, 255);
    hud.label.font = [UIFont systemFontOfSize:12.0f];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

//获取屏幕当前显示的ViewController
+ (UIViewController *)currentWindowViewController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootViewController = window.rootViewController;

    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }

    return rootViewController;
}




@end
