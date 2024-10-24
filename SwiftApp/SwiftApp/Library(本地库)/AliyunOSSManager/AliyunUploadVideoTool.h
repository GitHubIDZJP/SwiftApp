//
//  AliyunUploadVideoTool.h
//  TL
//
//  Created by mac on 2022/3/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "TLVoiceSynthesis.h"
NS_ASSUME_NONNULL_BEGIN

@interface AliyunUploadVideoTool : NSObject

/**
 返回对象

 @return AliUpLoadImageTool
 */
+ (AliyunUploadVideoTool *)shareIncetance;

/// 获取阿里云上传凭证
- (void)uploadAuth:(NSString *)uploadAuth uploadAddress:(NSString *)uploadAddress videoId:(NSString *)videoId requestId:(NSString *)requestId cateId:(NSString *)cateId desc:(NSString *)desc filePath:(NSString *)filePath view:(UIView *)view succeedBlock:(void(^)(BOOL isSucceed))succeedBlock;

@end

NS_ASSUME_NONNULL_END
