//
//  Person.m
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

#import "Person.h"

@implementation Person
-(void)eat{
    NSString *result = [NSString stringWithFormat:@"%@吃饭了SDSDSD", self.name];
    NSLog(@"%@", result);
}
@end
