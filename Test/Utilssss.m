//
//  Utilssss.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/16.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "Utilssss.h"


#define SpecialStrLen2 @"⎱"
#define SpecialStrLen1 @"⎰"

@implementation Utilssss
+(BOOL)checkAtion:(NSArray *)arr m:(NSInteger)m w:(NSInteger)w {
    NSInteger sum = 0,k = 0,circle = 1;
    for (NSInteger i = 0; i < arr.count - m; i++) {
        NSInteger value = [arr[i] integerValue];
        if (k < m) {
            sum+=value;
            k++;
        }else {
            if (sum/m > w) {
                return YES;
            }else {
                sum-= [arr[i - k * circle] integerValue];
                k--;
            }
            circle++;
        }
    }
    return NO;
}

+(BOOL)checkAtion2:(NSArray *)arr m:(NSInteger)m w:(NSInteger)w {
    
    for (NSInteger i = 0; i < arr.count - m; i++) {
        NSInteger sum = 0;
        for (NSInteger idx = 0; idx < m; idx++) {
            sum+=[arr[idx+i] integerValue];
            if (sum/m > w) {
                return YES;
            }
        }
    }
    return NO;
}

+ (NSString *)getTextWithArray:(NSArray *)array {
    NSString *str = @"";
    if (array.count == 0) {
        return str;
    }
    for (NSDictionary *dic in array) {
        NSArray *keyArray = [dic allKeys];
        for (int i = 0;i < keyArray.count;i++) {
            NSString *key = keyArray[i];
            
            NSString *str2 = [Utilssss replaceString:dic[key]];
            
            NSString *str1 = [NSString stringWithFormat:@"%@=%@",key,str2];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",str1]];
            if (i == keyArray.count - 1) {
                str = [str stringByAppendingString:@"\\n"];
            }else {
                str = [str stringByAppendingString:@";"];
            }
        }
    }
    return str;
}

+(NSArray *)getArrayWithText:(NSString *)text {
    NSMutableArray *result = [NSMutableArray new];
    if (text.length == 0 || text == nil) {
        return result;
    }
    NSArray *arr = [text componentsSeparatedByString:@"\\n"];
    for (NSString *item in arr) {
        if (item.length == 0 || item == nil) {
            continue;
        }
        NSArray *itemArr = [item componentsSeparatedByString:@";"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *itemArrString in itemArr) {
            NSArray *tempArr = [itemArrString componentsSeparatedByString:@"="];
            NSLog(@"%s :%@",__func__,tempArr.lastObject);
            NSString *tempStr = [Utilssss recoverString:tempArr.lastObject];
            [dic setValue:tempStr forKey:tempArr.firstObject];
        }
        [result addObject:dic];
    }
    return result;
}
+ (NSString *)replaceString:(NSString *)str {
    NSMutableString *resultStr = [NSMutableString string];
    for (NSInteger j = 0; j < str.length; j++) {
        NSString * indexStr1 = [str substringWithRange:NSMakeRange(j, 1)];
        if ([indexStr1 isEqualToString:@"\n"]) {
            [resultStr appendString:SpecialStrLen2];
            continue;
        }else if ([indexStr1 isEqualToString:@";"]) {
            [resultStr appendString:SpecialStrLen1];
            continue;
        }else{
            [resultStr appendString:indexStr1];
        }
    }
    return resultStr;
}
+(NSString *)recoverString:(NSString *)str {
    NSMutableString *resultStr = [NSMutableString string];
    for (NSInteger j = 0; j < str.length; j++) {
        NSString * indexStr1 = [str substringWithRange:NSMakeRange(j, 1)];
        if ([indexStr1 isEqualToString:SpecialStrLen2]) {
            [resultStr appendString:@"\n"];
            continue;
        }else if ([indexStr1 isEqualToString:SpecialStrLen1]) {
            [resultStr appendString:@";"];
            continue;
        }else{
            [resultStr appendString:indexStr1];
        }
    }
    return resultStr;
}
@end
