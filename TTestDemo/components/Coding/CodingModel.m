//
//  CodingModel.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/25.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "CodingModel.h"
#import <objc/runtime.h>

@interface CodingModel() <NSCoding>

@end

@implementation CodingModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0 ; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}
-(instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [self init]) {
        //获取类属性及属性对应的类型
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *attributes = [NSMutableArray array];
        /*
         *例子
         *name = value3 attribute = T@"NSString",C,N,V_value3
         *name = value4 attribute = T^i,N,V_value4
         */
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            //通过property_getName函数 获取属性名
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
            //通过property_getAttributes函数 获取 属性名和@encode编码
            NSString *propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [attributes addObject:propertyAttribute];
        }
        //释放内存
        free(properties);
        
        //赋值
        for (NSString *key  in keys) {
            if ([dic valueForKey:key] == nil) continue;
            [self setValue:[dic valueForKey:key] forKey:key];
        }
    }
    return self;
}
@end
