//
//  CodingModel.h
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/25.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodingModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
