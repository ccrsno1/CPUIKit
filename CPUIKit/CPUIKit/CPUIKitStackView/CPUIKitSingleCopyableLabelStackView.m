//
//  CPUIKitSingleLabelStackView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/1/22.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKitSingleCopyableLabelStackView.h"
#import "CPUIKitMultiColumnStackView.h"
#import "UILabel+Copyable.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation CPUIKitSingleCopyableLabelStackView

- (void)setData:(NSArray<RACTuple *> *)data{
    if (data.count > 0) {
        _data = data;
        [self removeAllSubviews];
        __block NSMutableArray<NSArray<UIView*>*>* generatedViews = @[].mutableCopy;
        [data enumerateObjectsUsingBlock:^(RACTuple * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray* tmpArray = @[].mutableCopy;
            UILabel* leftInfoLabel = [[UILabel alloc] init];
            leftInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
            leftInfoLabel.font = [UIFont systemFontOfSize:12.0f];
            leftInfoLabel.textColor = [UIColor colorWithRGB:0x939393];
            leftInfoLabel.numberOfLines = 1;
            leftInfoLabel.text = obj.first;
            !self.labelConfigBlock?:self.labelConfigBlock(leftInfoLabel, obj.first);
            [tmpArray addObject:leftInfoLabel];
            if (obj.second) {
                UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.translatesAutoresizingMaskIntoConstraints = NO;
                [button setTitle:@"复制" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRGB:0x3e3d3e] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:10.0f];
                [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    NSString* text = [obj.second copy]?:@"";
                    [pasteboard setString:text];
                }];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(14.0f);
                }];
                [tmpArray addObject:button];
            }
            [generatedViews addObject:tmpArray];
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

@end
