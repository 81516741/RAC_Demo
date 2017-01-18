//
//  ShopCartUIViewModel.h
//  RAC_Demo
//
//  Created by ld on 17/1/10.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartLogicViewModel.h"
@interface ShopCartUIViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) ShopCartLogicViewModel * logicViewModel;
@end

