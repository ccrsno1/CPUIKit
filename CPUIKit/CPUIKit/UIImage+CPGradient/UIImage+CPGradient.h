//
//  UIImage+JTKGradient.h
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (CPGradient)

+ (UIImage *)gradientImageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor width:(CGFloat)width;

@end
