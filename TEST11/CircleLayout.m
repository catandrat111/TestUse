//
//  AppDelegate.m
//  DevDiv_CollectionView_CircleLayout_Demo
//
//  Created by BeyondVincent on 12-7-3.
//  Copyright (c) 2012年 DevDiv. All rights reserved.
//http://blog.csdn.net/majiakun1/article/details/17204921

#import "CircleLayout.h"

#define ITEM_SIZE 70
//CLCircle
@implementation CircleLayout
//首先，-(void)prepareLayout将被调用，默认下该方法什么没做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始需要的参数等。
//之后，-(CGSize) collectionViewContentSize将被调用，以确定collection应该占据的尺寸。注意这里的尺寸不是指可视部分的尺寸，而应该是所有内容所占的尺寸。collectionView的本质是一个scrollView，因此需要这个尺寸来配置滚动行为。
//接下来-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect被调用，这个没什么值得多说的。初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。

//另外，在需要更新layout时，需要给当前layout发送 -invalidateLayout，该消息会立即返回，并且预约在下一个loop的时候刷新当前layout，这一点和UIView的setNeedsLayout方法十分类似。在-invalidateLayout后的下一个collectionView的刷新loop中，又会从prepareLayout开始，依次再调用-collectionViewContentSize和-layoutAttributesForElementsInRect来生成更新后的布局。
-(void)prepareLayout
{
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    _radius = MIN(size.width, size.height) / 2.5;
}

-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
    attributes.center = CGPointMake(_center.x + _radius * cosf(2 * path.item * M_PI / _cellCount),
                                    _center.y + _radius * sinf(2 * path.item * M_PI / _cellCount));
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }    
    return attributes;
}
//当collection view中的数据发生了改变，如插入或删除item，那么collection view会请求这些item的layout对象，以更新
////插入前，cell在圆心位置，全透明

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x, _center.y);
    return attributes;
}
////删除时，cell在圆心位置，全透明，且只有原来的1/10大
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}

@end
