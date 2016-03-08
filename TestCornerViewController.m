//
//  TestCornerViewController.m
//  TEST11
//
//  Created by dongjl on 16/3/7.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "TestCornerViewController.h"
#import "UIImage+ImageRoundedCorner.h"
#import "UIView+Corner.h"
@interface TestCornerViewController ()<UITableViewDataSource,UITableViewDelegate>{
 

   
}
@property(weak,nonatomic) IBOutlet UITableView* tableView;


@end

@implementation TestCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark uitabkeview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    static NSString* cellIndentifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.detailTextLabel setTextColor:[UIColor blackColor]];
        
        UIImage* img = [UIImage imageNamed:@"1"];
        UIImageView* imgView11  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30
                                                                               )];
       // imgView11.image = img;
        imgView11.image = [img imageAddCornerWithRadius:3.0 andSize:CGSizeMake(30, 30)];
       // imgView11.layer.cornerRadius = 3.0f;
        //imgView11.layer.masksToBounds = YES;
        
        //[self testCorner:imgView11];
        UIImageView* imgView12  = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 30, 30
                                                                         )];
        //imgView12.image = img;
        imgView12.image = [img imageAddCornerWithRadius:3.0 andSize:CGSizeMake(30, 30)];
        //imgView12.layer.cornerRadius = 3.0f;
         // imgView12.layer.masksToBounds = YES;
        //[self testCorner:imgView12];
        UIImageView* imgView13  = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0, 30, 30
                                                                                )];
         //imgView13.image = img;
        imgView13.image = [img imageAddCornerWithRadius:3.0 andSize:CGSizeMake(30, 30)];
        //imgView13.layer.cornerRadius = 3.0f;
        //imgView13.layer.masksToBounds = YES;
        //[self testCorner:imgView13];
        UIImageView* imgView14  = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 30, 30
                                                                                )];
         imgView14.image = img;
        imgView14.image = [img imageAddCornerWithRadius:3.0 andSize:CGSizeMake(30, 30)];
        //imgView14.layer.cornerRadius = 3.0f;
       // imgView14.layer.masksToBounds = YES;//卡 30针
        //[self testCorner:imgView14];
        
        UIView* v1 = [[UIView alloc] initWithFrame:CGRectMake(170, 0, 50, 30)];
       // v1.backgroundColor = [UIColor redColor];
        [v1 kt_addCorner:3.0f borderWidth:1.0f backgroundColor:[UIColor redColor] borderColor:[UIColor blackColor]];
        [cell.contentView addSubview:v1];
        
        UIButton* button1 = [[UIButton alloc] initWithFrame:CGRectMake(230, 0, 30, 30)];
        [button1 setBackgroundColor:[UIColor yellowColor]];
        button1.layer.cornerRadius = 6.0f;
        [cell.contentView addSubview:button1];
        
        UILabel* lab1 = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 30, 30)];
        lab1.backgroundColor = [UIColor greenColor];
        lab1.layer.cornerRadius = 5.0f;
        lab1.layer.masksToBounds = YES;
        [cell.contentView addSubview:lab1];
        
        [cell.contentView addSubview:imgView11];
        [cell.contentView addSubview:imgView12];
        [cell.contentView addSubview:imgView13];
        [cell.contentView addSubview:imgView14];

        
    }
    
    

    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)testCorner :(UIView*)view {
    //卡 
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = view.bounds;
    //不为 nil 的颜色
    shapeLayer.fillColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:shapeLayer.bounds cornerRadius:3.0].CGPath;
    view.layer.mask = shapeLayer;
}
@end
