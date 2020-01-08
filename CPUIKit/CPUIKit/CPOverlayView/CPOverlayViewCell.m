//
//  CPOverlayViewCell.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/1/11.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import "CPOverlayViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPOverlayViewCell ()
@property (nonatomic, strong) UIImageView* imageView;
@end

@implementation CPOverlayViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).offset(-4.0f);
        make.height.equalTo(self.contentView.mas_height).offset(-4.0f);
        make.center.equalTo(self.contentView);
    }];
    
    self.contentView.layer.cornerRadius = 14.0f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setShouldMasked:(BOOL)shouldMasked{
    if (shouldMasked) {
        self.imageView.layer.mask = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"overlaymask"]].layer;
    }else{
        self.imageView.layer.mask = nil;
    }
}

- (void)bindWithImageURL:(NSString *)url{
    if (url.length > 0) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.imageView.layer.mask = nil;
    self.imageView.image = nil;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.layer.cornerRadius = 12.0f;
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

@end
