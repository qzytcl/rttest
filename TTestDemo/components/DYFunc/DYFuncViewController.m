//
//  DYFuncViewController.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/18.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "DYFuncViewController.h"

@interface DYFuncViewController ()

@end

@implementation DYFuncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self performSelector:@selector(foo:)];
}
/*
 可以看到虽然没有实现foo:这个函数，但是我们通过class_addMethod动态添加fooMethod函数，并执行fooMethod这个函数的IMP。从打印结果看，成功实现了。

 如果resolve方法返回 NO ，运行时就会移到下一步：forwardingTargetForSelector。
 */
+(BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo:)) {
        class_addMethod([self class], sel, (IMP)fooMethod, "V@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
void fooMethod(id obj, SEL _cmd) {
    NSLog(@"foo doing some...");
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
