//
//  DaddysDollarAppDelegate.h
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-6.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DaddysDollarViewController;

@interface DaddysDollarAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DaddysDollarViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DaddysDollarViewController *viewController;

+ (void)ParentEntrance:(UINavigationController*)NVC;
+ (void)ChildEntrance:(UINavigationController*)NVC;
+ (void)TBD;
@end

