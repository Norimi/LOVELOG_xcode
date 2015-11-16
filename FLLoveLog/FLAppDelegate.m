//
//  SMAppDelegate.m
//  sendMsg7
//
//  Created by 立花 法美 on 2012/12/05.
//  Copyright (c) 2012年 norimingconception.net. All rights reserved.
//

#import "FLAppDelegate.h"
#import "FLWellcomeViewController.h"
#import "FLLoginViewController.h"
#import "FLAccountViewController.h"
#import "FLChatViewController.h"
#import "FLPartnerAcViewController.h"
#import "FLCardSelectViewController.h"
#import "FLPhotoViewController.h"
#import "FLTopViewController.h"
#import "FLPlantableViewController.h"


@implementation FLAppDelegate


FLWellcomeViewController * WVC;
FLLoginViewController * LVC;
FLPhotoViewController * AVC;
FLTopViewController * CVC;
FLPartnerAcViewController * PAVC;
FLCardSelectViewController *  CSVC;
FLChatViewController * CHVC;
FLPlantableViewController* PVC;



@synthesize cardString, appurlArray, apptodoArray, categoryString, titleString, budgetString, dateString, EDIT, planidtoSend, arrayNumber, todoNumber,apptodoidArray, appurlidArray,enteredDate, loggedIn;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    appurlArray = [[NSMutableArray alloc]init];
    apptodoArray = [[NSMutableArray alloc]init];
    appurlidArray = [[NSMutableArray alloc]init];
    apptodoidArray = [[NSMutableArray alloc]init];
    categoryString = [[NSString alloc]init];
    titleString = [[NSString alloc]init];
    dateString = [[NSString alloc]init];
    budgetString = [[NSString alloc]init];
    planidtoSend = [[NSString alloc]init];
    enteredDate = [[NSString alloc]init];
    arrayNumber = [[NSString alloc]init];
    todoNumber = [[NSString alloc]init];
    
    
    //push通知
    //    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    //
    //
    
    UIImageView * view = [[UIImageView alloc]
                          initWithFrame:CGRectMake(0,0,320,48)];
    view.backgroundColor = [UIColor colorWithRed:0.8 green:0.0 blue:.0 alpha:0.5];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    int idnumber = [defaults integerForKey:@"mid"];
    loggedIn = [defaults boolForKey :@"logged_in"];
    
    
    if(idnumber > 0)
    {
        
        
        UITabBarController * tabBarController = [[UITabBarController alloc]init];
        FLCardSelectViewController * CSVC = [[FLCardSelectViewController alloc]init];
        FLPhotoViewController * AVC = [[FLPhotoViewController alloc]init];
        FLTopViewController * CVC = [[FLTopViewController alloc]init];
        FLPlantableViewController * PVC = [[FLPlantableViewController alloc]init];
        FLChatViewController * CHVC = [[FLChatViewController alloc]init];
        
        
        
        UINavigationController * nav0Controller = [[UINavigationController alloc]initWithRootViewController:CVC];
        UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:CSVC];
        UINavigationController* nav2Controller = [[UINavigationController alloc]initWithRootViewController:AVC];
        UINavigationController * nav3Controller = [[UINavigationController alloc]initWithRootViewController:PVC];
        UINavigationController * nav4Controller = [[UINavigationController alloc]initWithRootViewController:CHVC];
        
        
        
        nav0Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
        navController.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
        nav2Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
        nav3Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
        nav4Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
        
        nav0Controller.tabBarItem = [[UITabBarItem alloc]init];
        [nav0Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"box3.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"box1.png"]];
        nav4Controller.tabBarItem = [[UITabBarItem alloc]init];
        [nav4Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"chattab2.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"chattab1.png"]];
        nav3Controller.tabBarItem = [[UITabBarItem alloc]init];
        [nav3Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"plantab8.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"plantab7.png"]];
        navController.tabBarItem = [[UITabBarItem alloc]init];
        [navController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"cardtab2.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"cardtab1.png"]];
        nav2Controller.tabBarItem = [[UITabBarItem alloc]init];
        [nav2Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"phototab2.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"phototab1.png"]];
        
        
        nav0Controller.title = @"ホーム";
        nav4Controller.title = @"チャット";
        nav3Controller.title = @"プラン";
        navController.title = @"カード";
        nav2Controller.title = @"アルバム";
        
        
        
        NSArray * viewControllers =[NSArray arrayWithObjects:nav0Controller, nav4Controller, nav3Controller, navController, nav2Controller, nil];
        [tabBarController setViewControllers:viewControllers];
        [self.window setRootViewController:tabBarController];
        [self.window makeKeyAndVisible];
        return YES;
        
    }else{
        
        if(loggedIn == NO){
            
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            LVC = [[FLLoginViewController alloc]init];
            [[self window]setRootViewController:LVC];
            [self.window makeKeyAndVisible];
            return YES;
            
        } else {
            
            
            //ログインしたことがないとき
            FLWellcomeViewController * WVC = [[FLWellcomeViewController alloc]init];
            UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:WVC];
            navController.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
            [[self window]setRootViewController:navController];
            [self.window makeKeyAndVisible];
            return YES;
        }
    }
    
}


-(void)createBadge{
    
}

//
//-(void)application:(UIApplication*)ap didRegisterForRemoteNotificationWithDeviceToken:(NSData*)devToken{
//
//
//    NSString * deviceToken = [[[[devToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
//                               stringByReplacingOccurrencesOfString:@">" withString:@""]
//                              stringByReplacingOccurrencesOfString: @" " withString: @""];
//    NSLog(@"deviceToken: %@", deviceToken);
//
//
//
//
//}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(NSDictionary*)userInfo{
    
    NSLog(@"remote notification: %@",[userInfo description]);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSLog(@"Received Push Alert: %@", alert);
    
    NSString *sound = [apsInfo objectForKey:@"sound"];
    NSLog(@"Received Push Sound: %@", sound);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    NSString *badge = [apsInfo objectForKey:@"badge"];
    NSLog(@"Received Push Badge: %@", badge);
    application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    
    
}


- (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError*)err{
    NSLog(@"Errorinregistration.Error:%@",err);
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
