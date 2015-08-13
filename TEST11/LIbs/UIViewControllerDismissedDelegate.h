//
//  ViewControllerDismissed.h
//  HomeLink HD
//
//  Created by 王一丁 on 10-11-29.
//  Copyright 2010 Exmart.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ ZHSelectedBlock)(id selecedObj);

@protocol UIViewControllerDismissedDelegate
- (void)viewControllerDidDisappearedWithObject:(id)obj;
@end
