//
//  Header.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/3/20.
//  Copyright © 2019 ingtube. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol CPUIKitCommonTableViewCellDataProtocol <NSObject>
@property (nonatomic, copy) NSString* pointId;
@property (nonatomic, copy) NSString* pointDetail;
@property (nonatomic, copy) NSString* pointString;
@property (nonatomic, assign) NSTimeInterval createTime;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* remain;
@end
