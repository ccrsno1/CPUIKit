//
//  CPAlertView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/6/1.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjc/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, CPAlertViewType) {
    CPAlertViewTypeInfo = 0,
    CPAlertViewTypeConfirm = 1,
    CPAlertViewTypeCustom
};

@interface CPAlertView : UIView
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, strong) NSAttributedString* attributedDesc;
@property (nonatomic, copy) NSString* confirmButtonTitle;
@property (nonatomic, copy) NSString* cancelButtonTitle;
@property (nonatomic, strong) RACSignal* confirmSignal;
@property (nonatomic, strong) RACSignal* cancelSignal;
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) RACCommand* contentClickedCommand;
- (instancetype)initWithType:(CPAlertViewType)type;
- (void)setContentView:(UIView *)contentView edges:(UIEdgeInsets)insets;
@end
