//
//  CPPrivateEnjoySpecificationView.m
//  CrowdPower4iPhone
//
//  Created by mc on 2017/9/6.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import "CPUIKitTagsView.h"
#import "CPUIKitTagsViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>

@interface CPUIKitTagsView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateLeftAlignedLayout>
@property (nonatomic, strong) UICollectionView* collectionView;
@end

@implementation CPUIKitTagsView

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    [[RACObserve(self, data) ignore:nil] subscribeNext:^(NSArray<NSString *>*  _Nullable x) {
        @strongify(self)
        [self.collectionView reloadData];
        [self.collectionView.collectionViewLayout invalidateLayout];
    }];
    
    [RACObserve(self, collectionView.contentSize) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self invalidateIntrinsicContentSize];
    }];
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(self.collectionView.contentSize.width, self.collectionView.contentSize.height);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout* layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.minimumLineSpacing = 8.0f;
        layout.minimumInteritemSpacing = 8.0f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:CPUIKitTagsViewCell.class forCellWithReuseIdentifier:NSStringFromClass(CPUIKitTagsViewCell.class)];
    }
    return _collectionView;
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CPUIKitTagsViewCell* cell = (CPUIKitTagsViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CPUIKitTagsViewCell.class) forIndexPath:indexPath];
    if (indexPath.row < self.data.count) {
        NSString* data = self.data[indexPath.row];
        [cell bindWithData:data];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.data.count) {
        NSString* data = self.data[indexPath.row];
        return [CPUIKitTagsView sizeOfString:data];
    }
    return CGSizeZero;
}

+ (CGSize)sizeOfString:(NSString *)str{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f]}];
    return CGSizeMake(size.width + 20.0f, size.height + 10.0f);
}

+ (CGFloat)displayHeight:(NSArray<NSString*>*)data width:(CGFloat)width{
    if (data.count > 0) {
        CGSize size = [CPUIKitTagsView sizeOfString:data.firstObject];
        __block height = size.height;
        __block curWidth = size.width;
        [data enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx != 0) {
                CGSize size = [CPUIKitTagsView sizeOfString:obj];
                if (curWidth + size.width + 8.0f > width ) {
                    height =  height + 8 + size.height;
                    curWidth = size.width;
                }else{
                    curWidth =  curWidth + 8 + size.width;
                }
            }
        }];
        return height;
    }
    return 0.0f;
}

@end
