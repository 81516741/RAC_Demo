//
//  ShopCartCell.m
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartCell.h"
#import "ShopCartModel.h"
@interface ShopCartCell()

@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *quantityLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewRightCons;
@property (weak, nonatomic) IBOutlet UIView *editView;

@end
@implementation ShopCartCell

-(void)updateCell:(ShopCartCellModel *)model sectionEdit:(BOOL)sectionEdit allEdit:(BOOL)allEdit
{
    _model = model;
    self.checkBtn.selected = model.selected;
    self.priceLable.text = [NSString stringWithFormat:@"¥%.0f",model.price];
    [self editControll:sectionEdit allEdit:allEdit];
    [self setQuantityValue];
}
-(void)editControll:(BOOL)sectionEdit allEdit:(BOOL)allEdit
{
    if (sectionEdit) {
        _editView.hidden = false;
        _editViewRightCons.constant = 50;
    }else{
        _editView.hidden = true;
    }
    if (allEdit) {
        self.editView.hidden = false;
        _editViewRightCons.constant = 0;
    }
    
}
-(void)setQuantityValue
{
    self.cellGoodsCountTextField.text = [NSString stringWithFormat:@"%ld",self.model.quantity];
    self.quantityLable.text = [NSString stringWithFormat:@"x%ld",self.model.quantity];;
}

-(void)dealloc
{
    NSLog(@"%@----销毁了",NSStringFromClass([self class]));
}
@end
