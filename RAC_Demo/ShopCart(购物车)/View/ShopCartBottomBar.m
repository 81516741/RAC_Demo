//
//  ShopCartBottomBar.m
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartBottomBar.h"
#import "Masonry.h"
static CGFloat kSingleShowMinWidth = 279;

@interface ShopCartBottomBar()
@property (weak, nonatomic) IBOutlet UILabel *singlePriceLable;
@property (weak, nonatomic) IBOutlet UIView *singleShowView;
@property (weak, nonatomic) IBOutlet UILabel *doublePriceLable;
@property (weak, nonatomic) IBOutlet UIView *doubleShowView;


@end

@implementation ShopCartBottomBar

-(void)awakeFromNib
{
    [super awakeFromNib];
    UIView * view = [[[NSBundle mainBundle]loadNibNamed:@"ShopCartBottomBar" owner:self options:nil]lastObject];
    [self addSubview:view];
    __weak typeof(self) selfWeak = self;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selfWeak);
        make.bottom.equalTo(selfWeak);
        make.right.equalTo(selfWeak);
        make.top.equalTo(selfWeak);
    }];
}

-(void)updatePayBtnGoodsNumber:(NSInteger)number
{
    self.payBtn.titleLabel.text = [NSString stringWithFormat:@"结算(%ld)",number];
    [self.payBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",number] forState:UIControlStateNormal];
}

-(void)updateAllPrice:(CGFloat)prices
{
    self.singlePriceLable.text = [NSString stringWithFormat:@"¥%.1f",prices];
    self.doublePriceLable.text = [NSString stringWithFormat:@"¥%.1f",prices];
    CGSize size = [self.singlePriceLable sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (size.width + 5 > [UIScreen mainScreen].bounds.size.width - kSingleShowMinWidth) {
        self.singleShowView.hidden = true;
        self.doubleShowView.hidden = false;
    }else{
        self.singleShowView.hidden = false;
        self.doubleShowView.hidden = true;
    }
}
-(void)dealloc
{
    NSLog(@"%@----销毁了",NSStringFromClass([self class]));
}

@end
