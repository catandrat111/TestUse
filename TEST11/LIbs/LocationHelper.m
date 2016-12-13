//
//  LocationHelper.m
//  GpsTest
//
//  Created by dongjl on 14-11-14.
//  Copyright (c) 2014年 DongJL. All rights reserved.
//CLLocationManager 定位管理者

#import "LocationHelper.h"
#import "WGS84TOGCJ02.h"
@implementation LocationHelper

-(id)init{
    if(self = [super init]){
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDistanceFilter:100];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager setDelegate:self];

    }
    return self;
}

-(void)startUpdateLocation:(GetLocationBlock)getLocationBlock{
    self.getLocationBlock = getLocationBlock;
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        //CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
            [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted )
        {
             self.getLocationBlock(nil);
             return;
        }

         #if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
        }
        #endif
        
        [self.locationManager startUpdatingLocation];
        [self performSelector:@selector(stopUpdateLocation)
                   withObject:@"Timed Out"
                   afterDelay:300];

    }
    else {
        NSLog(@"请打开gps");
        self.getLocationBlock(nil);
    }
}


-(void)stopUpdateLocation{
    [self.locationManager  stopUpdatingLocation];
    self.locationManager.delegate = nil;
}


//CLLocationManager委托方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //得到newLocation
    CLLocation *loc = [locations objectAtIndex:0];
    CLLocationCoordinate2D coord;
    CLLocation *locTemp = nil;
    if(loc.horizontalAccuracy < 300){
        //判断是不是属于国内范围
        if (![WGS84TOGCJ02 isLocationOutOfChina:[loc coordinate]]) {
            //转换后的coord
            coord = [WGS84TOGCJ02 transformFromWGSToGCJ:[loc coordinate]];
            locTemp = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
        }
        else {
            locTemp = loc;
        }
    
        self.getLocationBlock(locTemp);
        DLog(@"%f",loc.horizontalAccuracy);
        [self stopUpdateLocation];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation) object:nil];
    
//    CLLocation* location = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
//    [self reverseGeocodeLocation:location];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorString = [[NSString alloc] init];
    
    switch (error.code) {
        case kCLErrorLocationUnknown:
            errorString = @"Location unknown";
            break;
            
        case kCLErrorDenied:
            errorString = @"Access denied";
            break;
            
        case kCLErrorNetwork:
            errorString = @"No network coverage";
            break;
            
        case kCLErrorDeferredAccuracyTooLow:
            errorString = @"Accuracy is too low to display";
            break;
            
        default:
            break;
    }
    NSLog(@"%@",errorString);
    self.getLocationBlock(nil);
    [self stopUpdateLocation];
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
            [self.locationManager requestWhenInUseAuthorization];
            }
        }
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            // do some error handling
        }
            break;
        default:{
            [self.locationManager startUpdatingLocation];
        }
            break;
    }
}

/////////获取位置信息
-(void)reverseGeocodeLocation :(CLLocation*)location address:(ResponseBlock)responseBlock{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    self.responseBlock = responseBlock;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray* placemarks,NSError *error)
     {
         if (placemarks.count >0 )
         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             
             NSDictionary* dic = plmark.addressDictionary;
             NSString * country = dic[@"Country"];//中国
             NSString * city = dic[@"State"];//北京市
             if(city == nil){
                 city = @"";
             }
             NSString * locality = dic[@"City"];//北京市
             if(locality == nil){
                 locality = @"";
             }
             NSString * subLocality = dic[@"SubLocality"];//海淀区
             if(subLocality == nil){
                 subLocality = nil;
             }
             NSString * street = dic[@"Street"];//首都体育馆南路22号
             if(street == nil){
                 street = @"";
             }
             //NSString * name = dic[@"Name"];//国兴大厦
             NSString* address =  [NSString stringWithFormat: @"%@%@%@%@",city,locality, subLocality,street];
             DLog(@"%@",address);
             NSString *tempcity = plmark.locality;
             
             NSString  *  beijin=@"北京市";
             NSString  *  shanghai=@"上海市";
             NSString  *  tianjin=@"天津市";
             NSString  *  chongqin=@"重庆市";
             if ([plmark.administrativeArea rangeOfString:beijin].location != NSNotFound  ||
                 [plmark.administrativeArea rangeOfString:shanghai].location != NSNotFound ||
                 [plmark.administrativeArea rangeOfString:tianjin].location  != NSNotFound ||
                 [plmark.administrativeArea rangeOfString:chongqin].location != NSNotFound
                 )
             {
                 tempcity= plmark.administrativeArea;
                 address =  [NSString stringWithFormat: @"%@%@%@",tempcity,subLocality,street];
             }

             
//             if (!tempcity) {
//                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
//                 tempcity = plmark.administrativeArea;
//             }
             NSDictionary* tempDic = [NSDictionary dictionaryWithObjectsAndKeys:tempcity,@"city",address,@"address",country,@"country",nil];
             self.responseBlock(tempDic);
             DLog(@"%@",location);
             DLog(@"%@",[plmark description]);
         }
         else {
             NSLog(@"%@",placemarks);
             self.responseBlock(nil);
         }
         
     }];
    
}

@end
