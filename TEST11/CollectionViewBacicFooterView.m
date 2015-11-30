//
//  CollectionViewBacicFooterView.m
//  TEST11
//
//  Created by dongjl on 15/11/24.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "CollectionViewBacicFooterView.h"

@implementation CollectionViewBacicFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 20)]) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 120, 20)];
        [self addSubview:self.textLabel];
    }
    return self;
}

-(void)awakeFromNib {
    
}
@end
