//
//  ShopCartViewController.m
//  RAC_Demo
//
//  Created by ld on 17/1/11.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartBottomBar.h"
#import "ShopCartUIViewModel.h"
#import "ShopCartLogicViewModel.h"
#import "ShopCartLogicViewModel+SpecialView.h"

@interface ShopCartViewController ()
@property (weak, nonatomic) IBOutlet ShopCartBottomBar *bottomBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) ShopCartLogicViewModel * logicViewModel;
@property (nonatomic,strong) ShopCartUIViewModel * UIViewModel;
@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBaseParams];
    [self registerViewAndShow];
}

-(void)configBaseParams
{
    _UIViewModel = [[ShopCartUIViewModel alloc]init];
    _logicViewModel = [ShopCartLogicViewModel logicViewModel:_tableView tableViewDelegate:_UIViewModel inVC:self];
    _UIViewModel.logicViewModel = _logicViewModel;
    _logicViewModel.bottomBar = _bottomBar;
}


-(void)registerViewAndShow
{
    [_logicViewModel registerReuseCell:@"ShopCartCell" fromNib:true];
    [_logicViewModel registerReuseHeaderView:@"ShopCartHeaderView" fromNib:true];
    [_logicViewModel getDatas];
    [_logicViewModel.tableView reloadData];
}

-(void)dealloc
{
    NSLog(@"%@----销毁了",NSStringFromClass([self class]));
}
@end
