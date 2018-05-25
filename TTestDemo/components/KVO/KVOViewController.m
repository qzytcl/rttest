//
//  KVOViewController.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/25.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "KVOViewController.h"


/*
 全称是Key-value observing，翻译成键值观察。
 提供了一种当其它对象属性被修改的时候能通知当前对象的机制。
 再MVC大行其道的Cocoa中，KVO机制很适合实现model和controller类之间的通讯。
 */
@interface KVOViewController ()

@end

@implementation KVOViewController
/*
 KVO 的键值观察通知依赖于 NSObject 的两个方法:willChangeValueForKey:和 didChangeValueForKey: ，在存取数值的前后分别调用 2 个方法：
 被观察属性发生改变之前，willChangeValueForKey:被调用，通知系统该 keyPath 的属性值即将变更；
 当改变发生后， didChangeValueForKey: 被调用，通知系统该keyPath 的属性值已经变更；之后， observeValueForKey:ofObject:change:context:也会被调用。且重写观察属性的setter 方法这种继承方式的注入是在运行时而不是编译时实现的。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"self->isa:%@",object_getClass(self));
    NSLog(@"self class:%@",[self class]);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"mike" forKey:@"name"];
}
- (void)setName:(NSString *)newnName {
    NSLog(@"asdfasdf");
    [self willChangeValueForKey:@"name"];
    [super setValue:newnName forKey:@"name"];
    [self didChangeValueForKey:@"name"];
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
