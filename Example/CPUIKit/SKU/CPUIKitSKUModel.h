//
//  CPUIKitSKUModel.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/6/25.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CPUIKitSKUSpecificationModel <NSObject>
@end

@interface CPUIKitSKUSpecificationModel : JSONModel <CPUIKitSKUSpecificationModel>
@property (nonatomic, copy) NSString* specType;
@property (nonatomic, strong) NSArray<NSString*>* specNames;
@end

@protocol CPUIKitSKUConditionModel <NSObject>
@end

@interface CPUIKitSKUConditionModel : JSONModel<CPUIKitSKUConditionModel>
@property (nonatomic, strong) NSArray<NSString*>* condition;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* origPrice;
@property (nonatomic, assign) NSInteger stock;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* skuID;
@property (nonatomic, copy) NSString* discount;
@end

@interface CPUIKitSKUModel : JSONModel
@property (nonatomic, strong) NSArray<CPUIKitSKUSpecificationModel>* specifications;
@property (nonatomic, strong) NSArray<CPUIKitSKUConditionModel>* conditions;
@end

NS_ASSUME_NONNULL_END
