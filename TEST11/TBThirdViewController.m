//
//  TBThirdViewController.m
//  TheBackgrounder
//
//  Copyright (c) 2013 Gustavo Ambrozio. All rights reserved.
//

#import "TBThirdViewController.h"

@interface TBThirdViewController ()
@property (strong,nonatomic) NSDecimalNumber *previous;
@property (strong,nonatomic) NSDecimalNumber *current;
@property (nonatomic) NSUInteger position;
@property (strong,nonatomic) NSTimer *timer;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundIdentify;
@end

@implementation TBThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Whatever", @"Whatever");
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.backgroundIdentify = UIBackgroundTaskInvalid;
}

-(void)didTapPlayPause:(id)sender{
    self.btnPlayPause.selected = !self.btnPlayPause.selected;
    if (self.btnPlayPause.selected)
    {
        self.previous = [NSDecimalNumber one];
        self.current  = [NSDecimalNumber one];
        self.position = 1;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                            target:self
                                                          selector:@selector(calculateNextNumber)
                                                          userInfo:nil
                                                           repeats:YES];
        
        self.backgroundIdentify = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            //当时间快结束时，该方法会被调用。
            NSLog(@"Background handler called. Not running background tasks anymore.");
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundIdentify];
            self.backgroundIdentify = UIBackgroundTaskInvalid;
        }];
    }
    else
    {
        [self.timer invalidate];
        self.timer = nil;
        if (self.backgroundIdentify != UIBackgroundTaskInvalid)
        {
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundIdentify];
            self.backgroundIdentify = UIBackgroundTaskInvalid;
        }
    }
}



/*
 *计算下一个即将显示的数字。
 *
 *
 */
- (void)calculateNextNumber
{
    NSDecimalNumber *result = [self.current decimalNumberByAdding:self.previous];
    
    if ([result compare:[NSDecimalNumber decimalNumberWithMantissa:1 exponent:40 isNegative:NO]] == NSOrderedAscending)
    {
        self.previous = self.current;
        self.current  = result;
        self.position++;
    }
    else
    {
        // 如果数据太大，然后从一开始。
        self.previous = [NSDecimalNumber one];
        self.current  = [NSDecimalNumber one];
        self.position = 1;
    }
    
    NSString *currentResultLabel = [NSString stringWithFormat:@"Position %d = %@", self.position, self.current];
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        self.txtResult.text = currentResultLabel;
    }
    else
    {
        NSLog(@"App is backgrounded. Next number = %@", currentResultLabel);
        NSLog(@"Background time remaining = %.1f seconds", [UIApplication sharedApplication].backgroundTimeRemaining);
    }
}  @end
