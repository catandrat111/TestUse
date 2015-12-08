//
//  ImageView.h
//  TEST11
//
//  Created by dongjl on 15/12/3.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIView {
    UIImage *image;
}

@property (retain, nonatomic) UIImage *image;
@property (retain, nonatomic) IBOutlet UILabel *label;

@end
