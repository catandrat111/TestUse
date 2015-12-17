//
//  KVOCustomViewController.m
//  TEST11
//
//  Created by dongjl on 15/12/16.
//  Copyright © 2015年 djl. All rights reserved.
//http://www.jianshu.com/p/742b4b248da9

#import "KVOCustomViewController.h"
#import "NSObject+LXD_KVO.h"
#import "LXD_ObservedObject.h"
@interface KVOCustomViewController ()

@end

@implementation KVOCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LXD_ObservedObject * object = [LXD_ObservedObject new];
    [object LXD_addObserver: self forKey: @"observedNum" withBlock: ^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        
        NSLog(@"Value had changed yet");
    }];
    
    object.observedNum = @10;
    [object test];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
