//
//  CPUIKiSKUCollectionViewCell.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/6/26.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKiSKUCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPUIKiSKUCollectionViewCell()
@end

@implementation CPUIKiSKUCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.contentView.layer.borderColor = [UIColor colorWithRGB:0xe2e2e2].CGColor;
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.layer.cornerRadius = 4.0f;
    self.contentView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.contentView.backgroundColor = [UIColor colorWithRGB:0xFBCD04 alpha:0.08];
        self.contentView.layer.borderColor = [UIColor colorWithRGB:0xFBCD04].CGColor;
        self.contentLabel.textColor = [UIColor colorWithRGB:0xFAB811];
    }else{
        if (self.available) {
            self.contentView.backgroundColor = [UIColor colorWithRGB:0xF2F2F2];
            self.contentView.layer.borderColor = [UIColor colorWithRGB:0xF2F2F2].CGColor;
            self.contentLabel.textColor = [UIColor colorWithRGB:0x000000];
        }else{
            self.contentView.backgroundColor = [UIColor colorWithRGB:0xF2F2F2];
            self.contentView.layer.borderColor = [UIColor colorWithRGB:0xF2F2F2].CGColor;
            self.contentLabel.textColor = [UIColor colorWithRGB:0xc4c4c4];
        }
    }
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentLabel;
}

@end
