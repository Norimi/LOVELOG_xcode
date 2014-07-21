//
//  LovernameViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/19.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLLovernameViewController.h"
#import "LoverNumberViewcontroller.h"
#import "FLConnection.h"
#import "WBErrorNoticeView.h"

@interface FLLovernameViewController ()
@property WBErrorNoticeView * notice;

@end

@implementation FLLovernameViewController

LoverNumberViewController * LNVC;

@synthesize usernameField, lovernameField, scrollView,notice;

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
  
     [self->scrollView setContentSize:CGSizeMake(320, 600)];
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)toLoverNumber:(id)sender {
     [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if([usernameField.text length]>0 & [lovernameField.text length]>0){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        FLConnection * connection = [[FLConnection alloc]init];
        NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/lovernameviewcontroller.php"];
        NSString * data = [NSString stringWithFormat:@"username=%@&lovername=%@", usernameField.text, lovernameField.text];
        if([connection connectionWithUrl:url withData:data]){
            
            LNVC = [[LoverNumberViewController alloc]
                    initWithNibName:@"LoverNumberViewController"
                    bundle:nil];
            [[self navigationController]pushViewController:LNVC
                                                  animated:YES];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            
            
        }else{
            
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
            [notice show];
            
            
        }
        
    }
    
}

- (IBAction)inputUsername:(id)sender {
    
    [usernameField resignFirstResponder];
    
}

- (IBAction)inputLovername:(id)sender {
    [lovernameField resignFirstResponder];
    
}
@end
