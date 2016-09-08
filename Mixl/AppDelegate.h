//
//  AppDelegate.h
//  Mixl
//
//  Created by John on 4/6/16.
//  Copyright © 2016 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, retain) CLLocationManager *locationManager;

- (void)updateLocationManager;
@end

