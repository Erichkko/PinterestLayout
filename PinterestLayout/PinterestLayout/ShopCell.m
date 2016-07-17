//
//  ShopCell.m
//  PinterestLayout
//
//  Created by wanglong on 16/7/17.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "ShopCell.h"
#import "UIImageView+WebCache.h"
#import "Shop.h"
@interface ShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation ShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setShop:(Shop *)shop
{
    _shop = shop;
//    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLabel.text =shop.price;
    
}
@end
