//
//  ShopCartHeaderView.m
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartHeaderView.h"
#import "ShopCartModel.h"
@implementation ShopCartHeaderView
-(void)awakeFromNib
{
    [super awakeFromNib];
    _editBtn.tintColor = [UIColor whiteColor];
    [_editBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
}

-(void)updateHeaderView:(ShopCartSectionModel *)model allEdit:(BOOL)allEdit
{
    _model = model;
    self.checkBtn.selected = model.selected;
    self.editBtn.selected = model.sectionEdit;
    self.editBtn.hidden = allEdit;
    self.jumpToShopBtn.enabled = !allEdit;
}

-(void)dealloc
{
    NSLog(@"%@----销毁了",NSStringFromClass([self class]));
}

@end
