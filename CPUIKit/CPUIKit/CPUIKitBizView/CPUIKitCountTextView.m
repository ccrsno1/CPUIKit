//
//  CPUIKitCountTextView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/9/19.
//  Copyright © 2018 ingtube. All rights reserved.
//

#import "CPUIKitCountTextView.h"
#import "CPUIKitCountLabel.h"
#import "UITextView+Placeholder.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>

@interface CPUIKitCountTextView ()
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) CPUIKitCountLabel* countLabel;
@end

@implementation CPUIKitCountTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self addSubview:self.textView];
    [self addSubview:self.countLabel];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.leading.mas_equalTo(-5.0f);
        make.trailing.mas_equalTo(5.0f);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(10.0f);
        make.trailing.equalTo(self.textView);
        make.bottom.equalTo(self);
    }];
    
    RAC(self, countLabel.totalCount) = [RACObserve(self, totalCount) ignore:nil];
    
    @weakify(self)
    RAC(self, countLabel.currentCount) = [self.textView.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        if (value.length > self.countLabel.totalCount) {
            self.textView.text = [self.textView.text substringWithRange:NSMakeRange(0, self.countLabel.totalCount)];
            return @(self.textView.text.length);
        }
        return @(value.length);
    }];
    
    [[RACObserve(self, placeHolderString) filter:^BOOL(NSString*  _Nullable value) {
        return value.length > 0;
    }] subscribeNext:^(NSString*  _Nullable str) {
        @strongify(self)
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 4.0f;
        NSAttributedString* attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName:[UIColor colorWithRGB:0xc4c4c4], NSParagraphStyleAttributeName:style}];
        self.textView.attributedPlaceholder = attributedPlaceholder;
    }];
    
    RAC(self, countLabel.hidden) = RACObserve(self, disableCount);
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 4.0f;
        _textView.typingAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName:[UIColor colorWithRGB:0x000000], NSParagraphStyleAttributeName:style};
    }
    return _textView;
}

- (CPUIKitCountLabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[CPUIKitCountLabel alloc] init];
        _countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _countLabel;
}

- (RACSignal *)rac_textSignal{
    return self.textView.rac_textSignal;
}

- (UITextView *)innerTextView{
    return self.textView;
}

@end
