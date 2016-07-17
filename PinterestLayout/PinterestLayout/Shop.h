//
//  Shop.h
//  PinterestLayout
//
//  Created by wanglong on 16/7/17.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Shop : NSObject
/**img*/
@property(nonatomic,copy)NSString *img;
/**price*/
@property(nonatomic,copy)NSString *price;
/**w*/
@property(nonatomic,assign)CGFloat  w;
/**h*/
@property(nonatomic,assign)CGFloat h;
@end
