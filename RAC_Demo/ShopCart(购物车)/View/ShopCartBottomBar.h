//
//  ShopCartBottomBar.h
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ShopCartBottomBar : UIView
-(void)updatePayBtnGoodsNumber:(NSInteger)number;
-(void)updateAllPrice:(CGFloat)prices;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
