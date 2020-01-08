//
//  CPUIKitSingleLabelStackView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/1/22.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UILableConfigBlock)(UILabel* label, NSString* str);
typedef void(^UIButtonConfigBlock)(UIButton* button, NSString* str);

@interface CPUIKitSingleCopyableLabelStackView : UIView
@property (nonatomic, assign) float spacing;
@property (nonatomic, strong) NSArray<RACTuple*>* data;
@property (nonatomic, copy) UILableConfigBlock labelConfigBlock;
@property (nonatomic, copy) UIButtonConfigBlock buttonConfigBlock;
@end

NS_ASSUME_NONNULL_END
