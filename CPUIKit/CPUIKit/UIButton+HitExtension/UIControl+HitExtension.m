//    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
//    Version 2, December 2004
//
//    Copyright (C) 2013-2015 KIM TAE JUN <korean.darren@gmail.com>
//
//    Everyone is permitted to copy and distribute verbatim or modified
//    copies of this license document, and changing it is allowed as long
//    as the name is changed.
//
//    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
//    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
//
//    0. You just DO WHAT THE FUCK YOU WANT TO.

#import "UIControl+HitExtension.h"

// SDK
#import <objc/runtime.h>

static NSString * const DRNHitExtensionHitEdgeInsetsKey = @"DRNHitExtensionHitEdgeInsetsKey";

@implementation UIControl (HitExtension)

@dynamic hitEdgeInsets;

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL isZeroInsets = UIEdgeInsetsEqualToEdgeInsets(self.hitEdgeInsets, UIEdgeInsetsZero);
    if (isZeroInsets || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    UIEdgeInsets reversedEdgeInsets = UIEdgeInsetsMake(-self.hitEdgeInsets.top,
                                                       -self.hitEdgeInsets.left,
                                                       -self.hitEdgeInsets.bottom,
                                                       -self.hitEdgeInsets.right);
    CGRect bounds = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(bounds, reversedEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

#pragma mark - Setter

- (void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets
{
    NSValue *value = [NSValue value:&hitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &DRNHitExtensionHitEdgeInsetsKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Getter

- (UIEdgeInsets)hitEdgeInsets
{
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &DRNHitExtensionHitEdgeInsetsKey);
    if (edgeInsetsValue) {
        UIEdgeInsets edgeInsets;
        [edgeInsetsValue getValue:&edgeInsets];
        return edgeInsets;
    }
    
    return UIEdgeInsetsZero;
}

@end
