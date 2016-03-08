//
//  TBSecondViewController.m
//  TheBackgrounder
//
//  Copyright (c) 2013 Gustavo Ambrozio. All rights reserved.
//

#import "TBSecondViewController.h"

@interface TBSecondViewController ()

@property (strong,nonatomic) CLLocationManager * locationManager;
@property(strong,nonatomic) NSMutableArray * locations;
@end

@implementation TBSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Location", @"Location");
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //初始化定位信息，设置定位精确度。
    self.locations = [[NSMutableArray alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
}

-(void) accuracyChanged:(id)sender{
    const CLLocationAccuracy accuracys[] = {kCLLocationAccuracyBestForNavigation,
                                            kCLLocationAccuracyBest,
                                            kCLLocationAccuracyNearestTenMeters,
                                            kCLLocationAccuracyHundredMeters,
                                            kCLLocationAccuracyKilometer,  
                                            kCLLocationAccuracyThreeKilometers};
    self.locationManager.desiredAccuracy = accuracys[self.segmentAccuracy.selectedSegmentIndex];
    
}

-(void)enabledStateChanged:(id)sender{
    if(self.switchEnabled.on){
        [self.locationManager startUpdatingLocation];
    }else{
        [self.locationManager stopUpdatingLocation];
    }
}


#pragma mark  添加定位代理。
/**
 
 *当位置更新时，这个代理函数就会被调用。
 
 
 **/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    // Add another annotation to the map.
    
    //给地图上添加一个标记
    CLLocation *newlocation = [locations objectAtIndex:0];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = newlocation.coordinate;
    [self.map addAnnotation:annotation];
    
    // 把标记的坐标压入数组，方便后来移除。
    [self.locations addObject:annotation];
    
    // 当数组太大时，移除多余的。
    while (self.locations.count > 100)
    {
        annotation = [self.locations objectAtIndex:0];
        [self.locations removeObjectAtIndex:0];
        
        // Also remove from the map
        [self.map removeAnnotation:annotation];
    }
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        // 调整标记的距离，好让地图能显示下这些标记。，缩放地图，
        double maxLat = -91;
        double minLat =  91;
        double maxLon = -181;
        double minLon =  181;
        
        for (MKPointAnnotation *annotation in self.locations)
        {
            CLLocationCoordinate2D coordinate = annotation.coordinate;
            
            if (coordinate.latitude > maxLat)
                maxLat = coordinate.latitude;
            if (coordinate.latitude < minLat)
                minLat = coordinate.latitude;
            
            if (coordinate.longitude > maxLon)
                maxLon = coordinate.longitude;
            if (coordinate.longitude < minLon)
                minLon = coordinate.longitude;
        }
        
        MKCoordinateRegion region;
        region.span.latitudeDelta  = (maxLat +  90) - (minLat +  90);
        region.span.longitudeDelta = (maxLon + 180) - (minLon + 180);
        
        // 确定中心点位置。
        region.center.latitude  = minLat + region.span.latitudeDelta / 2;
        region.center.longitude = minLon + region.span.longitudeDelta / 2;
        
        // 设置地图的显示区域。
        [self.map setRegion:region animated:YES];
    }
    else
    {
        NSLog(@"App is backgrounded. New location is %@", newlocation);
    }  

}

@end
