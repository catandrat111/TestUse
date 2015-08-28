//
//  SearchBarInstanceView.m
//  TEST11
//
//  Created by dongjl on 15-8-19.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "SearchBarInstanceView.h"

@interface SearchBarInstanceView ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *searchResults;
@end
//searchbar 在header
@implementation SearchBarInstanceView
@synthesize searchDisplayController;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LOL科普：地名大全";
    
    self.items = @[@"国服第一臭豆腐 No.1 Stinky Tofu CN.",
                   @"瓦洛兰 Valoran",
                   @"德玛西亚 Demacia",
                   @"诺克萨斯 Noxus",
                   @"艾欧尼亚 Ionia",
                   @"皮尔特沃夫 Piltover",
                   @"弗雷尔卓德 Freijord",
                   @"班德尔城 Bandle City",
                   @"战争学院 The Institute of War",
                   @"祖安 Zaun",
                   @"卡拉曼达 Kalamanda",
                   @"蓝焰岛 Blue Flame Island",
                   @"哀嚎沼泽 Howling Marsh",
                   @"艾卡西亚 Icathia",
                   @"铁脊山脉 Ironspike Mountains",
                   @"库莽古丛林 Kumungu",
                   @"洛克法 Lokfar",
                   @"摩根小道 Morgon Pass",
                   @"塔尔贡山脉 Mountain Targon",
                   @"瘟疫丛林 Plague Jungles",
                   @"盘蛇河 Serpentine River",
                   @"恕瑞玛沙漠 Shurima Desert",
                   @"厄尔提斯坦 Urtistan",
                   @"巫毒之地 Voodoo Lands",
                   @"水晶之痕 Crystal Scar",
                   @"咆哮深渊 Howling Abyss",
                   @"熔岩洞窟 Magma Chambers",
                   @"试炼之地 Proving Grounds",
                   @"召唤师峡谷 Summoner's Rift",
                   @"扭曲丛林 Twisted Treeline"];

    
    
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
    //self.searchBar.delegate = self;
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
    
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsTitle = @"aaa";

    self.searchBar.showsScopeBar = YES;
    self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"Boy",@"Girl",@"All",nil]; //根据需求进行在分组
   // self.searchBar.showsBookmarkButton = YES;//书本的标识
    self.searchBar.showsSearchResultsButton = YES;//原箭头向下

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

/**
 *  通过搜索条件过滤得到搜索结果
 *
 *  @param searchText 关键词
 *  @param scope      范围
 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    if(scope.length > 0){
        searchText = scope;
    }
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    self.searchResults = [self.items filteredArrayUsingPredicate:resultPredicate];//TODO
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (tableView == self.tableView) ? self.items.count : self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = (tableView == self.tableView) ? self.items[indexPath.row] : self.searchResults[indexPath.row];

    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray* arr = @[@"1",@"3"];
    return arr;
}

#pragma mark - UISearchDisplayController 代理

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}



@end
