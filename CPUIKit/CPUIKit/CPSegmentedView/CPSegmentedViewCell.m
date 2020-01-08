//
//  CPSegmentedViewCell.m
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/18.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import "CPSegmentedViewCell.h"
#import "CPUIKitColorDefine.h"
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>

@interface CPSegmentedViewCell()
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIView* indicatorView;
@end

@implementation CPSegmentedViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.indicatorView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.titleLabel.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(2.0f);
    }];
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    [self setSelected:NO];
}

- (void)bindWithData:(NSString *)data{
    self.titleLabel.text = data;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [UIView animateWithDuration:0.25f animations:^{
        self.indicatorView.hidden = !selected;
        if (selected) {
            self.titleLabel.textColor = [UIColor colorWithRGB:0x3e3d3e];
            self.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightBold];
        }else{
            self.titleLabel.textColor = [UIColor colorWithRGB:0x939393];
            self.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightRegular];
        }
    } completion:^(BOOL finished) {
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textColor = [UIColor colorWithRGB:0x939393];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _indicatorView.backgroundColor = [UIColor colorWithRGB:THEME_COLOR_HEX];
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

@end
