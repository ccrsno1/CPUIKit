//
//  CPUIKiSKUCollectionViewCell.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/6/26.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPUIKitSKUModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPUIKiSKUCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) BOOL available;
@property (nonatomic, strong) UILabel* contentLabel;
@end

NS_ASSUME_NONNULL_END
