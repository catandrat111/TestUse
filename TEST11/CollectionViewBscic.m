//
//  CollectionViewBscic.m
//  TEST11
//
//  Created by dongjl on 15/11/24.
//  Copyright © 2015年 djl. All rights reserved.
//http://blog.csdn.net/eqera/article/details/8134986

#import "CollectionViewBscic.h"
#import "CLCollectionViewCell.h"
#import "CollectionViewBacicHeaderView.h"
#import "CollectionViewBacicFooterView.h"
//-(UICollectionViewLayoutAttributes )layoutAttributesForItemAtIndexPath:(NSIndexPath )indexPath
//返回对应于indexPath的位置的cell的布局属性
//-(UICollectionViewLayoutAttributes )layoutAttributesForSupplementaryViewOfKind:(NSString )kind atIndexPath:(NSIndexPath *)indexPath
//返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
//-(UICollectionViewLayoutAttributes * )layoutAttributesForDecorationViewOfKind:(NSString)decorationViewKind atIndexPath:(NSIndexPath )indexPath
//返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
@interface CollectionViewBscic ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CollectionViewBscic

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    flowLayout.minimumLineSpacing = 10.0;//行间距(最小值)
    flowLayout.minimumInteritemSpacing = 50.0;//item间距(最小值)
    flowLayout.itemSize = CGSizeMake(50, 50);//item的大小
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置section的边距
    flowLayout.headerReferenceSize = CGSizeMake(320, 20);
    flowLayout.footerReferenceSize = CGSizeMake(320, 20);
    //第二个参数是cell的布局
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameWidth, self.view.frameHeight - 64) collectionViewLayout:flowLayout];
   
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor orangeColor];
    //1 注册复用cell(cell的类型和标识符)(可以注册多个复用cell, 一定要保证重用标示符是不一样的)注册到了collectionView的复用池里
    [collectionView registerClass:[CLCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    //第一个参数:返回的View类型
    //第二个参数:设置View的种类(header, footer)
    //第三个参数:设置重用标识符
    //[collectionView registerClass:[CollectionViewBacicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIdentifier"];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionViewBacicHeaderView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIdentifier"];
    [collectionView registerClass:[CollectionViewBacicFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerIdentifier"];
    [self.view addSubview:collectionView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //2 从复用池中找cell(1:cell的标示符 2:indexPath决定系统用不用再给你创建cell, 不用创建的话, 就直接使用之前的cell)
    CLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionViewBacicHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerIdentifier" forIndexPath:indexPath];
        headerView.textLabel.text = @"让我组成头部!";
       // headerView.textLabel.textAlignment = NSTextAlignmentCenter;
        headerView.textLabel.textColor = [UIColor whiteColor];
        return headerView;
    }
    CollectionViewBacicFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerIdentifier" forIndexPath:indexPath];
    footerView.textLabel.text = @"让我组成尾部!";
    footerView.textLabel.textAlignment = NSTextAlignmentCenter;
    footerView.textLabel.textColor = [UIColor whiteColor];
    return footerView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ %@", @(indexPath.section), @(indexPath.row));
}

#pragma mark - UICollectionViewDelegateFlowLayout

// - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
// {
// }
//
// - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
// {
// 
// }
// - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
// {
// 
// }
// - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
// {
// 
// }
// - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
// {
// 
// }
// - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
// {
// 
// }
//

@end
