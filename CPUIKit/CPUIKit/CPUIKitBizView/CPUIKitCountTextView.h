//
//  CPUIKitCountTextView.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/9/19.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>


@interface CPUIKitCountTextView : UIView
@property (nonatomic, assign) BOOL disableCount;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSString* placeHolderString;
@property (nonatomic, strong) RACSignal* rac_textSignal;
@property (nonatomic, strong, readonly) UITextView* innerTextView;
@end
