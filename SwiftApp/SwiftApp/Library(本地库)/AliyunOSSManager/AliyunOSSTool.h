//
//  AliyunOSSTool.h
//  DayChatiOS
//
//  Created by lekai on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import "AliyunOSSiOS.h"

NS_ASSUME_NONNULL_BEGIN

@interface AliyunOSSTool : NSObject

@property(nonatomic,strong) OSSClient * client;

/**
 返回对象

 @return AliUpLoadImageTool
 */
+ (AliyunOSSTool *)shareIncetance;


/**
 这个方法用于上传单张图片到阿里云
 
 @param parmar       这是参数是一个字典，直接将后台的字典传入
 @param successBlock 上传成功后的回调，你可以在这里处理UI
 @param faile        上传失败会走的回调
 */
//+(void)upLoadImageWithImageData:(NSData *)imageData success:(void (^)(NSString *objectKey))successBlock faile:(void (^)(NSError *error))faile;


+ (void)upLoadImageWithImageData:(NSData *)imageData AliBucketName:(NSString*)AliBucketName AliImageURLPrefix:(NSString*)AliImageURLPrefix success:(void (^)(NSString *objectKey))successBlock faile:(void (^)(NSError *error))faile;
/**
 这个方法用于上传多张图片到里云上
 
 @param parmar       这是参数是一个字典，直接将后台的字典传入
 @param successBlock 上传成功后的回调，你可以在这里处理UI
 @param faile        上传失败会走的回调
 */
- (void)upLoadImageWithImageDataArray:(NSArray *)imageDataArray success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *error))faile;



//新的 本app
- (void)NewUpLoadImageWithImageDataArrays:(NSArray *)imageDataArray AliBucketName:(NSString*)AliBucketName AliImageURLPrefix:(NSString*)AliImageURLPrefix success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *error))faile;
@end

NS_ASSUME_NONNULL_END
