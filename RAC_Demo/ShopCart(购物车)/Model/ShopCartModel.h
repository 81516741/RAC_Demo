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
@property (assign ,nonatomic) NSInteger sectionSelectedCount;
@property (assign ,nonatomic) CGFloat totalPrice;
@property (assign ,nonatomic) NSInteger totalQuantity;
@property (assign ,nonatomic) BOOL allSelected;
@property (assign ,nonatomic) BOOL allEdit;
@end

@interface ShopCartSectionModel : NSObject
@property (nonatomic,strong) NSMutableArray * cellModels;

@property (assign ,nonatomic) CGFloat headerHeight;
@property (assign ,nonatomic) CGFloat footerHeight;
@property (assign ,nonatomic) BOOL selected;
@property (assign ,nonatomic) CGFloat selectedCount;
@property (assign ,nonatomic) BOOL sectionEdit;
@end

@interface ShopCartCellModel : NSObject

@property (assign ,nonatomic)  CGFloat cellHeight;
@property (assign ,nonatomic) BOOL selected;
@property (assign ,nonatomic) CGFloat price;
@property (assign ,nonatomic) NSInteger quantity;
@property (assign ,nonatomic) NSInteger maxQuantity;
@end
