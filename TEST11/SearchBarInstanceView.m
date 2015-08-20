//
//  SearchBarInstanceView.m
//  TEST11
//
//  Created by dongjl on 15-8-19.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "SearchBarInstanceView.h"

@interface SearchBarInstanceView ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SearchBarInstanceView
@synthesize searchDisplayController;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColorFromRGB(0xe3e3e3);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = UIColorFromRGB(0xe6eb8);
    
    [self.view addSubview:self.tableView];

    self.tableView.sectionIndexBackgroundColor = [UIColor redColor];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frameWidth, 44)];
    self.searchBar.placeholder = @"城市名/城市拼音/首字母";
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    [self.searchBar setBackgroundColor:UIColorFromRGB(0xffffff)];
    [self.searchBar setBackgroundImage:[self imageWithColor:UIColorFromRGB(0xf2f2f2) size:self.searchBar.frameSize]];
    
    UIView *searchBarView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, self.view.frameWidth, 20)];
    [searchBarView setBackgroundColor:[UIColor colorWithRed:201.f / 255.f green:201.f / 255.f blue:206.f /255.f alpha:1]];
    [self.searchBar addSubview:searchBarView];
    [self.view setClipsToBounds:NO];
  
    [self.searchBar setClipsToBounds:NO];
    
    self.searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayController.delegate = self;
    UIView *customTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    UINavigationBar *dummyNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    [customTableHeaderView addSubview:dummyNavigationBar];
    [customTableHeaderView addSubview:self.searchBar];
    
    self.tableView.tableHeaderView = customTableHeaderView;


}

-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchDisplayController setActive:YES animated:YES];
    return YES;
}
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.searchDisplayController.searchBar.frame = CGRectMake(0,0, self.view.frameWidth, 44);
    [self.tableView reloadSectionIndexTitles];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchDisplayController setActive:NO animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray* arr = @[@"1",@"3"];
    return arr;
}
@end
