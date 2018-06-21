//
//  ShopCartModel.h
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartModel: NSObject
@property (nonatomic,strong) NSMutableArray * sectionModels;
/**
 * 有多少个区域被选中
 */
@property (assign ,nonatomic) NSInteger sectionSelectedCount;
/**
 * 所有被选中商品的总价格
 */
@property (assign ,nonatomic) CGFloat totalPrice;
/**
 * 所有选中商品的数量，同一个商品只计数一次，比如之选中了A商品
 * 但是A商品的数量有10个，那么totalQuantity 值是1
 */
@property (assign ,nonatomic) NSInteger totalQuantity;
/**
 * 是否全部选中
 */
@property (assign ,nonatomic) BOOL allSelected;
/**
 * 是否是全编辑状态，也就是navigationBar的编辑按钮是否点击了
 */
@property (assign ,nonatomic) BOOL allEdit;
@end

@interface ShopCartSectionModel : NSObject
@property (nonatomic,strong) NSMutableArray * cellModels;

@property (assign ,nonatomic) CGFloat headerHeight;
@property (assign ,nonatomic) CGFloat footerHeight;
/**
 * 记录每一个header的复选框是否为选中状态
 */
@property (assign ,nonatomic) BOOL selected;
/**
 * 每一个section中选中的cell 个数
 */
@property (assign ,nonatomic) CGFloat selectedCount;
/**
 * header的编辑按钮是否为选中状态
 */
@property (assign ,nonatomic) BOOL sectionEdit;
@end

@interface ShopCartCellModel : NSObject

@property (assign ,nonatomic)  CGFloat cellHeight;
/**
 * 每个cell是否为选中
 */
@property (assign ,nonatomic) BOOL selected;
@property (assign ,nonatomic) CGFloat price;
@property (assign ,nonatomic) NSInteger quantity;
@property (assign ,nonatomic) NSInteger maxQuantity;
@end
