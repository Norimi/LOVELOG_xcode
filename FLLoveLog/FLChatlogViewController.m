//
//  ChatlogViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLChatlogViewController.h"
#import "FLChatViewController.h"
#import "FLConnection.h"
#import "WBErrorNoticeView.h"


@interface FLChatlogViewController ()
@property UIBarButtonItem * bbi;
@end

@implementation FLChatlogViewController
@synthesize chatField, scrollView,bbi;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = @"メッセージの作成";
    bbi = [[UIBarButtonItem alloc]initWithTitle:@"送信"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(sendClicked:)];
    
    [[self navigationItem]setRightBarButtonItem:bbi];
    [self->scrollView setContentSize:CGSizeMake(320, 518)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)sendClicked:(id)sender{
   
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [chatField resignFirstResponder];
    
    NSString * sendString = [[NSString alloc]init];
    sendString = chatField.text;
    
    if([sendString length]>0){
        
        [bbi setEnabled:false];
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSInteger idnumber = [defaults integerForKey:@"mid"];
        NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/chatlogviewcontroller.php"];
        NSString * data = [NSString stringWithFormat:@"chat=%@&userid=%d&loveindi=%d", sendString, idnumber, loveIndicator];
        FLConnection * connection = [[FLConnection alloc]init];
        
        if([connection connectionWithUrl:url withData:data]){
            
        }else{
            
            WBErrorNoticeView * notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        }
        
        //成功しても失敗しても遷移する
        FLChatViewController * CVC = [[FLChatViewController alloc]init];
        [[self navigationController]pushViewController:CVC animated:YES];
        [bbi setEnabled:true];
    }
    
}



@end
