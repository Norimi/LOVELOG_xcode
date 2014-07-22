//
//  SignedViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/15.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//


#import "FLSignedViewController.h"
#import "FLAppDelegate.h"
#import "FLLoginViewController.h"



@interface FLSignedViewController()
@end

@implementation FLSignedViewController
@synthesize scrollView;

FLLoginViewController * LVC;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
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
    _loverNameField.text = [_loverNameField.text
                       stringByAppendingFormat:@"%@", _loverName];
    [self->scrollView setContentSize:CGSizeMake(320, 600)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)dismissSCVC:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLLoginViewController * LVC = [[FLLoginViewController alloc]initWithNibName:@"FLLoginViewController" bundle:nil];
    [self presentViewController:LVC animated:true completion:nil];
    
}
@end
