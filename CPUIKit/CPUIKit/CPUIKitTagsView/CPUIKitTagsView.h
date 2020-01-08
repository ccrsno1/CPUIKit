//
//  CPPrivateEnjoySpecificationView.h
//  CrowdPower4iPhone
//
//  Created by mc on 2017/9/6.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPUIKitTagsView : UIView
@property (nonatomic, strong) NSArray<NSString*>* data;
+ (CGFloat)displayHeight:(NSArray<NSString*>*)data width:(CGFloat)width;
@end
