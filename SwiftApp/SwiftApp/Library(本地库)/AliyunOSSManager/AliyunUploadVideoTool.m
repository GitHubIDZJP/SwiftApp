//
//  AliyunUploadVideoTool.m
//  TL
//
//  Created by mac on 2022/3/10.
//

#import "AliyunUploadVideoTool.h"
#import <VODUpload/VODUploadClient.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+TL.h"

@interface AliyunUploadVideoTool ()
{
    VODUploadClient *uploader;
}

/// 上传文件结果回调
@property(nonatomic, copy) void(^succeedBlock)(BOOL isSucceed);

/// hud圆形进度加载
@property(nonatomic, strong) MBProgressHUD *hud;

@property(nonatomic, strong) UIView *view;

@end

@implementation AliyunUploadVideoTool


+ (AliyunUploadVideoTool *)shareIncetance {
    static AliyunUploadVideoTool *tool_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool_ = [[AliyunUploadVideoTool alloc] init];
    });
    return tool_;
}


- (MBProgressHUD *)hud{
    if (_hud == nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;//圆环作为进度条
        hud.label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        hud.label.font = [UIFont systemFontOfSize:12.0f];
        hud.bezelView.color = [UIColor  blackColor];
        hud.label.text = @"";
        hud.label.text = @"等待上传";
        hud.removeFromSuperViewOnHide = YES;
        _hud = hud;
    }
    return _hud;
}


/// 获取阿里云上传凭证
- (void)uploadAuth:(NSString *)uploadAuth uploadAddress:(NSString *)uploadAddress videoId:(NSString *)videoId requestId:(NSString *)requestId cateId:(NSString *)cateId desc:(NSString *)desc filePath:(NSString *)filePath view:(UIView *)view succeedBlock:(void(^)(BOOL isSucceed))succeedBlock{
    self.view = view;
    self.succeedBlock = succeedBlock;
    // uploader
    uploader = [VODUploadClient new];
    // 超时时间
    uploader.timeoutIntervalForRequest = 20;
    // 重试次数
    uploader.maxRetryCount = 2;
    // weak items
    __weak VODUploadClient *weakClient = uploader;
    __weak AliyunUploadVideoTool *weakSelf = self;

    // callback functions and listener
    OnUploadFinishedListener testFinishCallbackFunc = ^(UploadFileInfo* fileInfo,  VodUploadResult* result){
        NSLog(@"wz on upload finished videoid:%@, imageurl:%@", result.videoId, result.imageUrl);

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.hud = nil;
            if (self.succeedBlock){
                self.succeedBlock(true);
            }
        });
    };
    
    OnUploadFailedListener testFailedCallbackFunc = ^(UploadFileInfo* fileInfo, NSString *code, NSString* message){
        NSLog(@"failed code = %@, error message = %@", code, message);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.hud = nil;
            if (self.succeedBlock){
                self.succeedBlock(false);
            }
        });
    };
    
    OnUploadTokenExpiredListener TokenExpiredCallbackFunc = ^{
        NSLog(@"upload token expired callback.");
        //token过期，设置新的上传凭证，继续上传
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.hud = nil;
            if (self.succeedBlock){
                self.succeedBlock(false);
            }
        });
    };

    
    OnUploadProgressListener testProgressCallbackFunc = ^(UploadFileInfo* fileInfo, long uploadedSize, long totalSize) {
        NSLog(@"progress uploadedSize : %li, totalSize : %li", uploadedSize, totalSize);
//        UploadFileInfo* info;
//        int i = 0;
//        for(; i<[[weakClient listFiles] count]; i++) {
//            info = [[weakClient listFiles] objectAtIndex:i];
//            if (info == fileInfo) {
//                break;
//            }
//        }
//        if (nil == info) {
//            return;
//        }

         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (self.hud != nil){

                    self.hud.progress = 1.0 *uploadedSize/totalSize;
                    if (self.hud.progress > 0.9f) {
                        
                    }else{
//                                hud.label.text = [NSString stringWithFormat:@"上传%.2f",(float)uploadedSize/totalSize*100];
                    }
             }
        });
    };
    
    
    OnUploadRertyListener testRetryCallbackFunc = ^{
        NSLog(@"manager: retry begin.");
    };
    
    OnUploadRertyResumeListener testRetryResumeCallbackFunc = ^{
        NSLog(@"manager: retry begin.");
    };
    
    OnUploadStartedListener testUploadStartedCallbackFunc = ^(UploadFileInfo* fileInfo) {
        NSLog(@"upload started .");
        // Warning:每次上传都应该是独立的uploadAuth和uploadAddress
        // Warning:demo为了演示方便，使用了固定的uploadAuth和uploadAddress
        [self.hud showAnimated:YES];
        [weakClient setUploadAuthAndAddress:fileInfo uploadAuth:uploadAuth uploadAddress:uploadAddress];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    };
    
    VODUploadListener *listener = [[VODUploadListener alloc] init];
    listener.finish = testFinishCallbackFunc;
    listener.failure = testFailedCallbackFunc;
    listener.progress = testProgressCallbackFunc;
    listener.expire = TokenExpiredCallbackFunc;
    listener.retry = testRetryCallbackFunc;
    listener.retryResume = testRetryResumeCallbackFunc;
    listener.started = testUploadStartedCallbackFunc;
    // 点播上传。每次上传都是独立的鉴权，所以初始化时，不需要设置鉴权
//    [uploader init];
    [uploader init:listener];
    
    
    VodInfo *vodInfo = [[VodInfo alloc] init];
    vodInfo.title = desc;
    vodInfo.desc = desc;
    vodInfo.cateId = [NSNumber numberWithInt:cateId.intValue];
    vodInfo.coverUrl = @"";
    vodInfo.tags = @"";
    [uploader addFile:filePath vodInfo:vodInfo];

//    // 上传文件
    [self performSelector:@selector(star) withObject:self afterDelay:1];
}

// 上传文件
- (void)star{
    [uploader start];
}


//获取当前控制器
- (UIViewController*)currentViewController {
    return [self currentViewControllerWithRootViewController:[self getKeyWindow].rootViewController];
}

//获取KeyWindow
- (UIWindow *)getKeyWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                        break;
                    }
                }
            }
        }
    }
    else {
        return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

- (UIViewController*)currentViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self currentViewControllerWithRootViewController:presentedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self currentViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self currentViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else {
        return rootViewController;
    }
}


@end
