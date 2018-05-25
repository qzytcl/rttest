//
//  ViewController.m
//  TTestDemo
//
//  Created by 付顺龙 on 2018/5/16.
//  Copyright © 2018年 Bilos. All rights reserved.
//

#import "ViewController.h"
#import "Utilssss.h"
#import <objc/runtime.h>
#import "ForwardingTargetViewController.h"
#import "FullMsgSendViewController.h"
#import "DYFuncViewController.h"
#import "UsingViewController.h"
#import "KVOViewController.h"

typedef enum : NSUInteger {
    kRTDYFunc = 1,
    kRTFullMsgSend = 2,
    kRTForwardingTarget = 3,
    kRTUsing = 4,
    kRTKVO = 5,
} kRTType;

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *arr;
@end

@implementation ViewController

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSString *)BykRTType:(kRTType)type {
    switch (type) {
        case kRTDYFunc:
            return @"动态方法解析";
            break;
        case kRTFullMsgSend:
            return @"完整消息转发";
            break;
        case kRTForwardingTarget:
            return @"备用接受者";
            break;
        case kRTUsing:
            return @"runtime应用";
            break;
        case kRTKVO:
            return @"KVO";
            break;
        default:
            return @"动态方法解析";
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arr  = @[@1, @2, @3, @4,@5];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    kRTType value = (kRTType)[self.arr[indexPath.row] integerValue];
    switch (value) {
        case kRTDYFunc:{
            DYFuncViewController *vc = [DYFuncViewController new];
            vc.title = [self BykRTType:kRTDYFunc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kRTFullMsgSend: {
            FullMsgSendViewController *vc = [FullMsgSendViewController new];
            vc.title = [self BykRTType:kRTFullMsgSend];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kRTForwardingTarget:{
            ForwardingTargetViewController *vc = [ForwardingTargetViewController new];
            vc.title = [self BykRTType:kRTForwardingTarget];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kRTUsing:{
            UsingViewController *vc = [UsingViewController new];
            vc.title = [self BykRTType:kRTUsing];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kRTKVO:{
            KVOViewController *vc = [KVOViewController new];
            vc.title = [self BykRTType:kRTUsing];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark TableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"runtimeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self BykRTType:(kRTType)[self.arr[indexPath.row] integerValue]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}
@end
