//
//  WaterFlowLayout.m
//  PinterestLayout
//
//  Created by wanglong on 16/7/17.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WaterFlowLayout.h"



static const NSInteger defaultColumnCount = 2;
static const CGFloat defaultColMargin = 10;
static const CGFloat defaultRowMargin = 10;
static const UIEdgeInsets defaultEdgeInsets = {10,10,10,10};


@interface WaterFlowLayout()

/** arrays */
@property(nonatomic,strong)NSMutableArray *arrays;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/**conteSizeHeight*/
@property(nonatomic,assign)CGFloat conteSizeHeight;


- (CGFloat)rowMargin;
- (CGFloat)colMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
@end
@implementation WaterFlowLayout

#pragma mark - 常见数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return defaultRowMargin;
    }
}

- (CGFloat)colMargin
{
    if ([self.delegate respondsToSelector:@selector(colMarginInWaterflowLayout:)]) {
        return [self.delegate colMarginInWaterflowLayout:self];
    } else {
        return defaultColMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return defaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return defaultEdgeInsets;
    }
}

- (NSMutableArray *)columnHeights
{
    
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights ;
}
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
    self.conteSizeHeight = 0;
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    
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
    
    CGFloat w = (self.collectionView.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right -(self.columnCount - 1) * self.colMargin)/self.columnCount;
    CGFloat h = [self.delegate waterFlowLayout:self heightForItemAtIndexPath:indexPath.item withItemWidth:w];

    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
 
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.colMargin);;
     CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attr.frame =CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attr.frame));
    CGFloat maxColumn = [self.columnHeights[destColumn] doubleValue];
    if (self.conteSizeHeight  < maxColumn) {
        self.conteSizeHeight = maxColumn;
    }
    return attr;
}

- (CGSize) collectionViewContentSize
{
//    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
//    for (NSInteger i = 1; i < self.columnCount; i++) {
//        // 取得第i列的高度
//        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
//        
//        if (maxColumnHeight < columnHeight) {
//            maxColumnHeight = columnHeight;
//        }
//    }
    return CGSizeMake(0, self.conteSizeHeight+ self.edgeInsets.bottom);
}
@end
