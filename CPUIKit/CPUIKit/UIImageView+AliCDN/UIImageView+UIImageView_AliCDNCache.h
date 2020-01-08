//
//  UIImageView+UIImageView_AliCDNCache.h
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/31.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+WebCache.h"

typedef NS_ENUM(NSInteger, AliCDNImageType){
    AliCDNImageTypeFourSquare_Width_80,
    AliCDNImageTypeFourSquare_Width_120,
    AliCDNImageTypeFourSquare_Width_200,
    AliCDNImageTypeFourSquare_Width_400,
    AliCDNImageTypeFourSquare_Width_600
};

@interface UIImageView (UIImageView_AliCDNCache)
- (void)cdn_setFourSquareImageWithURLStr:(NSString *)urlStr type:(AliCDNImageType)type;
- (void)cdn_setFourSquareImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)image type:(AliCDNImageType)type;
- (void)cdn_setFourSquareImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)image width:(NSInteger)width;

@end
