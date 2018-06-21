//
//  ShopCartUIViewModel.m
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartUIViewModel.h"
#import "ShopCartCell.h"
#import "ShopCartHeaderView.h"
#import "ShopCartModel.h"
#import <ReactiveObjC.h>
@implementation ShopCartUIViewModel
#pragma mark - delegate
#pragma mark cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.logicViewModel.shopCartModel.sectionModels.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.logicViewModel.shopCartModel.sectionModels[section] cellModels] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.logicViewModel cellModel:indexPath].cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCartCell * cell = [tableView dequeueReusableCellWithIdentifier:self.logicViewModel.cellReuseID];
    __weak typeof(self) selfWeak = self;
    [[[cell.checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(UIButton * x) {
        [selfWeak.logicViewModel cellSelectedClick:indexPath];
    }];
    [[[cell.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(UIButton * x) {
        [selfWeak.logicViewModel cellAddBtnClick:indexPath];
    }];
    [[[cell.minusBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(UIButton * x) {
        [selfWeak.logicViewModel cellMinusBtnClick:indexPath];
    }];
    [[[cell.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
        [selfWeak.logicViewModel deleteCellByClick:indexPath];
    }];
    [[[cell.cellGoodsCountTextField rac_signalForControlEvents:UIControlEventEditingDidEnd]takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(UITextField * textField) {
        [selfWeak.logicViewModel cellTextFieldEndEdit:indexPath value:[textField.text integerValue]];
    }];
    [cell updateCell:[_logicViewModel cellModel:indexPath] sectionEdit:[_logicViewModel sectionEdit:indexPath] allEdit:_logicViewModel.shopCartModel.allEdit];
    return cell;
}

#pragma mark header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.logicViewModel.shopCartModel.sectionModels[section] headerHeight];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShopCartHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.logicViewModel.sectionHeaderReuseID];
    __weak typeof(self) selfWeak = self;
    [[[headerView.checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:headerView.rac_prepareForReuseSignal]subscribeNext:^(UIButton * x) {
        [selfWeak.logicViewModel sectionSelectedClick:section];
    }];
    [[[headerView.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:headerView.rac_prepareForReuseSignal]subscribeNext:^(UIButton * x) {
        [selfWeak.logicViewModel sectionEditBtnClick:section];
    }];
    
    [[[headerView.jumpToShopBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:headerView.rac_prepareForReuseSignal]subscribeNext:^(UIButton * x) {
        NSLog(@"jump to destination viewController");
    }];
    [headerView updateHeaderView:_logicViewModel.shopCartModel.sectionModels[section] allEdit:_logicViewModel.shopCartModel.allEdit];
    return headerView;
}

#pragma mark 删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ![self.logicViewModel.shopCartModel.sectionModels[indexPath.section] sectionEdit];;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.logicViewModel deleteCellByClick:indexPath];
    }
}

#pragma mark - 创建UI
-(void)setLogicViewModel:(ShopCartLogicViewModel *)logicViewModel
{
    _logicViewModel = logicViewModel;
    [self creatNaviBarItem];
}

-(void)creatNaviBarItem
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
    self.logicViewModel.viewController.navigationItem.rightBarButtonItem = rightItem;
    __weak typeof(self) selfWeak = self;
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton * x) {
        [selfWeak.logicViewModel allEditBtnClick:x];
    }];
}
-(void)dealloc
{
    NSLog(@"%@----销毁了",NSStringFromClass([self class]));
}
@end

