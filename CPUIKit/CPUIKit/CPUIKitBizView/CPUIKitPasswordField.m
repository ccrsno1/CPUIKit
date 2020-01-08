//
//  CPUIKitPasswordField.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/3/21.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKitPasswordField.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPUIKitPasswordField ()
@property (nonatomic, strong) UIButton* showPasswordButton;
@end

@implementation CPUIKitPasswordField

- (instancetype)init{
    if (self = [super init]) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews{
    self.rightViewMode = UITextFieldViewModeWhileEditing;
    self.rightView = self.showPasswordButton;
    RAC(self, secureTextEntry) = [RACObserve(self, showPasswordButton.selected) not];
}

- (UIButton *)showPasswordButton{
    if (!_showPasswordButton) {
        _showPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showPasswordButton setImage:[UIImage imageNamed:@"login_eye_unsee"] forState:UIControlStateNormal];
        [_showPasswordButton setImage:[UIImage imageNamed:@"login_eye_see"] forState:UIControlStateSelected];
        [[_showPasswordButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            x.selected = !x.selected;
        }];
        _showPasswordButton.frame = CGRectMake(0, 0, 24, 24);
    }
    return _showPasswordButton;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

@end
