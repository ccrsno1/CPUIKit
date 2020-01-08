//
//  CPSegmentedViewCell.m
//  CrowdPower4iPhone
//
//  Created by mc on 2017/10/18.
//  Copyright © 2017年 ingtube. All rights reserved.
//

#import "CPSegmentedView.h"
#import "CPSegmentedViewCell.h"
#import "CPUIKitColorDefine.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <YYCategories/YYCategories.h>

@interface CPSegmentedView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView* segmentedControl;
@property (nonatomic, strong) UIImageView* maskView;
@property (nonatomic, assign) CPSegmentedViewType type;
@end

@implementation CPSegmentedView

- (instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    self.segmentedControl.hidden = NO;
    self.maskView.hidden = NO;
    
    @weakify(self)
    self.filterViewDidSelectIndexSignal = [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] map:^id _Nullable(RACTuple * _Nullable value) {
        @strongify(self)
        NSIndexPath* indexPath = (NSIndexPath *)value.second;
        return RACTuplePack(@(indexPath.section), self.data[indexPath.section]);
    }];
    
    [[RACObserve(self, data) distinctUntilChanged] subscribeNext:^(NSArray*  _Nullable x)  {
        @strongify(self)
        self.type = (x.count > 4)?CPSegmentedViewTypeNormal:CPSegmentedViewTypeEqualWidth;
        [self.segmentedControl reloadData];
        [self.segmentedControl.collectionViewLayout invalidateLayout];
        [self.segmentedControl selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }];
    
    [RACObserve(self, selectedIndex) subscribeNext:^(NSNumber*  _Nullable x) {
        @strongify(self)
        if (self.data.count > 0 && self.data.count > [x integerValue]) {
            [self.segmentedControl selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[x integerValue]] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        }
    }];
}

- (void)setType:(CPSegmentedViewType)type{
    _type = type;
    if (type == CPSegmentedViewTypeEqualWidth) {
        UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)self.segmentedControl.collectionViewLayout;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0.0f);
        self.segmentedControl.contentInset = UIEdgeInsetsMake(0, 0.0f, 0, 0.0f);
        self.maskView.hidden = YES;
    }else{
        UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)self.segmentedControl.collectionViewLayout;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 24.0f);
        self.segmentedControl.contentInset = UIEdgeInsetsMake(0, 16.0f, 0, 0.0f);
        self.maskView.hidden = NO;
    }
}

- (UICollectionView *)segmentedControl{
    if (!_segmentedControl) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 24.0f);
        _segmentedControl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _segmentedControl.delegate = self;
        _segmentedControl.dataSource = self;
        _segmentedControl.alwaysBounceVertical = NO;
        _segmentedControl.alwaysBounceHorizontal = YES;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.allowsMultipleSelection = NO;
        _segmentedControl.showsHorizontalScrollIndicator = NO;
        _segmentedControl.showsVerticalScrollIndicator = NO;
        _segmentedControl.contentInset = UIEdgeInsetsMake(0, 16.0f, 0, 0.0f);
        [_segmentedControl registerClass:[CPSegmentedViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CPSegmentedViewCell class])];
        [self addSubview:_segmentedControl];
        [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _segmentedControl;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filter_mask"]];
        _maskView.translatesAutoresizingMaskIntoConstraints = NO;
        _maskView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.trailing.bottom.equalTo(self);
            make.width.mas_equalTo(26.0f);
        }];
    }
    return _maskView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CPSegmentedViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CPSegmentedViewCell class]) forIndexPath:indexPath];
    if (self.data.count > indexPath.section) {
        [cell bindWithData:self.data[indexPath.section]];
        if (indexPath.section == self.selectedIndex) {
            cell.selected = YES;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.selectedIndex) {
        cell.selected = YES;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath.section;
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)indexDidChanged:(NSInteger)index{
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.data.count > indexPath.section) {
        NSString* str = self.data[indexPath.section];
        NSAttributedString* attributedStr = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f weight:UIFontWeightBold]}];
        CGRect titleSize = [attributedStr boundingRectWithSize:CGSizeMake(kScreenWidth, 32.0f) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine context:nil];
        if (self.type == CPSegmentedViewTypeEqualWidth) {
            return CGSizeMake(kScreenWidth/self.data.count*1.0f , 32.0f);
        }else
            return CGSizeMake(titleSize.size.width + 8.0f, 32.0f);
    }
    return CGSizeZero;
}

@end

