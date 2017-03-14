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


- (void)signalCombineTest{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    RACSignal *combined = [RACSignal combineLatest:@[letters,numbers] reduce:^id(NSString *letter,NSString *number){
        return [letter stringByAppendingString:number];
    }];
    // Outputs: B1 B2 C2 C3 D3 D4
    [combined subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"3"];
    [letters sendNext:@"D"];
    [numbers sendNext:@"4"];
    
    /**
     | letter |-  A  -  B  -  -   -   C  -    -   D
     | number |-  -  -   1  -  2   -   3   -   -    4
     | new   |-  -  -  -  B1 -  B2 C2 C3 -  D3 D4
     -------------- time ----------------------->
     可以发现letter信号的A值被更新的B值覆盖了,所以接下来接收到number信号的1时候,合并,输出信号B1.
     当接收到C的时候,与number的最新的值2合并,输出信号C2.
     */
}
- (void)signalZipTest{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    RACSignal *zipSignal = [RACSignal zip:@[letters,numbers] reduce:^id(NSString *letter,NSString *number){
        return [letter stringByAppendingString:number];
    }];
    // Outputs: A1 B2 C3 D4
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [numbers sendNext:@"3"];
    [letters sendNext:@"C"];
    [letters sendNext:@"D"];
    [numbers sendNext:@"4"];
    /**
     | letter |-  A  -  B  -  -  -  -  -  -  C  - D
     | number |-  -  -  -  1  -  2  -  3  -   -  -   4
     | new  |-  -  -  -   - A1 -  B2 -  -  C3 -  -  D4
     -------------- time ----------------------->
     zip的合并行为是按顺序取出各个信号然后合并发出的.也就是说,
     letters的第一个值A和number的第一个值1合并输出A1,第二个值B和number的第二个值2合并输出B2
     假设D后面,还有E,F,G...,但是没有对应的number信号,zip的合并行为就无法进行下去了.
     */
}
- (void)signalZipWithSampleTest{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    RACSignal *combined = [RACSignal
                           zip:@[ letters, [numbers sample:letters]]
                           reduce:^(NSString *letter, NSString *number) {
                               return [letter stringByAppendingString:number];
                           }];
    
    // Outputs: A1 B2 C3 D4
    [combined subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // Outputs: A2 B3
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"3"];
    [letters sendNext:@"D"];
    [numbers sendNext:@"4"];
    /**
     | letter |    -  A  -  B  -  -  -  C  -  -  D
     | number |-  -  -  -  1  -  2   -  3  -  -  4
     | new  |     -  -  -  -  -  -  -  A2 -  -  B3 -
     -------------- time ----------------------->
     [numbers sample:letters]的意思是,只有当letters信号发出后,才需要获取number的最新值,取出letters还没有使用的最旧的信号,合并发出
     而当发出A,B时,number并没有值,所以无法合并发出,当发出C时,获得number的最新值2,取出还没有使用过的A值,合并发出A2.
     当发出D时,获取number的最新值3,与还没有使用过的B值,合并发出B3.
     而不断地发送number,是无法激活这个合并操作的.
     */
}


//-switchToLatest: 取指定的那个水龙头的吐出的最新玻璃球
- (void)switchToLatest {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *signalOfSignals = [RACSubject subject];
    
    RACSignal *switched = [signalOfSignals switchToLatest];
    
    // Outputs: A B 1 D
    [switched subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
    
    [signalOfSignals sendNext:letters];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    
    [signalOfSignals sendNext:numbers];
    [letters sendNext:@"C"];
    [numbers sendNext:@"1"];
    
    [signalOfSignals sendNext:letters];
    [numbers sendNext:@"2"];
    [letters sendNext:@"D"];
}

- (void)merge {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *merged = [RACSignal merge:@[ letters, numbers ]];
    
    // Outputs: A 1 B C 2
    [merged subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
}

- (void)Concatenating {
    //-concat: 把一个水管拼接到另一个水管之后
    
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    
    // Contains: A B C D E F G H I 1 2 3 4 5 6 7 8 9
    RACSequence *concatenated = [letters concat:numbers];
}
@end
