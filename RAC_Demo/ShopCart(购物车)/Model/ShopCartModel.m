//
//  ShopCartSectionModel.m
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartModel.h"
@implementation ShopCartModel

-(NSInteger)totalQuantity
{
    NSInteger totalQuantity = 0;
    for (ShopCartSectionModel * sectionModel in _sectionModels) {
        for (ShopCartCellModel * cellModel in sectionModel.cellModels) {
            totalQuantity += cellModel.selected ? 1:0;
        }
    }
    return totalQuantity;
}

-(CGFloat)totalPrice
{
    CGFloat totalPrice = 0.0;
    for (ShopCartSectionModel * sectionModel in _sectionModels) {
        for (ShopCartCellModel * cellModel in sectionModel.cellModels) {
            if (cellModel.selected) {
                totalPrice += cellModel.quantity * cellModel.price;
            }
        }
    }
    return totalPrice;
}
@end

@implementation ShopCartSectionModel

@end

@implementation ShopCartCellModel

@end
