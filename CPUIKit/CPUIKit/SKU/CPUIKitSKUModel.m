//
//  CPUIKitSKUModel.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/6/25.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKitSKUModel.h"

@implementation CPUIKitSKUSpecificationModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"specType":@"spec_type",@"specNames":@"spec_names"}];
}
@end

@implementation CPUIKitSKUConditionModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"skuID":@"sku_id", @"origPrice":@"origin_price", @"condition":@"name"}];
}

@end


@implementation CPUIKitSKUModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"specifications":@"spec_temp", @"conditions":@"specs"}];
}
@end
