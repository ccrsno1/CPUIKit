//
//  CPUIKitMultiColumnStackView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/1/15.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//[
//    [column0-0, column0-1, column0-2,..., column0-i],
//    [column1-0, column1-1, column1-2,..., column1-i],
//    .
//    .
//    .
//    [columnj-0, columnj-1, columnj-2,..., columnj-i]
//]

@interface CPUIKitMultiColumnStackView : UIView
- (instancetype)initWithViews:(NSArray<NSArray<UIView*>*>*)views;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
@property (nonatomic, assign) float spacing;
@end

NS_ASSUME_NONNULL_END
