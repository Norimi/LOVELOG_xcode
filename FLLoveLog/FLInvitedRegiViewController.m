
//
//  InvitedRegiViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/23.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLInvitedRegiViewController.h"
#import "FLLoverConfirmedViewController.h"
#import "WBErrorNoticeView.h"
#import "FLConnection.h"


@interface FLInvitedRegiViewController ()
@property(strong, nonatomic)NSString * nowTagStr;
@property(strong, nonatomic)NSString * errorMessage;
@property(strong, nonatomic)NSMutableData * receivedData;
@property Boolean inError;
@end

@implementation FLInvitedRegiViewController
@synthesize nowTagStr, errorMessage, receivedData,scrollView,inError;

FLLoverConfirmedViewController * LCVC;

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
    _passwordField.secureTextEntry = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self->scrollView setContentSize:CGSizeMake(320, 600)];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toConfirm:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if([_emailField.text length]>0 & [_passwordField.text length]>0){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //invite側と同じにしても良いかも。名前のみ多いしくみ。
        NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/invitedregiviewcontroller2.php"];
        NSString * data = [NSString
                           stringWithFormat:@"email=%@&password=%@&name=%@",
                           _emailField.text,_passwordField.text,_nameField.text];
        FLConnection * connection = [[FLConnection alloc]init];
        if([connection connectionWithUrl:url withData:data]){
            
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            FLLoverConfirmedViewController * LCVC =
            [[FLLoverConfirmedViewController alloc]init];
            
            [[self navigationController]pushViewController:LCVC
                                                  animated:YES];
            
        } else {
            
            WBErrorNoticeView * notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        }
        
    }
    
}




- (IBAction)putPassword:(id)sender {
    
    [_passwordField resignFirstResponder];
    
}


- (IBAction)putName:(id)sender {
    
    [_nameField resignFirstResponder];
    
}

- (IBAction)putEmail:(id)sender {
    
    
    [_emailField resignFirstResponder];
    
}
@end
