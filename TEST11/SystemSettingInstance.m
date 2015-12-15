//
//  SystemSettingInstance.m
//  TEST11
//
//  Created by dongjl on 15/12/15.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "SystemSettingInstance.h"
#define kCellIdentifier @"cellidentifier"
@interface SystemSettingInstance()
@property (nonatomic,strong) NSArray* dataSource;
@end
//慎用 有些过时了 http://www.superqq.com/blog/2015/12/01/jump-setting-per-page/
//About — prefs:root=General&path=About
//Accessibility — prefs:root=General&path=ACCESSIBILITY
//Airplane Mode On — prefs:root=AIRPLANE_MODE
//Auto-Lock — prefs:root=General&path=AUTOLOCK
//Brightness — prefs:root=Brightness
//Bluetooth — prefs:root=General&path=Bluetooth
//Date & Time — prefs:root=General&path=DATE_AND_TIME
//FaceTime — prefs:root=FACETIME
//General — prefs:root=General
//Keyboard — prefs:root=General&path=Keyboard
//iCloud — prefs:root=CASTLE
//iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
//International — prefs:root=General&path=INTERNATIONAL
//Location Services — prefs:root=LOCATION_SERVICES
//Music — prefs:root=MUSIC
//Music Equalizer — prefs:root=MUSIC&path=EQ
//Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
//Network — prefs:root=General&path=Network
//Nike + iPod — prefs:root=NIKE_PLUS_IPOD
//Notes — prefs:root=NOTES
//Notification — prefs:root=NOTIFICATIONS_ID
//Phone — prefs:root=Phone
//Photos — prefs:root=Photos
//Profile — prefs:root=General&path=ManagedConfigurationList
//Reset — prefs:root=General&path=Reset
//Safari — prefs:root=Safari
//Siri — prefs:root=General&path=Assistant
//Sounds — prefs:root=Sounds
//Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
//Store — prefs:root=STORE
//Twitter — prefs:root=TWITTER
//Usage — prefs:root=General&path=USAGE
//VPN — prefs:root=General&path=Network/VPN
//Wallpaper — prefs:root=Wallpaper
//Wi-Fi — prefs:root=WIFI

//需要在urlscheme中设置 prefs http://www.superqq.com/blog/2015/11/30/jump-to-setting-wifi/
@implementation SystemSettingInstance

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.dataSource = @[@"prefs:root=General&path=About",@"prefs:root=General&path=ACCESSIBILITY",@"prefs:root=AIRPLANE_MODE",@"prefs:root=General&path=AUTOLOCK",@"prefs:root=Brightness",@"prefs:root=General&path=Bluetooth",@"prefs:root=General&path=DATE_AND_TIME",@"prefs:root=FACETIME",@"prefs:root=General",@"prefs:root=General&path=Keyboard",@"prefs:root=CASTLE",@"prefs:root=CASTLE&path=STORAGE_AND_BACKUP",@"prefs:root=General&path=INTERNATIONAL",@"prefs:root=MUSIC",@"prefs:root=MUSIC&path=EQ",@"prefs:root=MUSIC&path=VolumeLimit",@"prefs:root=General&path=Network",@"prefs:root=NIKE_PLUS_IPOD",@"prefs:root=NOTES",@"prefs:root=NOTIFICATIONS_ID",@"prefs:root=Phone",@"prefs:root=Photos",@"prefs:root=General&path=ManagedConfigurationList",@"prefs:root=General&path=Reset",@"prefs:root=Safari",@"prefs:root=Sounds",@"prefs:root=General&path=SOFTWARE_UPDATE_LINK",@"prefs:root=STORE",@"prefs:root=TWITTER",@"prefs:root=General&path=USAGE",@"prefs:root=General&path=Network/VPN",@"prefs:root=General&path=Network/VPN",@"prefs:root=Wallpaper",@"prefs:root=WIFI",@"prefs:root=LOCATION_SERVICES"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    //        if ([[UIApplication sharedApplication] canOpenURL:url]) {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    
    //        NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    //        if ([[UIApplication sharedApplication] canOpenURL:url])
    //        {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    //        else
    //        {
    //            NSURL *url2 = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    //            [[UIApplication sharedApplication] openURL:url2];
    //        }
    
    //        //墙纸设置界面
    //        NSURL *url = [NSURL URLWithString:@"prefs:root=Wallpaper"];
    //        if ([[UIApplication sharedApplication] canOpenURL:url])
    //        {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    
    //        //音乐设置界面
    //        NSURL *url = [NSURL URLWithString:@"prefs:root=MUSIC"];
    //        if ([[UIApplication sharedApplication] canOpenURL:url])
    //        {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    
    //        //iCloud设置界面
    //        NSURL *url = [NSURL URLWithString:@"prefs:root=CASTLE"];
    //        if ([[UIApplication sharedApplication] canOpenURL:url])
    //        {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    
    //        //FaceTime设置界面
    //        NSURL *url = [NSURL URLWithString:@"prefs:root=FACETIME"];
    //        if ([[UIApplication sharedApplication] canOpenURL:url])
    //        {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    
    //        //蓝牙设置界面
    //        NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
    //        if ([[UIApplication sharedApplication] canOpenURL:url])
    //        {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    
    //定位服务设置界面
    NSString* temp = self.dataSource[indexPath.row];
    NSURL *url = [NSURL URLWithString:temp];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }


}








@end
