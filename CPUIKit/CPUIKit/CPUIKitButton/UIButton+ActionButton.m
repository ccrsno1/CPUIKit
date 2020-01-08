//
//  UIButton+ActionButton.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/8/21.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import "UIButton+ActionButton.h"
#import "CPUIKitColorDefine.h"
#import "UIDevice+HardwareModel.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>

@implementation UIButton(ActionButton)
+ (instancetype)actionButtonWithTitle:(NSString *)title{
     UIButton* _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_actionButton setTitle:title forState:UIControlStateNormal];
    [_actionButton setTitleColor:[UIColor colorWithRGB:BUTTON_NROMAL_TEXT_COLOR_HEX] forState:UIControlStateNormal];
    [_actionButton setTitleColor:[UIColor colorWithRGB:BUTTON_DISABLE_TEXT_COLOR_HEX] forState:UIControlStateDisabled];
    UIImage* backgroundImage = [UIImage imageWithColor:[UIColor colorWithRGB:BUTTON_NORMAL_BACKGROUND_COLRO_HEX]];
    UIImage* disabledBackgroundImage = [UIImage imageWithColor:[UIColor colorWithRGB:BUTTON_DISABLE_BACKGROUND_COLOR_HEX]];
    [_actionButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [_actionButton setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
    _actionButton.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium];
    if ([UIDevice currentDevice].isSpecialScreen) {
        [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50.0f+34.0f);
        }];
        UIEdgeInsets insets = _actionButton.titleEdgeInsets;
        insets.top -= 34.0f;
        _actionButton.titleEdgeInsets = insets;
    }else{
        [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50.0f);
        }];
    }
    return _actionButton;
}
@end
