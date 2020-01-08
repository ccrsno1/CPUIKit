//
//  NSDate+Utils.h
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/18.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NSDateFormateType){
    NSDateFormateType1 = 0,
    NSDateFormateType2 = 1,
    NSDateFormateType3 = 2,
    NSDateFormateType4 = 3,
    NSDateFormateType5 = 4
};

@interface NSDate (Utils)
+ (NSString *)formateRemainTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)formateDateToHumanReadable:(NSTimeInterval)timeInterval;
+ (NSString *)formateDateToHumanReadable:(NSTimeInterval)timeInterval type:(NSDateFormateType)type;
+ (NSString *)formateDateToMonthDay:(NSTimeInterval)timeInterval;
@end
