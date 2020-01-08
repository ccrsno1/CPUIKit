//
//  UIImageView+UIImageView_AliCDNCache.m
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/31.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import "UIImageView+UIImageView_AliCDNCache.h"
#import <YYCategories/YYCategories.h>

static NSString* const kImageCDNHost = @"yingtu.co";

BOOL isValidCDNURLStr(NSString * url){
    if (url.length > 0) {
        return [url containsString:@"yingtu.co"]||[url containsString:@"aliyuncs.com"];
    }
    return NO;
}

NSInteger widthFromType(AliCDNImageType type){
    NSInteger width = 0;
    switch (type) {
        case AliCDNImageTypeFourSquare_Width_80:
            width = 80;
            break;
        case AliCDNImageTypeFourSquare_Width_120:
            width = 120;
            break;
        case AliCDNImageTypeFourSquare_Width_200:
            width = 200;
            break;
        case AliCDNImageTypeFourSquare_Width_400:
            width = 400;
            break;
        case AliCDNImageTypeFourSquare_Width_600:
            width = 600;
            break;
        default:
            width = 400;
            break;
    }
    return width;
}

@implementation UIImageView (UIImageView_AliCDNCache)

- (void)cdn_setFourSquareImageWithURLStr:(NSString *)urlStr type:(AliCDNImageType)type{
    [self cdn_setFourSquareImageWithURLStr:urlStr placeholderImage:nil type:type];
}

- (void)cdn_setFourSquareImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)image type:(AliCDNImageType)type{
    NSString* finalURLStr = urlStr;
    NSInteger width = (long)widthFromType(type);
    NSInteger scale = (NSInteger)[UIScreen mainScreen].scale;
    if (isValidCDNURLStr(urlStr)) {
        finalURLStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,h_%ld,w_%ld/quality,q_100/format,jpg", finalURLStr, width*scale, width*scale];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:finalURLStr] placeholderImage:image];
}

- (void)cdn_setFourSquareImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)image width:(NSInteger)width{
    NSString* finalURLStr = urlStr;
    NSInteger scale = (NSInteger)[UIScreen mainScreen].scale;
    if (isValidCDNURLStr(urlStr)) {
        finalURLStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,h_%ld,w_%ld/quality,q_100/format,jpg", finalURLStr, width*scale, width*scale];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:finalURLStr] placeholderImage:image];
}

@end
