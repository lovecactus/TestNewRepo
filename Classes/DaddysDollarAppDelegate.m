//
//  DaddysDollarAppDelegate.m
//  DaddysDollar
//
//  Created by Yang Wei on 10-11-6.
//  Copyright 2010 Tapatalk. All rights reserved.
//

#import "DaddysDollarAppDelegate.h"
#import "DaddysDollarViewController.h"
#import	"LoginVC.h"
#import	"ParentsMelonVC.h"
#import	"ParentsItemsVC.h"
#import	"ChildrenMelonVC.h"
#import	"ChildrenItemsVC.h"
#import "Global.h"
#import	"Constants.h"

@implementation DaddysDollarAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark Initialize Data
- (void)InitItems{
	GlobalItems = [[NSMutableArray alloc] init];
	NSDictionary *Item1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Buy Ice Cream",@"ItemName",@"5",@"Price",@"New",@"Status",nil];
	NSDictionary *Item2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Buy a Transformer",@"ItemName",@"50",@"Price",@"New",@"Status",nil];
	NSDictionary *Item3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Buy Hot Dog",@"ItemName",@"10",@"Price",@"New",@"Status",nil];
	NSDictionary *Item4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Go to Desney Land",@"ItemName",@"100",@"Price",@"New",@"Status",nil];
	NSDictionary *Item5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Camp at weekend",@"ItemName",@"500",@"Price",@"New",@"Status",nil];
	[GlobalItems addObject:Item1];
	[GlobalItems addObject:Item2];
	[GlobalItems addObject:Item3];
	[GlobalItems addObject:Item4];
	[GlobalItems addObject:Item5];	
}

- (void)InitialData{
	[self InitItems];
	[defs setObject:nil forKey:@"ChildInfo"];
}


#pragma mark -
#pragma mark Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	[self InitialData];

    // Add the view controller's view to the window and display.
    //[window addSubview:viewController.view];
	LoginVC *loginVC = [[LoginVC alloc] init];
	UINavigationController *RootNVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
	[window addSubview:RootNVC.view];
    [window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

#pragma mark Universal Routines
+ (void)ParentEntrance:(UINavigationController*)NVC {
	NSLog(@"Push in parents tabs");
	ParentsMelonVC *melonVC = [[ParentsMelonVC alloc] init];
	UINavigationController *melonNVC = [[UINavigationController alloc] initWithRootViewController:melonVC];
	ParentsItemsVC *itemVC =[[ParentsItemsVC alloc] init];
	UINavigationController *itemNVC = [[UINavigationController alloc] initWithRootViewController:itemVC];
	
	NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
	
	[viewControllers addObject:melonNVC];
	[viewControllers addObject:itemNVC];
	UITabBarController *ParentsTabVC = [[UITabBarController alloc] init];
	ParentsTabVC.viewControllers = viewControllers;
	ParentsTabVC.selectedIndex = 0;
	
	NVC.navigationBarHidden = YES;
	[NVC pushViewController:ParentsTabVC animated:YES];
	[melonVC release];
	[melonNVC release];
	[itemVC release];
	[itemNVC release];
}

+ (void)ChildEntrance:(UINavigationController *)NVC{
	NSLog(@"Push in child tabs");
	//dummy
	ChildrenMelonVC *melonVC = [[ChildrenMelonVC alloc] init];
	UINavigationController *melonNVC = [[UINavigationController alloc] initWithRootViewController:melonVC];
	ChildrenItemsVC *itemVC = [[ChildrenItemsVC alloc] init];
	UINavigationController *itemNVC = [[UINavigationController alloc] initWithRootViewController:itemVC];
	NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
	
	[viewControllers addObject:melonNVC];
	[viewControllers addObject:itemNVC];
	UITabBarController *ChildrenTabVC = [[UITabBarController alloc] init];
	ChildrenTabVC.viewControllers = viewControllers;
	ChildrenTabVC.selectedIndex = 0;
	
	NVC.navigationBarHidden = YES;
	[NVC pushViewController:ChildrenTabVC animated:YES];	
	[itemVC release];
	[itemNVC release];
	[melonVC release];
	[melonNVC release];
}

+ (void)TBD{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TBD"
													message:@"This part is to be done."
												   delegate:nil
										  cancelButtonTitle:NSLocalizedString(@"OK", @"")
										  otherButtonTitles:nil];
	alert.tag = 0;
	[alert show];
	[alert release];
	 
}
@end
