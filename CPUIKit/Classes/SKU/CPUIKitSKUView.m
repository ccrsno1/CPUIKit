//
//  CPUIKitSKUView.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2019/6/26.
//  Copyright © 2019 ingtube. All rights reserved.
//

#import "CPUIKitSKUView.h"
#import "ORSKUDataFilter.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "CPUIKiSKUCollectionViewCell.h"

@interface CPUIKitSKUCollectionViewHeader : UICollectionReusableView
@property (nonatomic, strong) UILabel *headNameLabel;
@end

@interface CPUIKitSKUCollectionViewFooter : UICollectionReusableView
@property (nonatomic, strong) UIView* separator;
@end

@interface CPUIKitSKUView ()<ORSKUDataFilterDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateLeftAlignedLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <NSIndexPath *>*selectedIndexPaths;;
@property (nonatomic, strong) ORSKUDataFilter *filter;
@end

@implementation CPUIKitSKUView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
};

- (void)commonInit{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    @weakify(self)
    [RACObserve(self, data) subscribeNext:^(id  _Nullable x) {
        [self.filter reloadData];
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }];
    self.didSelectSKUConditionSignal = RACObserve(self, filter.currentResult);
    [RACObserve(self, collectionView.contentSize) subscribeNext:^(NSValue*  _Nullable x) {
        @strongify(self)
        [self invalidateIntrinsicContentSize];
    }];
}

- (ORSKUDataFilter *)filter{
    if (!_filter) {
        _filter = [[ORSKUDataFilter alloc] initWithDataSource:self];
        _filter.needDefaultValue = NO;
    }
    return _filter;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout* layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.minimumLineSpacing = 14.0f;
        layout.minimumInteritemSpacing = 16.0f;
        layout.sectionInset = UIEdgeInsetsMake(0, 16, 28, 16);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsSelection = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:CPUIKiSKUCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(CPUIKiSKUCollectionViewCell.class)];
        [_collectionView registerClass:CPUIKitSKUCollectionViewHeader.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CPUIKitSKUCollectionViewHeader.class)];
        [_collectionView registerClass:CPUIKitSKUCollectionViewFooter.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(CPUIKitSKUCollectionViewFooter.class)];

    }
    return _collectionView;
}


#pragma mark -- collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.specifications.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CPUIKitSKUSpecificationModel* specification = self.data.specifications[section];
    return specification.specNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CPUIKiSKUCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CPUIKiSKUCollectionViewCell.class) forIndexPath:indexPath];
    CPUIKitSKUSpecificationModel* specification = self.data.specifications[indexPath.section];
    cell.contentLabel.text = specification.specNames[indexPath.row];
    cell.available = [_filter.availableIndexPathsSet containsObject:indexPath];
    [cell setSelected: [_filter.selectedIndexPaths containsObject:indexPath]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CPUIKitSKUCollectionViewHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(CPUIKitSKUCollectionViewHeader.class) forIndexPath:indexPath];
        CPUIKitSKUSpecificationModel* specification = self.data.specifications[indexPath.section];
        view.headNameLabel.text = specification.specType;
        return view;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        CPUIKitSKUCollectionViewFooter *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(CPUIKitSKUCollectionViewFooter.class) forIndexPath:indexPath];
        return view;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_filter didSelectedPropertyWithIndexPath:indexPath];
    [collectionView reloadData];
}

#pragma mark -- ORSKUDataFilterDataSource

- (NSInteger)numberOfSectionsForPropertiesInFilter:(ORSKUDataFilter *)filter {
    return self.data.specifications.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
    CPUIKitSKUSpecificationModel* specification = self.data.specifications[section];
    return specification.specNames;
}

- (NSInteger)numberOfConditionsInFilter:(ORSKUDataFilter *)filter {
    return self.data.conditions.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    CPUIKitSKUConditionModel* conditionModel = self.data.conditions[row];
    return conditionModel.condition;
}

- (CPUIKitSKUConditionModel* )filter:(ORSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    return self.data.conditions[row];
}

#pragma mark -- action

- (CGSize)intrinsicContentSize{
    return self.collectionView.contentSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CPUIKitSKUSpecificationModel* specification = self.data.specifications[indexPath.section];
    return [self sizeOfString:specification.specNames[indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 52.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 0.5f);
}


- (CGSize)sizeOfString:(NSString *)str{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    return CGSizeMake(size.width + 20.0f, size.height + 10.0f);
}

@end

@implementation CPUIKitSKUCollectionViewHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headNameLabel];
        [self.headNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(16.0f);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (UILabel *)headNameLabel{
    if (!_headNameLabel) {
        _headNameLabel = [[UILabel alloc] init];
        _headNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _headNameLabel.font = [UIFont systemFontOfSize:13.0f weight:UIFontWeightMedium];
    }
    return _headNameLabel;
}

@end

@implementation CPUIKitSKUCollectionViewFooter

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.separator];
        [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(16.0f);
            make.trailing.mas_equalTo(-16.0f);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
}

- (UIView *)separator{
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.translatesAutoresizingMaskIntoConstraints = NO;
        _separator.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
    }
    return _separator;
}

@end


