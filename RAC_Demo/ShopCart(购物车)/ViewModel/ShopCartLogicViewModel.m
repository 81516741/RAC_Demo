//
//  ShopCartLogicViewModel.m
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ShopCartLogicViewModel.h"
#define kUpdateUI [[NSNotificationCenter defaultCenter]postNotificationName:kShopCartLogicViewModelUpdateUI object:nil userInfo:nil];

@implementation ShopCartLogicViewModel
+(instancetype)logicViewModel:(UITableView *)tableView tableViewDelegate:(id)tableViewDelegate inVC:(UIViewController *)viewController
{
    ShopCartLogicViewModel * logicViewModel = [[ShopCartLogicViewModel alloc]init];
    logicViewModel->_tableView = tableView;
    logicViewModel->_tableViewDelegate = tableViewDelegate;
    logicViewModel->_viewController = viewController;
    logicViewModel->_shopCartModel = [[ShopCartModel alloc]init];
    tableView.delegate = tableViewDelegate;
    tableView.dataSource = tableViewDelegate;
    tableView.sectionFooterHeight = 0;
    return logicViewModel;
}


-(void)registerReuseHeaderView:(NSString *)viewName fromNib:(BOOL)fromNib
{
    if (fromNib) {
        [self.tableView registerNib:[UINib nibWithNibName:viewName bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:viewName];
    }else{
        [self.tableView registerClass:NSClassFromString(viewName) forHeaderFooterViewReuseIdentifier:viewName];
    }
    _sectionHeaderReuseID = [viewName copy];
}

-(void)registerReuseFooterView:(NSString *)viewName fromNib:(BOOL)fromNib
{
    if (fromNib) {
        [self.tableView registerNib:[UINib nibWithNibName:viewName bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:viewName];
    }else{
        [self.tableView registerClass:NSClassFromString(viewName) forHeaderFooterViewReuseIdentifier:viewName];
    }
    _sectionFooterReuseID = [viewName copy];
}

-(void)registerReuseCell:(NSString *)cellName fromNib:(BOOL)fromNib
{
    if (fromNib) {
        [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
    }else{
        [self.tableView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
    }
    _cellReuseID = [cellName copy];
}

#pragma mark - 数据相关
-(void)getDatas
{
    NSMutableArray * sectionModels = @[].mutableCopy;
    for (int i = 0 ; i < 5; i ++) {
        int rowCount = (arc4random() % 5) + 1;
        ShopCartSectionModel * sectionModel = [[ShopCartSectionModel alloc]init];
        sectionModel.headerHeight = 35;
        sectionModel.footerHeight = 0;
        sectionModel.selected = NO;
        sectionModel.selectedCount = 0;
        sectionModel.sectionEdit = NO;
        NSMutableArray * cellModels = @[].mutableCopy;
        for (int j = 0 ; j < rowCount; j ++) {
            ShopCartCellModel * cellModel = [[ShopCartCellModel alloc]init];
            cellModel.selected = NO;
            cellModel.cellHeight = 80;
            cellModel.price = (arc4random() % 100000) + 1;
            cellModel.quantity = (arc4random() % 100) + 1;
            cellModel.maxQuantity = (arc4random() % 1000) + 101;
            [cellModels addObject:cellModel];
        }
        sectionModel.cellModels = cellModels;
        [sectionModels addObject:sectionModel];
    }
    _shopCartModel.sectionModels = sectionModels;
    _shopCartModel.allSelected = NO;
    _shopCartModel.totalPrice = 0.0;
    _shopCartModel.totalQuantity = 0;
    _shopCartModel.sectionSelectedCount = 0;
    _shopCartModel.allEdit = NO;
    [self addKVOFunction];
}

-(void)addKVOFunction
{
    __weak typeof(self) selfWeak = self;
    /*
     * 这里监听自身sectionSelectedCount值的变化，这个值决定
     * bottomBar的checkBtn的选中状态，当allSelected的值改变
     * 会通知 ShopCartLogicViewModel+SpecialView 做出反应
     * sectionSelectedCount 值改变的地方如下1处:
     * 1.这段代码后面的for循环里面
     */
    [RACObserve(self, shopCartModel.sectionSelectedCount)subscribeNext:^(id x) {
        if (selfWeak.shopCartModel.sectionModels.count == [x integerValue]) {
            selfWeak.shopCartModel.allSelected = YES;
        }else{
            selfWeak.shopCartModel.allSelected = NO;
        }
    }];
    /*
     * 这里监听所有sectionModel的selected值的变化
     * 这个值决定自身sectionSelectedCount的值
     * 注意 因为sectionSelectedCount是根据sectionModel的selcted
     * 属性改变计算出来的，所以不要随便给它赋值，这里有2处
     * a.初始化 b.删除操作后校验section的选中状态
     * selected的值改变的地方如下4处:
     * 1.allSelectedClick:这个方法里面
     * 2.sectionSelectedClick:这个方法里面
     * 3.cellSelectedClick:这个方法里面
     * 4.checkSectionModelSelectedState 这个方法里面
     */
    for (ShopCartSectionModel * sectionModel in self.shopCartModel.sectionModels) {
        /*
         * 除了点击会调用这个kvo，还有2处会调用：
         * 1.全选   2.删除后的校验
         */
        [RACObserve(sectionModel, selected) subscribeNext:^(id x) {
            if ([x boolValue]) {
                //全选的时候会把sectionModel的selected全部变为YES
                if (selfWeak.shopCartModel.sectionSelectedCount != selfWeak.shopCartModel.sectionModels.count) {
                    selfWeak.shopCartModel.sectionSelectedCount += 1;
                }
            }else{
                //因为创建模型赋值时会调用这里
                if (selfWeak.shopCartModel.sectionSelectedCount != 0) {
                    selfWeak.shopCartModel.sectionSelectedCount -= 1;
                }
            }
        }];
    }
}

-(ShopCartCellModel *)cellModel:(NSIndexPath *)indexPath
{
    return [[self.shopCartModel.sectionModels[indexPath.section] cellModels] objectAtIndex:indexPath.row];
}

-(BOOL)sectionEdit:(NSIndexPath *)indexPath
{
    return [self.shopCartModel.sectionModels[indexPath.section] sectionEdit];
}

#pragma mark - 逻辑处理
-(void)cellSelectedClick:(NSIndexPath *)indexPath
{
    ShopCartSectionModel * sectionModel = self.shopCartModel.sectionModels[indexPath.section];
    ShopCartCellModel * model = sectionModel.cellModels[indexPath.row];
    model.selected = !model.selected;
    //刷新界面
    [self updateSectionUI:indexPath.section];

    sectionModel.selectedCount += (model.selected ? 1 : (-1));
    if (sectionModel.selectedCount == sectionModel.cellModels.count) {
        if (sectionModel.selected != YES) {
            sectionModel.selected = YES;
            //刷新界面
            [self updateSectionUI:indexPath.section];
        }
    }else{
        if (sectionModel.selected != NO) {
            sectionModel.selected = NO;
            //刷新界面
            [self updateSectionUI:indexPath.section];
        }
    }

}

-(void)sectionSelectedClick:(NSInteger)section
{
    ShopCartSectionModel * sectionModel = self.shopCartModel.sectionModels[section];
    sectionModel.selected = !sectionModel.selected;
    [sectionModel.cellModels setValue:@(sectionModel.selected) forKey:@"selected"];
    sectionModel.selectedCount = sectionModel.selected ? sectionModel.cellModels.count : 0;
    //刷新界面
    [self updateSectionUI:section];
}

-(void)allSelectedClick:(UIButton *)btn
{
    self.shopCartModel.allSelected = !self.shopCartModel.allSelected;
    btn.selected = self.shopCartModel.allSelected;
    [self.shopCartModel.sectionModels setValue:@(self.shopCartModel.allSelected) forKey:@"selected"];
    for (ShopCartSectionModel * sectionModel in self.shopCartModel.sectionModels) {
        [sectionModel.cellModels setValue:@(self.shopCartModel.allSelected) forKey:@"selected"];
        if (self.shopCartModel.allSelected) {
            sectionModel.selectedCount = sectionModel.cellModels.count;
        }else{
            sectionModel.selectedCount = 0;
        }
    }
    //刷新界面
    [self updateTableViewUI];
}

-(void)deleteCellByClick:(NSIndexPath *)indexPath
{
    __weak typeof(self) selfWeak = self;
    [self alert:@"确认要删除这个宝贝吗？" handle:^{
        [selfWeak removeCellAtIndexPath:indexPath];
    }];
}
-(void)deleteSelectedCell
{
    __weak typeof(self) selfWeak = self;
    if (_shopCartModel.totalQuantity < 1) {
        NSLog(@"您还没有选择宝贝提示语");
        return;
    }
    [self alert:[NSString stringWithFormat:@"确认将这%ld宝贝删除？",_shopCartModel.totalQuantity] handle:^{
        [selfWeak removeAllSelectedCell];
    }];
}
-(void)removeCellAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCartSectionModel * sectionModel = self.shopCartModel.sectionModels[indexPath.section];
    [sectionModel.cellModels removeObjectAtIndex:indexPath.row];
    if (sectionModel.cellModels.count == 0) {
        [self.shopCartModel.sectionModels removeObject:sectionModel];
    }
    [self afterDeleteOperation];
}

-(void)removeAllSelectedCell
{
    _shopCartModel.sectionModels = [[[[[[[_shopCartModel.sectionModels rac_sequence] map:^id(ShopCartSectionModel * sectionModel) {
        sectionModel.cellModels = [[[[sectionModel.cellModels rac_sequence]filter:^BOOL(ShopCartCellModel * cellModel) {
            return !cellModel.selected;
        }]array]mutableCopy];
        return sectionModel;
    }]array] rac_sequence]filter:^BOOL(ShopCartSectionModel * sectionModel) {
        return sectionModel.cellModels.count > 0;
    }] array]mutableCopy];
    [self afterDeleteOperation];
}
-(void)afterDeleteOperation
{
    [self checkSectionModelSelectedState];
    [self updateTableViewUI];
}

-(void)checkSectionModelSelectedState
{
    _shopCartModel.sectionSelectedCount = 0;
    for (ShopCartSectionModel * sectionModel in self.shopCartModel.sectionModels) {
        NSInteger selectedCount = 0;
        for (ShopCartCellModel * cellModel in sectionModel.cellModels) {
            selectedCount += cellModel.selected ? 1:0;
        }
        sectionModel.selectedCount = selectedCount;
        BOOL sectionSelected = (sectionModel.cellModels.count == sectionModel.selectedCount);
        /*
         * 因为个方法是删除后校验，那么section如果校验后是未选中，那么
         * 以前肯定是没有选中的，主需要将检验后是选中的重新赋值，就可以保
         * 证section的选中状态是对的，同时也校验sectionSelectedCount
         */
        if (sectionSelected) {
            sectionModel.selected = sectionSelected;
        }
    }
}


-(void)sectionEditBtnClick:(NSInteger)section
{
    ShopCartSectionModel * sectionModel = self.shopCartModel.sectionModels[section];
    sectionModel.sectionEdit = !sectionModel.sectionEdit;
    [self updateSectionUI:section];
}

-(void)allEditBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.shopCartModel.allEdit = btn.selected;
    if (self.shopCartModel.allEdit) {
        [self.shopCartModel.sectionModels setValue:@(NO) forKey:@"sectionEdit"];
    }
    [self updateTableViewUI];
}

-(void)cellAddBtnClick:(NSIndexPath *)indexPath
{
    ShopCartCellModel * cellModel = [self cellModel:indexPath];
    cellModel.quantity += 1;
    if (cellModel.quantity > cellModel.maxQuantity) {
        cellModel.quantity = cellModel.maxQuantity;
        NSLog(@"商品数量大于库存的提示语");
    }
    [self updateCellUI:indexPath];
}

-(void)cellMinusBtnClick:(NSIndexPath *)indexPath
{
    ShopCartCellModel * cellModel = [self cellModel:indexPath];
    cellModel.quantity -= 1;
    if (cellModel.quantity < 1) {
        cellModel.quantity = 1;
        NSLog(@"商品数量小于1的提示语");
    }
    [self updateCellUI:indexPath];
}

-(void)cellTextFieldEndEdit:(NSIndexPath *)indexPath value:(NSInteger)value
{
    ShopCartCellModel * cellModel = [self cellModel:indexPath];
    cellModel.quantity = value;
    if (value < 1) {
        cellModel.quantity = 1;
        NSLog(@"商品数量小于1的提示语");
    }
    if (value > cellModel.maxQuantity) {
        cellModel.quantity = cellModel.maxQuantity;
        NSLog(@"商品数量大于库存的提示语");
    }
    [self updateCellUI:indexPath];
}

-(void)updateCellUI:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    kUpdateUI
}

-(void)updateSectionUI:(NSInteger)section
{
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    kUpdateUI
}
-(void)updateTableViewUI
{
    [self.tableView reloadData];
    kUpdateUI
}
-(void)alert:(NSString *)title handle:(void(^)())handle
{
    UIAlertController * alertViewController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action0 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handle) {
            handle();
        }
    }];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertViewController addAction: action1];
    [alertViewController addAction: action0];
    [self.viewController presentViewController:alertViewController animated:YES completion:nil];
}

-(void)dealloc
{
    NSLog(@"%@----销毁了",NSStringFromClass([self class]));
}
@end
