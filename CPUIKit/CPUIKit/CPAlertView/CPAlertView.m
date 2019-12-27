//
//  CPAlertView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/6/1.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import "CPAlertView.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>

@interface CPAlertView ()
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* descLabel;
@property (nonatomic, strong) UIView* separatorLine;
@property (nonatomic, assign) CPAlertViewType type;
@end

@implementation CPAlertView

- (instancetype)initWithType:(CPAlertViewType)type{
    if (self =  [super initWithFrame:CGRectZero]) {
        _type = type;
        [self commonInit];
    }
    return self;
}

- (instancetype)init{
    return [self initWithType:CPAlertViewTypeConfirm];
}

- (void)commonInit{
    
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    self.backgroundColor = [UIColor colorWithRGB:0xffffff];
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.cancelButton];
    [self addSubview:self.confirmButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.separatorLine];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(28.0f);
        make.centerX.equalTo(self);
        make.leading.equalTo(self.cancelButton).offset(48.0f);
        make.trailing.equalTo(self.confirmButton).offset(-48.0f);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16.0f);
        make.leading.equalTo(self).offset(28.0f);
        make.trailing.equalTo(self).offset(-28.0f);
    }];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.height.mas_equalTo(0.5f);
        make.top.equalTo(self.descLabel.mas_bottom).offset(28.0f);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.separatorLine.mas_bottom).offset(20.0f);
        make.bottom.equalTo(self).offset(-20.0f);
        make.trailing.equalTo(self).offset(-24.0f);
        make.height.mas_equalTo(38.0f);
        make.leading.equalTo(self.cancelButton.mas_trailing).offset(15.0f);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.confirmButton);
        make.leading.equalTo(self).offset(24.0f);
        make.width.height.equalTo(self.confirmButton);
    }];
    
    if (self.type == CPAlertViewTypeInfo) {
        [self.cancelButton removeFromSuperview];
        [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separatorLine.mas_bottom).offset(20.0f);
            make.bottom.equalTo(self).offset(-20.0f);
            make.trailing.equalTo(self).offset(-24.0f);
            make.height.mas_equalTo(38.0f);
            make.leading.mas_equalTo(24.0f);
        }];
    }
    
    @weakify(self)
    [[RACSignal combineLatest:@[RACObserve(self, confirmButtonTitle), RACObserve(self, cancelButtonTitle)]] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        [self.confirmButton setTitle:x.first forState:UIControlStateNormal];
        [self.cancelButton setTitle:x.second forState:UIControlStateNormal];
    }];
    
    RAC(self, titleLabel.text) = RACObserve(self, title);
    RAC(self, descLabel.text) = RACObserve(self, desc);
    RAC(self, descLabel.attributedText) = [RACObserve(self, attributedDesc) ignore:nil];
    [[[RACObserve(self, contentClickedCommand) ignore:nil] take:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.contentClickedCommand execute:nil];
        }];
        [self.descLabel addGestureRecognizer:tgr];
    }];
}

- (void)setContentView:(UIView *)contentView{
    if (contentView) {
        if (_contentView) {
            [_contentView removeFromSuperview];
        }
        _contentView = contentView;
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.descLabel removeFromSuperview];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(38.0f);
            make.centerX.equalTo(self);
            make.leading.equalTo(self.cancelButton);
            make.trailing.equalTo(self.confirmButton);
            make.width.mas_lessThanOrEqualTo(MIN((kScreenWidth - 96.0f), 278.0f));
        }];
        [self.separatorLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(0.5f);
            make.top.equalTo(self.contentView.mas_bottom).offset(20.0f);
        }];
    }
}

- (void)setContentView:(UIView *)contentView edges:(UIEdgeInsets)insets{
    if (contentView) {
        if (_contentView) {
            [_contentView removeFromSuperview];
        }
        _contentView = contentView;
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.descLabel removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(insets.top);
            make.leading.equalTo(self.cancelButton).offset(insets.left);
            make.trailing.equalTo(self.confirmButton).offset(insets.right);
            make.width.mas_lessThanOrEqualTo(MIN((kScreenWidth - 96.0f), 278.0f));
        }];
        [self.separatorLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(0.5f);
            make.top.equalTo(self.contentView.mas_bottom).offset(insets.bottom);
        }];
    }
}


- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
        [_confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0xFBCD04]] forState:UIControlStateNormal];
        [_confirmButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        _confirmButton.layer.cornerRadius = 4.0f;
        _confirmButton.layer.masksToBounds = YES;
    }
    return _confirmButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0xF5F5F5] ] forState:UIControlStateNormal];
        [_cancelButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
        _cancelButton.layer.cornerRadius = 4.0f;
        _cancelButton.layer.masksToBounds = YES;
    }
    return _cancelButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium];
        _titleLabel.textColor = [UIColor colorWithRGB:0x000000];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _descLabel.font = [UIFont systemFontOfSize:16.0f];
        _descLabel.textColor = [UIColor colorWithRGB:0x949494];
        _descLabel.numberOfLines = 0;
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.userInteractionEnabled = YES;
    }
    return _descLabel;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.translatesAutoresizingMaskIntoConstraints = NO;
        _separatorLine.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
    }
    return _separatorLine;
}

- (RACSignal *)confirmSignal{
    return [self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

- (RACSignal *)cancelSignal{
    return [self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

- (CGSize)intrinsicContentSize{
    CGFloat minWidth = MIN((kScreenWidth - 48.0f), 326.0f);
    return CGSizeMake(minWidth, 160.0f);
}

@end
