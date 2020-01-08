//
//  UILabel+UILabel_LineSpacing_h.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/9/6.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import "UILabel+UILabel_LineSpacing_h.h"

@implementation UILabel (UILabel_LineSpacing_h)
- (void)setText:(NSString *)text lineSpacing:(float)lineSpacing{
    if (text.length > 0 && lineSpacing > 0.0f) {
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = lineSpacing;
        self.attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:self.font?:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:self.textColor?:[UIColor blackColor], NSParagraphStyleAttributeName:style}];
    }
}
@end
