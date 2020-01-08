//
//  CPUIKitMultiColumnStackView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/1/15.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKitMultiColumnStackView.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>

@interface CPUIKitMultiColumnStackView ()
@property (nonatomic, strong) UIStackView* stackView;
@end

@implementation CPUIKitMultiColumnStackView

- (instancetype)initWithViews:(NSArray<NSArray<UIView *> *> *)views{
    if (self = [super initWithFrame:CGRectZero]) {
        [self commonInit];
        [views enumerateObjectsUsingBlock:^(NSArray<UIView *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView* item = [self buildItemView:obj];
            if (item) {
                [self.stackView addArrangedSubview:item];
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(self);
                }];
            }
        }];
    }
    return self;
}

- (void)commonInit{
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setSpacing:(float)spacing{
    self.stackView.spacing = spacing;
}

- (UIView *)buildItemView:(NSArray<UIView*>*)views{
    if (views.count > 0) {
        UIStackView* horizonalStackView = [[UIStackView alloc] init];
        horizonalStackView.translatesAutoresizingMaskIntoConstraints = NO;
        horizonalStackView.distribution = UIStackViewDistributionFill;
        horizonalStackView.alignment = UIStackViewAlignmentTop;
        horizonalStackView.axis = UILayoutConstraintAxisHorizontal;
        [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [horizonalStackView addArrangedSubview:obj];
        }];
        return horizonalStackView;
    }
    return nil;
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.distribution = UIStackViewDistributionFill;
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 0.0f;
    }
    return _stackView;
}

@end
