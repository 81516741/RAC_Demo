//
//  ShopCartHeaderView.h
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCartSectionModel;
@interface ShopCartHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *jumpToShopBtn;
@property (nonatomic,strong) ShopCartSectionModel * model;
-(void)updateHeaderView:(ShopCartSectionModel *)model allEdit:(BOOL)allEdit;
@end
