//
//  CPUIKitDoubleLabelStackView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/1/15.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UILableConfigBlock)(UILabel* label, NSString* str);

@interface CPUIKitDoubleLabelStackView : UIView
@property (nonatomic, copy) UILableConfigBlock leftColumnConfigBlock;
@property (nonatomic, copy) UILableConfigBlock rightColumnConfigBlock;
@property (nonatomic, strong) NSArray<RACTuple*>* data;
@property (nonatomic, assign) float spacing;
@end

NS_ASSUME_NONNULL_END
