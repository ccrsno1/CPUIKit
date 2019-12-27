//
//  CPPrivateEnjoyGuideView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/6/27.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import "CPCommonGuideView.h"
#import "CPUIKitColorDefine.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>

@interface CPCommonGuideView ()
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UIButton* confirmButton;
@end

@implementation CPCommonGuideView

- (instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.imageView];
    [self addSubview:self.confirmButton];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth - 64.0f);
    }];
        
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(30.0f);
        make.width.equalTo(self.imageView).offset(-40.0f);
        make.bottom.mas_equalTo(-24.0f);
        make.height.mas_equalTo(38.0f);
    }];
    
    @weakify(self)
    [[[RACObserve(self, imageName) ignore:nil] deliverOnMainThread] subscribeNext:^(NSString*  _Nullable x) {
        @strongify(self)
        UIImage* image = [UIImage imageNamed:x];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.imageView.mas_height).multipliedBy(image.size.width/image.size.height);
        }];
        self.imageView.image = image;
    }];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:nil];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0xFBCD04]] forState:UIControlStateNormal];
        [_confirmButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        _confirmButton.layer.cornerRadius = 4.0f;
        _confirmButton.layer.masksToBounds = YES;
        [_confirmButton setTitle:@"我知道了" forState:UIControlStateNormal];
    }
    return _confirmButton;
}

- (RACSignal *)buttonClickedSignal{
    return [self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end

