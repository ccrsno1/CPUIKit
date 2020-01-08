//
//  CPUIKitLabel.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/11/13.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPUIKitLabel : UIView
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, readonly, strong) UILabel* contentLabel;
@end

NS_ASSUME_NONNULL_END
