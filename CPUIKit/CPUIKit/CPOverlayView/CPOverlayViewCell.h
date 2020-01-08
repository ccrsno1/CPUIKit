//
//  CPOverlayViewCell.h
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/1/11.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPOverlayViewCell : UICollectionViewCell
- (void)bindWithImageURL:(NSString *)url;
@property (nonatomic, assign) BOOL shouldMasked;
@end
