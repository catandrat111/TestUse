//
//  SearchControllerInstanceView.m
//  TEST11
//
//  Created by dongjl on 16/8/30.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "SearchControllerInstanceView.h"

@interface SearchControllerInstanceView ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *searchResults;
@end
//searchbar 在header
@implementation SearchControllerInstanceView

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
   
    
    self.searchResults = @[ @"召唤师峡谷 Summoner's Rift",
                             @"扭曲丛林 Twisted Treeline"];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
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

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    if (self.items!= nil) {
//        [self.items removeAllObjects];
//    }
//    //过滤数据
//    self.items= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchController setActive:YES];
    return YES;
}
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    //self.searchDisplayController.searchBar.frame = CGRectMake(0,0, self.view.frameWidth, 44);
    [self.tableView reloadSectionIndexTitles];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchController setActive:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (!self.searchController.active) ? self.items.count : self.searchResults.count;
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

//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
//    
//    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
//    
//    return YES;
//}
//
//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
//    
//    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
//    
//    return YES;
//}
@end
