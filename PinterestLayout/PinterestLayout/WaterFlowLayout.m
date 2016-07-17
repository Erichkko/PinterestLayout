//
//  WaterFlowLayout.m
//  PinterestLayout
//
//  Created by wanglong on 16/7/17.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WaterFlowLayout.h"

@interface WaterFlowLayout()

/** arrays */
@property(nonatomic,strong)NSMutableArray *arrays;

@end
@implementation WaterFlowLayout

- (NSMutableArray *)arrays
{
    if (_arrays == nil) {
        _arrays = [NSMutableArray array];
    }
    return _arrays ;
}


- (void)prepareLayout
{
    [super prepareLayout];
    [self.arrays removeAllObjects];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.arrays addObject:attr];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.arrays;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame  =  CGRectMake(arc4random_uniform(300), arc4random_uniform(300), arc4random_uniform(300), arc4random_uniform(300));
  
    return attr;
}

- (CGSize) collectionViewContentSize
{
    return CGSizeMake(0, 1000);
}
@end
