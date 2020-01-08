//
//  CPPrivateEnjoyFilterView.h
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/18.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, CPSegmentedViewType){
    CPSegmentedViewTypeNormal,
    CPSegmentedViewTypeEqualWidth
};

@interface CPSegmentedView : UIView
@property (nonatomic, strong) NSArray<NSString*>* data;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) RACSignal* filterViewDidSelectIndexSignal;
@end

