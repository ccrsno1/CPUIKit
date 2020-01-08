//
//  CPMyCreditsListTableViewCell.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/1/29.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPUIKitCommonTableViewCellDataProtocol.h"

@interface CPUIKitCommonTableViewCell : UITableViewCell
@property (nonatomic, strong) id<CPUIKitCommonTableViewCellDataProtocol> data;
@end
