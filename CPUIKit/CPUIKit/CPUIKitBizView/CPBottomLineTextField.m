//
//  CPBottomLineTextField.m
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/19.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import "CPBottomLineTextField.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPBottomLineTextField () <UITextFieldDelegate>
@property (nonatomic, strong) UIView* bottomLineView;
@property (nonatomic, strong) RACDelegateProxy* delegateProxy;
@end

@implementation CPBottomLineTextField

- (instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.tintColor = [UIColor colorWithRGB:0x000000];
    self.delegate = (id<UITextFieldDelegate>)self.delegateProxy;
    [self addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5f);
        make.leading.trailing.equalTo(self);
    }];
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomLineView.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
    }
    return _bottomLineView;
}

- (RACDelegateProxy *)delegateProxy{
    if (!_delegateProxy) {
        @weakify(self)
        _delegateProxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
        [[_delegateProxy rac_signalForSelector:@selector(textFieldShouldReturn:)] subscribeNext:^(RACTuple * _Nullable x) {
            UITextField* textField = x.first;
            [textField resignFirstResponder];
        }];
        
        [[_delegateProxy rac_signalForSelector:@selector(textFieldDidEndEditing:)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5f);
            }];
            [UIView animateWithDuration:0.25f animations:^{
                [self.bottomLineView updateConstraintsIfNeeded];
                self.bottomLineView.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
            }];

        }];
        
        [[_delegateProxy rac_signalForSelector:@selector(textFieldDidBeginEditing:)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(2.0f);
            }];
            [UIView animateWithDuration:0.25f animations:^{
                [self.bottomLineView updateConstraintsIfNeeded];
                self.bottomLineView.backgroundColor = [UIColor colorWithRGB:0xFBCD04];
            }];
        }];
    }
    return _delegateProxy;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    if (self.contentInsetX > 0) {
        return CGRectInset(bounds, self.contentInsetX, 0);
    }
    return [super textRectForBounds:bounds];
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (self.contentInsetX > 0) {
        return CGRectInset(bounds, self.contentInsetX, 0);
    }
    return [super editingRectForBounds:bounds];
}

@end
