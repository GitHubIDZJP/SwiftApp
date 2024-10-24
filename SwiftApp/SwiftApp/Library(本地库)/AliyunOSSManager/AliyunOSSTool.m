//
//  AliyunOSSTool.m
//  DayChatiOS
//
//  Created by lekai on 2021/8/12.
//

#import "AliyunOSSTool.h"


/* 阿里云存储相关信息 */
#define kAiAccessKey            @"LTAI5tS5H4rzB6mNNHKfSE9J"
#define kAliAccessSecret        @"10sehprVX1IwtjYDSXWUxKTVpchFtm"
#define kAliBucketName          @"file-tianliao"
#define kAliImageURLPrefix      @"https://file-tianliao.oss-cn-shenzhen.aliyuncs.com/"
#define kAliEndPoint            @"https://oss-cn-shenzhen.aliyuncs.com"



@interface AliyunOSSTool ()
@property (nonatomic,strong) NSMutableArray *dataSourece;
@end

@implementation AliyunOSSTool


+ (AliyunOSSTool *)shareIncetance {
    static AliyunOSSTool *tool_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool_ = [[AliyunOSSTool alloc] init];
    });
    return tool_;
}

- (NSMutableArray *)dataSourece {
    if (!_dataSourece) {
        _dataSourece = [[NSMutableArray alloc] init];
    }
    return _dataSourece;
}

+ (void)upLoadImageWithImageData:(NSData *)imageData AliBucketName:(NSString*)AliBucketName AliImageURLPrefix:(NSString*)AliImageURLPrefix success:(void (^)(NSString *objectKey))successBlock faile:(void (^)(NSError *error))faile {

    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = AliBucketName;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeStamp =[dat timeIntervalSince1970]*1000;
//    NSString *objectKey  = [NSString stringWithFormat:@"%@/%ld-%d.png",@"customer",(long)timeStamp + arc4random()%1000 +arc4random()%1000000,arc4random()%1000000];
    
    NSString *objectKey  = [NSString stringWithFormat:@"%@/%ld.png",@"tomer",(long)timeStamp + arc4random()%1000 +arc4random()%1000000];
    put.objectKey = objectKey;
    put.uploadingData = imageData; // 直接上传NSData
    OSSTask * putTask = [[AliyunOSSTool shareIncetance].client putObject:put];
    // 上传阿里云
    [putTask continueWithBlock:^id(OSSTask *task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!task.error) {
                NSLog(@"上传图片路径 %@", [NSString stringWithFormat:@"%@/%@",AliImageURLPrefix,objectKey]);
                
                if (successBlock) {
                    successBlock([NSString stringWithFormat:@"%@/%@",AliImageURLPrefix,objectKey]);
                }
                
                
            } else {
                NSLog(@"上传失败 %@",task.error);
            }
        });
        return nil;
    }];
}

/**
 这个方法用于上传多张图片到里云上
 @param imageDataArray 二进制图片数组

 @param successBlock 上传成功后的回调，你可以在这里处理UI
 @param faile        上传失败会走的回调
 */
- (void)upLoadImageWithImageDataArray:(NSArray *)imageDataArray success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *error))faile {
    [self.dataSourece removeAllObjects];

    for (NSInteger i= 0; i<imageDataArray.count ; i ++) {
        [self.dataSourece addObject:@"notValue"];
        [self uploadOneImage:[imageDataArray objectAtIndex:i] oSSClient:[AliyunOSSTool shareIncetance].client currentIndex:i  success:successBlock faile:faile];
    }
}





- (void)uploadOneImage:(NSData *)imageData oSSClient:(OSSClient *)client currentIndex:(NSInteger)index  success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *))faile {
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = kAliBucketName;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeStamp =[dat timeIntervalSince1970]*1000;
    NSString *objectKey  = [NSString stringWithFormat:@"%@/%ld.png",@"customer",(long)timeStamp+10000*index];
    put.objectKey =objectKey;
    put.uploadingData = imageData; // 直接上传NSData
    OSSTask * putTask = [client putObject:put];
    // 上传阿里云
    [putTask continueWithBlock:^id(OSSTask *task) {
        task = [client presignPublicURLWithBucketName:kAliBucketName withObjectKey:objectKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!task.error) {
                [self.dataSourece replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%@%@",kAliImageURLPrefix,objectKey]];
                if (![self.dataSourece containsObject:@"notValue"]) {
                    if (successBlock) {
                        if (self.dataSourece.count < 1 || self.dataSourece == nil) {
                            if (faile) {
                                faile(task.error);
                            }
                            return;
                        }
                        successBlock(self.dataSourece);
                    }
                }
            } else {
                [self.dataSourece removeAllObjects];
                if (faile) {
                    faile(task.error);
                }
            }
        });
        return nil;
    }];
}




//新的 本app
- (void)NewUpLoadImageWithImageDataArrays:(NSArray *)imageDataArray AliBucketName:(NSString*)AliBucketName AliImageURLPrefix:(NSString*)AliImageURLPrefix success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *error))faile {
    [self.dataSourece removeAllObjects];

    for (NSInteger i= 0; i<imageDataArray.count ; i ++) {
        [self.dataSourece addObject:@"notValue"];
      
        [self uploadOneImages:[imageDataArray objectAtIndex:i] oSSClient:[AliyunOSSTool shareIncetance].client currentIndex:i AliBucketName:AliBucketName AliImageURLPrefix:AliImageURLPrefix success:successBlock faile:faile];
    }
}



- (void)uploadOneImages:(NSData *)imageData oSSClient:(OSSClient *)client currentIndex:(NSInteger)index AliBucketName:(NSString*)AliBucketName AliImageURLPrefix:(NSString*)AliImageURLPrefix success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *))faile {
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = AliBucketName;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeStamp =[dat timeIntervalSince1970]*1000;
    NSString *objectKey  = [NSString stringWithFormat:@"%@/%ld.png",@"customer",(long)timeStamp+10000*index];
    put.objectKey =objectKey;
    put.uploadingData = imageData; // 直接上传NSData
    OSSTask * putTask = [client putObject:put];
    // 上传阿里云
    [putTask continueWithBlock:^id(OSSTask *task) {
        task = [client presignPublicURLWithBucketName:AliBucketName withObjectKey:objectKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!task.error) {
                [self.dataSourece replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%@/%@",AliImageURLPrefix,objectKey]];
                if (![self.dataSourece containsObject:@"notValue"]) {
                    if (successBlock) {
                        if (self.dataSourece.count < 1 || self.dataSourece == nil) {
                            if (faile) {
                                faile(task.error);
                            }
                            return;
                        }
                        successBlock(self.dataSourece);
                    }
                }
            } else {
                [self.dataSourece removeAllObjects];
                if (faile) {
                    faile(task.error);
                }
            }
        });
        return nil;
    }];
}


@end
