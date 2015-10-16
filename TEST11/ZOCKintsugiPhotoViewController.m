//
//  ZOCKintsugiPhotoViewController.m
//  TEST11
//
//  Created by dongjl on 15/9/29.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "ZOCKintsugiPhotoViewController.h"
#import "ZOCKintsugiPhotoViewController_iPad.h"
#import "ZOCKintsugiPhotoViewController_iPhone.h"

@interface ZOCKintsugiPhotoViewController ()

@end

@implementation ZOCKintsugiPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithPhotos:(NSArray *)photos {
    if ([self isMemberOfClass:ZOCKintsugiPhotoViewController.class]) {
        self = nil;
        if (/* DISABLES CODE */ (YES)) {
            self = [[ZOCKintsugiPhotoViewController_iPad alloc] initWithPhotos:photos];
        }
        else {
            self = [[ZOCKintsugiPhotoViewController_iPhone alloc] init];
        }
        return self;
    }
    return [super initWithNibName:nil bundle:nil]; }

@end
