//
//  KVOInstance.m
//  TEST11
//
//  Created by dongjl on 15/12/16.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "KVOInstance.h"
#define kCellIdentifier @"cellidentifier"
@interface KVOInstance ()
@property (nonatomic,strong) NSArray* dataSourceArray;
@property (nonatomic,strong) NSDictionary* dataSourceDict;
@end

@implementation KVOInstance
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.dataSourceArray = @[@"customkvo",@"customkvo1"];
        self.dataSourceDict = @{@"customkvo":@"KVOCustomViewController",@"customkvo1":@"CustomKVO1ViewController"};
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* classKey = self.dataSourceArray[indexPath.row];
    NSString* className = self.dataSourceDict[classKey];

    Class contrllerClass = NSClassFromString(className);
    UIViewController* controller = [[contrllerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];

}
@end
