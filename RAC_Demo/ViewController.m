//
//  ViewController.m
//  RAC_Demo
//
//  Created by ld on 17/1/5.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[NSClassFromString(@"ShopCartViewController") new]animated:true];
}

@end
