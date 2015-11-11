//
//  ResignViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/02/27.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLResignViewController.h"
#import "FLWellcomeViewController.h"
#import "FLAppDelegate.h"
#import "FLConnection.h"

@interface FLResignViewController ()

@end

@implementation FLResignViewController

FLWellcomeViewController * WVC;
FLAppDelegate * appDelegate;

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self->scrollView setContentSize:CGSizeMake(320, 600)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteAll:(id)sender {
    
    //midを送り、そこにひもづけられているすべての情報を消去する
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/resignviewcontroller.php"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSString * data = [NSString stringWithFormat:@"userid=%d", idnumber];
    
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        //成功の場合
        [defaults removeObjectForKey:@"mid"];
        [defaults removeObjectForKey:@"pid"];
        [defaults removeObjectForKey:@"logged_in"];
        [defaults synchronize];
        
        WVC = [[FLWellcomeViewController alloc]init];
        UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:WVC];
        navController.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
        FLAppDelegate * appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
        [appDelegate.window setRootViewController:navController];
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        

    } else {
        //失敗の場合
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
}
@end
