//
//  ViewController.m
//  PinterestLayout
//
//  Created by wanglong on 16/7/17.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
#import "ShopCell.h"
#import "Shop.h"
#import "MJExtension.h"
#import "MJRefresh.h"


@interface ViewController ()<UICollectionViewDataSource,WaterFlowLayoutDelegate>
/** collectionView */
@property(nonatomic,weak) UICollectionView *collectionView;
/** ietms */
@property(nonatomic,strong)NSMutableArray *ietms;
@end

@implementation ViewController
static NSString * const waterFlowCellID = @"waterFlowCellID";

- (NSMutableArray *)ietms
{
    if (_ietms == nil) {
        _ietms = [NSMutableArray array];
//        for (int i = 0; i < 20; i++) {
//            [_ietms addObject:[NSString stringWithFormat:@"%zd",i+1]];
//        }
        
        
    }
    return _ietms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setupLayout];
    [self setupRefresh];
}

- (void)setup
{
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setupLayout
{
    //初始化layout
    WaterFlowLayout *layout =  [[WaterFlowLayout alloc] init];
    //    layout.itemSize  = CGSizeMake(100, 100);
    layout.delegate = self;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    collectionView.dataSource =self;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCell class]) bundle:nil] forCellWithReuseIdentifier:waterFlowCellID] ;
    //    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:waterFlowCellID];
}

- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer=  [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.footer.hidden = YES;
}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *arrays = [Shop objectArrayWithFilename:@"1.plist"];
        
        [self.ietms addObjectsFromArray:arrays];
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
        
    });
}
- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *arrays = [Shop objectArrayWithFilename:@"1.plist"];
        [self.ietms removeAllObjects];
        [self.ietms addObjectsFromArray:arrays];
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
    });

}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    self.collectionView.footer.hidden = !self.ietms.count;
  
    return [self.ietms count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Shop *shop = self.ietms[indexPath.item];
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:waterFlowCellID forIndexPath:indexPath];
    cell.shop = shop;
    
    return cell;
}
#pragma mark - WaterFlowLayoutDelegate

- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSUInteger )index withItemWidth:(CGFloat )width
{
    Shop *shop =self.ietms[index];
    return width * (shop.h /shop.w);
}
- (CGFloat) colMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout
{
    return 10;
}

- (NSUInteger)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout
{
    return 3;
}
@end
