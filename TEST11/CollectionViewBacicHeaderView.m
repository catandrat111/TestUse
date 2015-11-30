//
//  CollectionViewBacicHeaderView.m
//  TEST11
//
//  Created by dongjl on 15/11/24.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "CollectionViewBacicHeaderView.h"

@implementation CollectionViewBacicHeaderView

- (instancetype)init {
    self = [[NSBundle mainBundle ]loadNibNamed:@"CollectionViewBacicHeaderView" owner:self options:nil][0];
    return self;
}

-(void)awakeFromNib {
    
}
@end
