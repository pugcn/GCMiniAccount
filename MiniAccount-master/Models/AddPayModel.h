//
//  AddPayModel.h
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/14.
//  Copyright © 2017年 Pugc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+BGModel.h"
@interface AddPayModel : NSObject


@property (nonatomic,copy) NSString *title;

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,copy) NSString * imgName;

@property (nonatomic,copy) NSString * picName;

@property (nonatomic,strong) NSArray<NSString *> * detailArr;

-(NSArray<AddPayModel *> *)getPayArray;

-(NSArray<AddPayModel *> *)getIncoumeArray;
@end
