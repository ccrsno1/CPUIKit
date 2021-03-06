//
//  CKCylinderReversibleHeader.h
//
//
//  Created by Mac on 17/3/14.
//  Copyright (c) 2017年 kaicheng. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

static NSString * HeaderThemeChangedNotification = @"BackgroundColorUpdateNotification";


@interface CKCylinderReversibleHeader : MJRefreshHeader

@property(nonatomic, strong) UIColor * cylinderColor;

-(void)startAnimation;

-(void)stopAnimation;

@end
