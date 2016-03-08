//
//  TBFourthViewController.m
//  TheBackgrounder
//
//  Copyright (c) 2013 Gustavo Ambrozio. All rights reserved.
//

#import "TBFourthViewController.h"

@interface TBFourthViewController ()

@property (strong,nonatomic) NKIssue *currentIssue;
@property (strong,nonatomic) NSString *issueFileName;
@end

@implementation TBFourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Newsstand", @"Newsstand");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appBecameActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
 
    self.webView.hidden = YES;
    self.progress.progress = 0.0f;
    self.progress.hidden = NO;
    
    NKLibrary *library = [NKLibrary sharedLibrary];
    for(NKIssue *issue in [library.issues copy]){
        [library removeIssue:issue];
    }
    
    self.currentIssue = [library addIssueWithName:@"test" date:[NSDate date]];
    
    NSURL * url = [[NSURL alloc]initWithString:self.txtURL.text];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NKAssetDownload *download = [self.currentIssue addAssetWithRequest:request];
    [download downloadWithDelegate:self];
    [textField resignFirstResponder];
    
    return YES;
}

-(void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes{
    
    float progress = (float)totalBytesWritten / (float)expectedTotalBytes;
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        self.progress.progress = progress;
    }
    else
    {
        NSLog(@"App is backgrounded. Progress = %.1f", progress);
    }
}

//下载完成后调用该方法。
-(void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL{
    self.issueFileName = destinationURL.pathComponents.lastObject;
    NSURL *fileURL = [self.currentIssue.contentURL URLByAppendingPathComponent:self.issueFileName];
    //将下载下来的文件移动到相应的位置
    [[NSFileManager defaultManager] moveItemAtURL:destinationURL
                                            toURL:fileURL
                                            error:nil];
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        [self updateWebView];
    }
    else
    {
        NSLog(@"App is backgrounded. Download finished");
    }
}

-(void) updateWebView{
    self.webView.hidden = NO;
    self.progress.hidden = YES;
    NSURL *fileURL = [self.currentIssue.contentURL URLByAppendingPathComponent:self.issueFileName];
    [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
}

- (void)appBecameActive
{
    if (self.currentIssue && self.currentIssue.downloadingAssets.count == 0 && self.webView.hidden)
    {
        [self updateWebView];
    }
}

@end
