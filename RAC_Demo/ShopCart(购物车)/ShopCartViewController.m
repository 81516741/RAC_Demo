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
#import <ReactiveCocoa/ReactiveCocoa.h>

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
    [self creatRightBtn];
}

-(void)creatRightBtn
{
    UIButton * rightBtn = [[UIButton alloc]init];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.frame = CGRectMake(12, 0, 44, 44);
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    UIView * wrapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [wrapView addSubview:rightBtn];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:wrapView];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.logicViewModel.navRightButton = rightBtn;
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
