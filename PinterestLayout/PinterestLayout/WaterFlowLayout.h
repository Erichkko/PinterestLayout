//
//  WaterFlowLayout.h
//  PinterestLayout
//
//  Created by wanglong on 16/7/17.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;
@protocol WaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat) waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSUInteger )index withItemWidth:(CGFloat )width;
@optional
- (NSUInteger)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)colMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
@end
@interface WaterFlowLayout : UICollectionViewLayout
/** delegate */
@property(nonatomic,weak)id <WaterFlowLayoutDelegate>delegate;
@end
