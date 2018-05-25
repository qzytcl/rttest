//
//  ForwardingTargetViewController.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/18.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "ForwardingTargetViewController.h"

@interface Person1: NSObject

@end

@implementation Person1
- (void)foo {
    NSLog(@"%s do something...",__func__);
}
@end

@interface ForwardingTargetViewController ()

@end

@implementation ForwardingTargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self performSelector:@selector(foo)];
}
/*
 如果目标对象实现了-forwardingTargetForSelector:，Runtime 这时就会调用这个方法，给你把这个消息转发给其他对象的机会。
 */

// 消息转发实例方法
+(BOOL)resolveInstanceMethod:(SEL)sel {
    return YES; //return yes,进入下一步转发
}
// 消息转发类方法
+(BOOL)resolveClassMethod:(SEL)sel {
    return YES;
}
// 消息转发对象
-(id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(foo)) {
        return [Person1 new];
    }
    return [super forwardingTargetForSelector:aSelector];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
