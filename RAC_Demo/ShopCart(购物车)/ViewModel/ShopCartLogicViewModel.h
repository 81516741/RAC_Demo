//
//  ShopCartLogicViewModel.h
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#define kShopCartLogicViewModelUpdateUI @"kShopCartLogicViewModelUpdateUI"
#import "ShopCartModel.h"
@interface ShopCartLogicViewModel : NSObject
//初始化方法
+(instancetype)logicViewModel:(UITableView *)tableView tableViewDelegate:(id) tableViewDelegate inVC:(UIViewController *)viewController;

//注册view的方法
-(void)registerReuseHeaderView:(NSString *)viewNames fromNib:(BOOL)fromNib;
-(void)registerReuseFooterView:(NSString *)viewNames fromNib:(BOOL)fromNib;
-(void)registerReuseCell:(NSString *)cellNames fromNib:(BOOL)fromNib;

//获取数据的方法
-(ShopCartCellModel *)cellModel:(NSIndexPath *)indexPath;
-(BOOL)sectionEdit:(NSIndexPath *)indexPath;
-(void)getDatas;
//刷新UI
-(void)updateSectionUI:(NSInteger)section;

//事件处理方法
-(void)cellSelectedClick:(NSIndexPath *)indexPath;
-(void)sectionSelectedClick:(NSInteger)section;
-(void)sectionEditBtnClick:(NSInteger)section;
-(void)allEditBtnClick:(UIButton *)btn;
-(void)allSelectedClick:(UIButton *)btn;
-(void)deleteCellByClick:(NSIndexPath *)indexPath;
-(void)deleteSelectedCell;
-(void)cellAddBtnClick:(NSIndexPath *)indexPath;
-(void)cellMinusBtnClick:(NSIndexPath *)indexPath;
-(void)cellTextFieldEndEdit:(NSIndexPath *)indexPath value:(NSInteger)value;


//需要保存的值
@property (nonatomic,weak,readonly) UITableView * tableView;
@property (nonatomic,weak,readonly) UIViewController * viewController;
@property (nonatomic,weak,readonly) id tableViewDelegate;
@property (nonatomic,copy,readonly) NSString * cellReuseID;
@property (nonatomic,copy,readonly) NSString * sectionHeaderReuseID;
@property (nonatomic,copy,readonly) NSString * sectionFooterReuseID;
@property (nonatomic,strong,readonly) ShopCartModel * shopCartModel;
@end

