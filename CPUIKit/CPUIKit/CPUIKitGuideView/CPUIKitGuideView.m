//
//  CPUIKitGuideView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/8/28.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKitGuideView.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import "UIButton+ActionButton.h"

@interface CPUIKitGuideView ()
@property (nonatomic, strong) UIImageView* helpImageView;
@property (nonatomic, strong) UIButton* actionButton;

@end

@implementation CPUIKitGuideView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    
    self.backgroundColor = [UIColor colorWithRGB:0x000000];
    
    [self addSubview:self.helpImageView];
    [self addSubview:self.actionButton];
    
    [self.helpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44.0f);
        make.leading.mas_equalTo(24.0f);
        make.trailing.mas_equalTo(-24.0f);
        make.bottom.lessThanOrEqualTo(self.actionButton.mas_top).offset(-44.0f);
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
    }];
    @weakify(self)
    [[RACObserve(self, confirmTitle) filter:^BOOL(NSString*  _Nullable value) {
        return value.length > 0;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.actionButton setTitle:x forState:UIControlStateNormal];
    }];
    
    [[RACObserve(self, helpImageName) filter:^BOOL(NSString*  _Nullable value) {
        return value.length > 0;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.helpImageView.image = [UIImage imageNamed:x];
    }];
}

- (UIImageView *)helpImageView{
    if (!_helpImageView) {
        _helpImageView = [[UIImageView alloc] init];
        _helpImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _helpImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _helpImageView;
}

- (UIButton *)actionButton{
    if (!_actionButton) {
        _actionButton = [UIButton actionButtonWithTitle:@"我知道了"];
    }
    return _actionButton;
}

- (RACSignal *)confirmSignal{
    return [self.actionButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

- (CGSize)intrinsicContentSize{
    return kScreenSize;
}

@end
