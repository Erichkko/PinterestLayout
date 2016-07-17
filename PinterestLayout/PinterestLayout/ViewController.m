//
//  ViewController.m
//  PinterestLayout
//
//  Created by wanglong on 16/7/17.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
@interface ViewController ()<UICollectionViewDataSource>
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
        for (int i = 0; i < 20; i++) {
            [_ietms addObject:[NSString stringWithFormat:@"%zd",i+1]];
        }
    }
    return _ietms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化layout
    WaterFlowLayout *layout =  [[WaterFlowLayout alloc] init];
//    layout.itemSize  = CGSizeMake(100, 100);
    

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.dataSource =self;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
//    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([UICollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:waterFlowCellID];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:waterFlowCellID];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.ietms count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:waterFlowCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
@end
