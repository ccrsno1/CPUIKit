//
//  CPUIKitGuideView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/8/28.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPUIKitGuideView : UIView
@property (nonatomic, copy) NSString* helpImageName;
@property (nonatomic, copy) NSString* confirmTitle;
@property (nonatomic, strong) RACSignal* confirmSignal;
@end

NS_ASSUME_NONNULL_END
