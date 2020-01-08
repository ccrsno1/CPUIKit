//
//  CPUIKitCountLabel.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/8/21.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import "CPUIKitCountLabel.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation CPUIKitCountLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.totalCount = 0;
    self.currentCount = 0;
    self.font = [UIFont fontWithName:@"Avenir-Heavy" size:12.0f];
    self.textColor = [UIColor colorWithRGB:0xC4C4C4];
    RAC(self, text) = [[RACSignal combineLatest:@[RACObserve(self, totalCount), RACObserve(self, currentCount)]] map:^id _Nullable(RACTuple * _Nullable value) {
        return [NSString stringWithFormat:@"%@ / %@", value.second, value.first];
    }];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
}

@end
