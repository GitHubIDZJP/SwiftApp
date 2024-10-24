//
//  Person.h
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
- (void)eat;
@end

NS_ASSUME_NONNULL_END
