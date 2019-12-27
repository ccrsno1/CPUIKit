//
//  CPPrivateEnjoyGuideView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/6/27.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPCommonGuideView : UIView
@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, strong) RACSignal* buttonClickedSignal;
@end
