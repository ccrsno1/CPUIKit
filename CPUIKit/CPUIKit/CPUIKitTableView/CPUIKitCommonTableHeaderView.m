//
//  CPMyCreditsListHeaderView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/1/29.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import "CPUIKitCommonTableHeaderView.h"
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>

@interface CPUIKitCommonTableHeaderView ()
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIView* separatorLine;
@end

@implementation CPUIKitCommonTableHeaderView{
    BOOL _constraintsUpdated;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}

- (void)setDate:(NSTimeInterval)date{
    NSInteger month = [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate dateWithTimeIntervalSince1970:date]];
    NSInteger curMonth = [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]];
    if (month == curMonth) {
        self.titleLabel.text = @"本月";
    }else{
        self.titleLabel.text = [NSString stringWithFormat:@"%2ld月", (long)month];
    }
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.titleLabel.text = nil;
}

- (void)commonInit{
    _constraintsUpdated = NO;
    self.contentView.backgroundColor = [UIColor colorWithRGB:0xf5f5f5];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.separatorLine];
}

- (void)updateConstraints{
    [super updateConstraints];
    if (!_constraintsUpdated) {
        _constraintsUpdated = YES;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(18.0f).priorityHigh();
            make.trailing.lessThanOrEqualTo(self.contentView).offset(-18.0f).priorityHigh();
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self);
            make.height.mas_equalTo(0.5f);
        }];
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textColor = [UIColor colorWithRGB:0x939393];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _titleLabel;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.translatesAutoresizingMaskIntoConstraints = NO;
        _separatorLine.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
        _separatorLine.hidden = YES;
    }
    return _separatorLine;
}

@end
