//
//  CPUIKitDoubleLabelStackView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/1/15.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKitDoubleLabelStackView.h"
#import "CPUIKitMultiColumnStackView.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>


@implementation CPUIKitDoubleLabelStackView

- (void)setData:(NSArray<RACTuple *> *)data{
    if (data.count > 0) {
        _data = data;
        [self removeAllSubviews];
        __block NSMutableArray<NSArray<UIView*>*>* generatedViews = @[].mutableCopy;
        [data enumerateObjectsUsingBlock:^(RACTuple * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.count == 1) {
                NSString* leftStr = obj.first;
                UILabel* leftLabel = [self leftLabelWithString:leftStr];
                [generatedViews addObject:@[leftLabel]];
            }
            if (obj.count == 2) {
                NSString* leftStr = obj.first;
                NSString* rightStr = obj.second;
                UILabel* leftLabel = [self leftLabelWithString:leftStr];
                UILabel* rightLabel = [self rightLabelWithString:rightStr];
                [generatedViews addObject:@[leftLabel, rightLabel]];
            }
        }];
        CPUIKitMultiColumnStackView* multiStackView = [[CPUIKitMultiColumnStackView alloc] initWithViews:generatedViews];
        multiStackView.spacing = self.spacing;
        [self addSubview:multiStackView];
        [multiStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setSpacing:(float)spacing{
    [self willChangeValueForKey:@"spacing"];
    _spacing = spacing;
    [self setData:self.data];
    [self didChangeValueForKey:@"spacing"];
}

- (UILabel*)leftLabelWithString:(NSString *)str{
    UILabel* label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = str;
    !self.leftColumnConfigBlock?:self.leftColumnConfigBlock(label, str);
    return label;
}

- (UILabel*)rightLabelWithString:(NSString *)str{
    UILabel* label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = str;
    !self.rightColumnConfigBlock?:self.rightColumnConfigBlock(label, str);
    return label;
}

@end
