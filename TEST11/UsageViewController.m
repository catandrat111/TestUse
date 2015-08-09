//
//  UsageViewController.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "UsageViewController.h"
#import "User.h"
@interface UsageViewController ()
@property(strong,nonatomic) NSMutableArray* array;
@end

@implementation UsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User* user1 = [User new];
    user1.age = @(10);
    user1.name = @"g";
    [self.array addObject:user1];
    
    User* user2 = [User new];
    user2.age = @(1);
    user2.name = @"d";
    [self.array addObject:user2];
    
    User* user3 = [User new];
    user3.age = @(11);
    user1.name = @"v";
    [self.array addObject:user3];
//
//    User* user4 = [User new];
//    user4.age = @(5);
//    user4.name = @"s";
//    [self.array addObject:user4];
//    
//    User* user5 = [User new];
//    user5.age = @(13);
//    user5.name = @"a";
//    [self.array addObject:user5];
//    
//    User* user6 = [User new];
//    user6.age = @(8);
//    user6.name = @"b";
//    [self.array addObject:user6];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)sortAction:(id)sender{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSArray *sortedArray =  [self.array sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@",sortedArray);
    
    //第二种用法
    NSArray *sortedArray1 = [self.array sortedArrayUsingComparator:^NSComparisonResult(User *user1, User *user2){
        return [user1.age compare:user2.age];
        
    }];
    NSLog(@"%@",sortedArray1);
    
    //第三种用法
    NSArray *sortedArray2 = [self.array sortedArrayUsingSelector:@selector(compare:)];
     NSLog(@"%@",sortedArray2);
    
}


-(IBAction)quchongAction:(id)sender{
    NSArray *result1 = [self.array valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"%@",result1);
    //只想返回一个由user数组中的姓名组成的不重复的新数组
    NSArray *result2 = [self.array valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"%@",result2);
    
}

-(IBAction)filterAction:(id)sender{
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"((age >= %@) AND (age < %@))",@2,@30];
    NSArray *result1 = [self.array filteredArrayUsingPredicate:predicate1];

    NSLog(@"%@",result1);
    
    //第二种
    NSPredicate *predicate2 = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        return  [((User *)evaluatedObject).age integerValue] >= 2 && [((User *)evaluatedObject).age integerValue]<= 30;
        
    }];
    
    NSArray *result2 = [self.array filteredArrayUsingPredicate:predicate2];
    NSLog(@"%@",result2);
}
@end
