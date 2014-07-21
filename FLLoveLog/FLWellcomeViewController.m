//
//  WellcomeViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/11.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLWellcomeViewController.h"
#import "FLAppDelegate.h"
#import "FLInvitedViewController.h"
#import "FLEnterViewController.h"
#import "FLLoginViewController.h"


@interface FLWellcomeViewController ()

@end

@implementation FLWellcomeViewController

FLAppDelegate * appDelegate;
FLEnterViewController * EVC;
FLInvitedViewController * IVC;
FLLoginViewController * LVC;

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
    // Do any additional setup after loading the view from its nib.
    //after implementing scroll view into xib file...
    //in view did load, for example
    
    
    [self->scrollView setContentSize:CGSizeMake(320, 600)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)toFirst:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    EVC = [[FLEnterViewController alloc]initWithNibName:@"EnterViewController" bundle:nil];
    [[self navigationController]pushViewController:EVC animated:YES];
    
}



- (IBAction)toInvited:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    IVC = [[FLInvitedViewController alloc]init];
    [[self navigationController]pushViewController:IVC animated:YES];
    
    
    
}

- (IBAction)toLogin:(id)sender {
    
    
    FLLoginViewController * LVC = [[FLLoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [[self navigationController]pushViewController:LVC animated:YES];
    
    
}
@end
