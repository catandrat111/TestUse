//
//  ReactiveCocoaViewController.m
//  TEST11
//
//  Created by dongjl on 17/2/22.
//  Copyright © 2017年 djl. All rights reserved.
//

#import "ReactiveCocoaViewController.h"
#import "ReactiveCocoa.h"
@interface ReactiveCocoaViewController ()

@end

@implementation ReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     @weakify(self);
    [[RACObserve(self, username)
      filter:^(NSString *newName) {
          return [newName hasPrefix:@"j"];
      }]
     subscribeNext:^(NSString *newName) {
         NSLog(@"%@", newName);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)p1:(id)sender {
    
}
@end
