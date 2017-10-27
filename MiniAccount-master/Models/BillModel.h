//
//  BillModel.h
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/9.
//  Copyright © 2017年 Pugc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+BGModel.h"

@interface BillModel : NSObject


@property (nonatomic,copy) NSString *typeName;

@property (nonatomic,copy) NSString *picName;

@property (nonatomic,copy) NSString *theTime;

@property (nonatomic,copy) NSString *mounth;

@property (nonatomic,copy) NSString *year;

@property (nonatomic,assign) BOOL isPay;

@property (nonatomic,assign) double money;

@property (nonatomic,copy) NSString * remarke;

@property (nonatomic,copy) NSString * detailType;

@end
