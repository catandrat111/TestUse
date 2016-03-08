//
//  TBFirstViewController.m
//  TheBackgrounder
//
//  Copyright (c) 2013 Gustavo Ambrozio. All rights reserved.
//

#import "TBFirstViewController.h"
#import "AVFoundation/AVFoundation.h"
@interface TBFirstViewController ()


@property(strong,nonatomic)AVQueuePlayer *player;
@property(strong,nonatomic)id timeObserver;
@end

@implementation TBFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Audio", @"Audio");
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //初始化音频会话
    NSError * sessionError = nil;
    [[AVAudioSession sharedInstance]setDelegate:self];
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayAndRecord  error:&sessionError];
    //更改默认音频输出
    UInt32 dochangeaudioroute = 1;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,
                            sizeof(dochangeaudioroute), &dochangeaudioroute);
    
    //初始化播放音乐列表。
    NSURL *rawMusicUrl1 = [[NSBundle mainBundle]URLForResource:@"IronBacon" withExtension:@"mp3"];
    NSURL *rawMusicUrl2 = [[NSBundle mainBundle]URLForResource:@"FeelinGood" withExtension:@"mp3"];
    NSURL *rawMusicUrl3 = [[NSBundle mainBundle]URLForResource:@"WhatYouWant" withExtension:@"mp3"];
    NSArray *quene = @[[AVPlayerItem playerItemWithURL:rawMusicUrl1],[AVPlayerItem playerItemWithURL:rawMusicUrl2],[AVPlayerItem playerItemWithURL:rawMusicUrl3]];
    self.player = [[AVQueuePlayer alloc]initWithItems:quene];
//    调整播放模式为完成后继续播放
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndAdvance;
    
    
    void(^observerBlock)(CMTime)= ^(CMTime time) {
        NSString *timeString = [NSString stringWithFormat:@"%02.2f", (float)time.value / (float)time.timescale];
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
            self.lblMusicTime.text = timeString;
        } else {
            NSLog(@"App is backgrounded. Time is: %@", timeString);
        }
    };
    
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(10, 1000)
                                                                  queue:dispatch_get_main_queue()
                                                             usingBlock:observerBlock];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentItem"])
    {
        AVPlayerItem *item = ((AVPlayer *)object).currentItem;
        self.lblMusicName.text = ((AVURLAsset*)item.asset).URL.pathComponents.lastObject;
        NSLog(@"New music name: %@", self.lblMusicName.text);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)didTapPlayPause:(id)sender{
    self.btnPlayPause.selected = !self.btnPlayPause.selected;
    if(self.btnPlayPause.selected){
        [self.player play];
    }else{
        [self.player pause];
    }
}

@end
