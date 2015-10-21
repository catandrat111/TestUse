//
//  AutoSizeViewInstance.m
//  TEST11
//
//  Created by dongjl on 15-8-13.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "AutoSizeViewInstance.h"

@interface AutoSizeViewInstance ()
@property(weak,nonatomic) IBOutlet UIView* sizeView;
@property(strong,nonatomic) UILabel* label;
@property(nonatomic) BOOL flag;
@end

@implementation AutoSizeViewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 140, 80)];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.numberOfLines = 0;
    self.label.font = [UIFont systemFontOfSize:14.f];
    self.label.textColor = [UIColor whiteColor];
    self.label.text = @"如需东方 v 发的红包,和国家和空间里健康。";
    self.label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;//<UILabel: 0x14d38b00; frame = (33 10; 233.5 80); text = '如需东方 v 发的红包,和国家和空间里健康。'; autoresize = LM+W+RM; userInteractionEnabled = NO; layer = <_UILabelLayer: 0x14d38900>> 左右间距20  宽度140,当宽度为300 7x+ 2x = 300，间距为33.33
    [self.sizeView addSubview:self.label];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)p1:(id)sender{
    self.flag = !self.flag;
    if(self.flag){
        self.sizeView.width = 300;
        self.sizeView.left = 10;
    }
    else {
        self.sizeView.left = 80;
        self.sizeView.width = 180;
    }
    
    NSLog(@"%@",self.label);
}
@end
