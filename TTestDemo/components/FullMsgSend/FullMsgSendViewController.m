//
//  FullMsgSendViewController.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/18.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "FullMsgSendViewController.h"

@interface Person: NSObject

@end
@implementation Person
- (void)foo {
    NSLog(@"%s : do something ...",__func__);
}
@end

@interface FullMsgSendViewController ()

@end

@implementation FullMsgSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self performSelector:@selector(foo)];
}
/*
 如果在上一步还不能处理未知消息，则唯一能做的就是启用完整的消息转发机制了。
 首先它会发送-methodSignatureForSelector:消息获得函数的参数和返回值类型。如果-methodSignatureForSelector:返回nil ，Runtime则会发出 -doesNotRecognizeSelector: 消息，程序这时也就挂掉了。如果返回了一个函数签名，Runtime就会创建一个NSInvocation 对象并发送 -forwardInvocation:消息给目标对象。
 */

+(BOOL)resolveInstanceMethod:(SEL)sel {
    return YES; //进入下一步
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil; //进入下一步
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"foo"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"]; //签名 进入forwardInvocation
    }
    return [super methodSignatureForSelector:aSelector];
}
-(void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    Person *p = [Person new];
    if ([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    }else {
        [self doesNotRecognizeSelector:sel];
    }
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
