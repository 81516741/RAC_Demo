//
//  ShopCartCell.h
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCartCellModel;
@interface ShopCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (nonatomic,strong) ShopCartCellModel * model;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UITextField *cellGoodsCountTextField;
-(void)updateCell:(ShopCartCellModel *)model sectionEdit:(BOOL)sectionEdit allEdit:(BOOL)allEdit;


@end
