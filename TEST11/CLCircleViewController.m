//
//  CLCircleViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/24.
//  Copyright © 2015年 djl. All rights reserved.
//http://blog.csdn.net/eqera/article/details/8134994

#import "CLCircleViewController.h"
#import "CircleCell.h"
@interface CLCircleViewController ()

@end

@implementation CLCircleViewController

-(void)viewDidLoad
{
    self.cellCount = 20;
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.collectionView addGestureRecognizer:tapRecognizer];
    [self.collectionView registerClass:[CircleCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon.png"]];
    imageView.center = self.collectionView.center;
    [self.collectionView addSubview:imageView];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CircleCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    return cell;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint initialPinchPoint = [sender locationInView:self.collectionView];
        NSIndexPath* tappedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        if (tappedCellPath!=nil)
        {
            self.cellCount = self.cellCount - 1;
            [self.collectionView performBatchUpdates:^{
                [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
                
            } completion:nil];
        }
        else
        {
            self.cellCount = self.cellCount + 1;
            [self.collectionView performBatchUpdates:^{
                [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
            } completion:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
