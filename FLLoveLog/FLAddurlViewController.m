//
//  AddurlViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLAddurlViewController.h"
#import "FLPlanmakeViewController.h"
#import "FLAppDelegate.h"

@interface FLAddurlViewController ()

@end

@implementation FLAddurlViewController
@synthesize addButton, urlField, urlString;


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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
}




- (void)viewDidUnload {
    [self setAddButton:nil];
    addButton = nil;
    urlField = nil;
    [self setUrlField:nil];
    [super viewDidUnload];
}


- (IBAction)tapButton:(id)sender {
    
    FLPlanmakeViewController * PVC = [[FLPlanmakeViewController alloc]init];
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
    urlString = urlField.text;
    NSMutableArray * tmpArray = [appDelegate.appurlArray mutableCopy];
    [tmpArray addObject:urlString];
    appDelegate.appurlArray = tmpArray;
    [self.navigationController pushViewController:PVC  animated:NO];
}

- (IBAction)endEnter:(id)sender {
    [urlField resignFirstResponder];
}
@end
