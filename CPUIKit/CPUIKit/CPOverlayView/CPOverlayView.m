//
//  CPOverlayView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/1/11.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import "CPOverlayView.h"
#import "CPOverlayViewCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface CPOverlayView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView* collectionView;
@end

@implementation CPOverlayView

- (instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    @weakify(self)
    [RACObserve(self, data) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.collectionView reloadData];
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self invalidateIntrinsicContentSize];
    }];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(28.0f, 28.0f);
        layout.minimumLineSpacing = -8.0f;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:CPOverlayViewCell.class forCellWithReuseIdentifier:NSStringFromClass(CPOverlayViewCell.class)];
        if (@available(iOS 11, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CPOverlayViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CPOverlayViewCell.class) forIndexPath:indexPath];
    if (indexPath.row < self.data.count) {
        [cell bindWithImageURL:self.data[indexPath.row]];
        cell.layer.zPosition = self.data.count - indexPath.row;
        cell.shouldMasked = indexPath.row != 0;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

#pragma mark -

- (CGSize)intrinsicContentSize{
    if (self.data.count <= 0) {
        return CGSizeZero;
    }
    return CGSizeMake((self.data.count - 1)*(28.0f - 8.0f) + 28.0f, 28.0f);
}

@end
