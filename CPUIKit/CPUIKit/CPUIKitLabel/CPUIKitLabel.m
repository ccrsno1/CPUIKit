//
//  CPUIKitLabel.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/11/13.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import "CPUIKitLabel.h"
#import "UILabel+Copyable.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPUIKitLabel ()
@property (nonatomic, readwrite, strong) UILabel* contentLabel;
@end

@implementation CPUIKitLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [RACObserve(self, contentInsets) subscribeNext:^(NSValue*  _Nullable x) {
        UIEdgeInsets insets = [x UIEdgeInsetsValue];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(insets);
        }];
    }];
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _contentLabel;
}

@end
