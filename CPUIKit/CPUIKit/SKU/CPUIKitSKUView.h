//
//  CPUIKitSKUView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/6/26.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "CPUIKitSKUModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPUIKitSKUView : UIView
@property (nonatomic, strong) CPUIKitSKUModel* data;
@property (nonatomic, strong) RACSignal* didSelectSKUConditionSignal;
@end

NS_ASSUME_NONNULL_END
