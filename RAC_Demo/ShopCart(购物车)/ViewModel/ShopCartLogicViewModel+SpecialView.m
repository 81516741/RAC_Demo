//
//  ShopCartLogicViewModel+SpecialView.m
//  RAC_Demo
//
//  Created by ld on 17/1/11.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartLogicViewModel+SpecialView.h"
#import "ShopCartBottomBar.h"
#import "ShopCartModel.h"
#import <objc/runtime.h>
@implementation ShopCartLogicViewModel (SpecialView)

-(ShopCartBottomBar *)bottomBar
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBottomBar:(ShopCartBottomBar *)bottomBar
{
    objc_setAssociatedObject(self, @selector(bottomBar), bottomBar, OBJC_ASSOCIATION_RETAIN);
    [self gaoShiQing:bottomBar];
}
-(void)gaoShiQing:(ShopCartBottomBar *)bottomBar
{
    __weak typeof(self) selfWeak = self;
    __weak typeof(bottomBar) bottomBarWeak = bottomBar;
    [RACObserve(self,shopCartModel.allSelected) subscribeNext:^(id x) {
        bottomBar.checkBtn.selected = [x boolValue];
    }];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:kShopCartLogicViewModelUpdateUI object:nil]subscribeNext:^(id x) {
        [bottomBarWeak updatePayBtnGoodsNumber:selfWeak.shopCartModel.totalQuantity];
        [bottomBarWeak updateAllPrice:selfWeak.shopCartModel.totalPrice];
    }];
    [RACObserve(self, shopCartModel.allEdit) subscribeNext:^(id x) {
        bottomBarWeak.editView.hidden = ![x boolValue];
    }];
    [[bottomBar.checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton * x) {
        [selfWeak allSelectedClick:x];
    }];
    [[bottomBar.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton * x) {
        [selfWeak deleteSelectedCell];
    }];
}

@end
