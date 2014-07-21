//
//  SMAppDelegate.h
//  sendMsg7
//
//  Created by 立花 法美 on 2012/12/05.
//  Copyright (c) 2012年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLWellcomeViewController;
@class SMViewController;
@class startViewController;
@class ContainerViewController;
@class finishViewController;
@class messagesViewController;
@class closedViewController;
@class UITabBarController;

@interface FLAppDelegate : UIResponder <UIApplicationDelegate>

//シングルトンとして一時的な情報を保持
@property(strong, nonatomic)UIWindow * window;
@property(strong, nonatomic)UIImageView * theImage;
@property(strong, nonatomic)NSString* cardString;
@property (strong, nonatomic)ContainerViewController  * containerViewController;
@property(strong, nonatomic)NSMutableArray * appurlArray;
@property(strong, nonatomic)NSMutableArray * apptodoArray;
@property(strong, nonatomic)NSString * categoryString;
@property(strong, nonatomic)NSString * titleString;
@property(strong, nonatomic)NSString * budgetString;
@property(strong, nonatomic)NSString * dateString;
@property(assign, readwrite)BOOL EDIT;
@property(strong, nonatomic)NSString * planidtoSend;
@property(strong, nonatomic)NSString * arrayNumber;
@property(strong, nonatomic)NSString * todoNumber;
@property(strong, nonatomic)NSMutableArray * apptodoidArray;
@property(strong, nonatomic)NSMutableArray * appurlidArray;
@property(strong, nonatomic)NSString * enteredDate;
@property BOOL loggedIn;


@end
