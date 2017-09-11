//
//  AppDelegate.m
//  motionDemo
//
//  Created by liushuai on 2017/9/8.
//  Copyright © 2017年 liushuai. All rights reserved.
//

#import "AppDelegate.h"

static BOOL L0AccelerationIsShaking(UIAcceleration* last, UIAcceleration* current, double threshold) {
    double
    deltaX = fabs(last.x - current.x),
    deltaY = fabs(last.y - current.y),
    deltaZ = fabs(last.z - current.z);
    
    return
    (deltaX > threshold && deltaY > threshold) ||
    (deltaX > threshold && deltaZ > threshold) ||
    (deltaY > threshold && deltaZ > threshold);
}

@interface AppDelegate ()<UIApplicationDelegate,UIAccelerometerDelegate>
@property (nonatomic,strong) UIAcceleration* lastAcceleration;
@end



@implementation AppDelegate{
    BOOL histeresisExcited;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIAccelerometer sharedAccelerometer].delegate = self;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    if (self.lastAcceleration) {
        if (!histeresisExcited && L0AccelerationIsShaking(self.lastAcceleration, acceleration, 0.7)) {
            histeresisExcited = YES;
            
            NSLog(@"shaking");
            /* SHAKE DETECTED. DO HERE WHAT YOU WANT. */
            
        } else if (histeresisExcited && !L0AccelerationIsShaking(self.lastAcceleration, acceleration, 0.2)) {
            histeresisExcited = NO;
        }
    }
    
    self.lastAcceleration = acceleration;
}



@end
