//
//  CPUIKitSeparatorBuilder.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/8/13.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import "CPUIKitSeparatorBuilder.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>

@implementation CPUIKitSeparatorBuilder
+ (UIView *)horizonalSeparator{
    UIView* separator = [[UIView alloc] init];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    separator.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5f);
    }];
    return separator;
}

+ (UIView *)verticalSeparator{
    UIView* separator = [[UIView alloc] init];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    separator.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5f);
    }];
    return separator;
}

+ (UIImageView *)dashLine{
    UIImageView* dashLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dash_line"]];
    dashLine.translatesAutoresizingMaskIntoConstraints = NO;
    return dashLine;
}

+ (UIView *)sectionSeparator{
    UIView* separator = [[UIView alloc] init];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    separator.backgroundColor = [UIColor colorWithRGB:0xf5f5f5];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10.0f);
        make.width.mas_equalTo(kScreenWidth);
    }];
    return separator;
}

@end
