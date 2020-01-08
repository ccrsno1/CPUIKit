//
//  CPUIKitSpecificationViewCell.m
//  CrowdPower4iPhone
//
//  Created by mc on 2017/9/7.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import "CPUIKitTagsViewCell.h"
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>

@interface CPUIKitTagsViewCell()
@property (nonatomic, strong) UILabel* contentLabel;
@end

@implementation CPUIKitTagsViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.contentView.layer.cornerRadius = 2.0f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor colorWithRGB:0xf5f5f5];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)bindWithData:(NSString *)data{
    self.contentLabel.text = data;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithRGB:0xa6a6a6];
        _contentLabel.font = [UIFont systemFontOfSize:10.0f];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentLabel;
}
@end
