//
//  LocationHelper.h
//  GpsTest
//
//  Created by dongjl on 14-11-14.
//  Copyright (c) 2014年 DongJL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void  (^GetLocationBlock) (id response);
typedef void  (^ResponseBlock) (id response);

@interface LocationHelper : NSObject<CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic,strong) ResponseBlock responseBlock;
@property (nonatomic,strong) GetLocationBlock getLocationBlock;
-(void)startUpdateLocation:(GetLocationBlock)getLocationBlock;
-(void)stopUpdateLocation;
-(void)reverseGeocodeLocation:(CLLocation*)location address:(ResponseBlock)responseBlock;
@end
