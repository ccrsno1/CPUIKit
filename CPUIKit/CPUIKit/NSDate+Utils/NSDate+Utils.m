//
//  NSDate+Utils.m
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/18.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

+ (NSString *)formateRemainTimeInterval:(NSTimeInterval)timeInterval{
    NSInteger remainTime = timeInterval >= 0? [@(timeInterval) integerValue] : 0;
    NSInteger minutes = (remainTime % (3600*24))%3600/60;
    NSInteger hours = (remainTime % (3600*24))/3600;
    NSInteger days = remainTime/(3600*24);
    if (days > 0) {
        return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟",(long)days, (long)hours, (long)minutes];
    }else if (hours > 0){
        return [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hours, (long)minutes];
    }else{
        return [NSString stringWithFormat:@"%ld分钟",(long)minutes];
    }
}

+ (NSString *)formateDateToHumanReadable:(NSTimeInterval)timeInterval{
    return [self formateDateToHumanReadable:timeInterval type:NSDateFormateType1];
}

+ (NSString *)formateDateToHumanReadable:(NSTimeInterval)timeInterval type:(NSDateFormateType)type{
    switch (type) {
        case NSDateFormateType1:{
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
            return [NSString stringWithFormat:@"%ld月%ld日 %02ld:%02ld", components.month, components.day, components.hour, components.minute];

        }
            break;
        case NSDateFormateType2:{
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
            return [NSString stringWithFormat:@"%ld.%ld.%ld", components.year, components.month, components.day];
        }
            break;
        case NSDateFormateType3:{
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
            return [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld", components.year, components.month, components.day, components.hour, components.minute];
        }
            break;
        case NSDateFormateType4:{
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
            return [NSString stringWithFormat:@"%ld-%02ld-%02ld", components.year, components.month, components.day];
        }
            break;
            
        case NSDateFormateType5:{
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
            return [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld", components.year, components.month, components.day, components.hour, components.minute, components.second];
        }

        default:
            break;
    }
}

+ (NSString *)formateDateToMonthDay:(NSTimeInterval)timeInterval{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return [NSString stringWithFormat:@"%ld月%ld日", components.month, components.day];
}

@end
