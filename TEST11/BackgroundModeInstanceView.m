//
//  BackgroundModeInstanceView.m
//  TEST11
//
//  Created by dongjl on 16/2/18.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "BackgroundModeInstanceView.h"

@interface BackgroundModeInstanceView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView* tableView;
@property(nonatomic,strong) NSArray* dataSource;
@property(nonatomic,strong) NSDictionary* dataSourceDict;


@end

@implementation BackgroundModeInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"BackgroundMode",@"APLViewController"];
//     self.dataSource = @[@"BackgroundMode",@"APLViewController",@"audio",@"location",@"whatever",@"newsstand",@"voip"];
    self.dataSourceDict = @{@"BackgroundMode" :@"BackgroundModeViewController",@"nssession":@"APLViewController"};
   // self.dataSourceDict = @{@"BackgroundMode" :@"BackgroundModeViewController",@"nssession":@"APLViewController",@"audio":@"TBFirstViewController",@"location":@"TBSecondViewController",@"whatever":@"TBThirdViewController",@"newsstand":@"TBFourthViewController",@"voip":@"TBFifthViewController"};

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* className = self.dataSourceDict[self.dataSource[indexPath.row]];
    Class cs = NSClassFromString(className);
    
    UIViewController* controller = [cs new];
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
