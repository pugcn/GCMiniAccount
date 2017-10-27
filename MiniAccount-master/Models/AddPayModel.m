//
//  AddPayModel.m
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/14.
//  Copyright © 2017年 Pugc. All rights reserved.
//

#import "AddPayModel.h"

@implementation AddPayModel


-(NSArray<AddPayModel *> *)getPayArray{
    NSString *file = [[NSBundle mainBundle]pathForResource:@"AccountPayType" ofType:@"plist"];
    NSMutableArray *tempArray = [NSMutableArray new];
    tempArray =[NSMutableArray arrayWithContentsOfFile:file];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dict in tempArray){
        
        AddPayModel   *model = [AddPayModel bg_objectWithDictionary:dict];
        [arr addObject:model];
    }
    return arr;
}

-(NSArray<AddPayModel *> *)getIncoumeArray{
    NSString *file = [[NSBundle mainBundle]pathForResource:@"AccountIncomeType" ofType:@"plist"];
    NSMutableArray *tempArray = [NSMutableArray new];
    tempArray =[NSMutableArray arrayWithContentsOfFile:file];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dict in tempArray){
        
        AddPayModel   *model = [AddPayModel bg_objectWithDictionary:dict];
        model.isSelected = false;
        [arr addObject:model];
    }
    return arr;
}
@end
