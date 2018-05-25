//
//  UsingViewController.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/18.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "UsingViewController.h"

@interface UIView (DefaultColor)

@property (nonatomic, strong) UIColor *defaultColor;
@end

@implementation UIView (DefaultColor)

@dynamic defaultColor;

static char kDefaultColor;

- (void)setDefaultColor:(UIColor *)defaultColor {
    objc_setAssociatedObject(self, &kDefaultColor, defaultColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)defaultColor {
    return objc_getAssociatedObject(self, &kDefaultColor);
}

@end


@interface UsingViewController ()

@end

@implementation UsingViewController

/*
 swizzling应该只在+load中完成。
 在 Objective-C 的运行时中，每个类有两个方法都会自动调用。
 +load 是在一个类被初始装载时调用，
 +initialize 是在应用第一次调用该类的类方法或实例方法前调用的。
 两个方法都是可选的，并且只有在方法被实现的情况下才会被调用。
 */

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(rtViewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}
- (void)rtViewDidLoad {
    NSLog(@"替换 method....");
    [self rtViewDidLoad];
}

- (void)viewDidLoad {
    NSLog(@"自带 method....");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *test =[UIView new];
    test.frame = CGRectMake(0, 0, 100, 100);
    
    test.defaultColor = [UIColor blueColor];
    NSLog(@"%@",test.defaultColor);
    [self.view addSubview:test];
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
