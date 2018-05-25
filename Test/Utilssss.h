//
//  Utilssss.h
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/16.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilssss : NSObject
+(BOOL)checkAtion:(NSArray *)arr m:(NSInteger)m w:(NSInteger)w;
+(BOOL)checkAtion2:(NSArray *)arr m:(NSInteger)m w:(NSInteger)w;
+ (NSString *)getTextWithArray:(NSArray *)array;
+ (NSArray *)getArrayWithText:(NSString *)text;

@end
