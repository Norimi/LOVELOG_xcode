//
//  CardTitleViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/04/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLCardTitleViewController.h"
#import "FLConnection.h"

@interface FLCardTitleViewController ()
@end

@implementation FLCardTitleViewController

@synthesize cardImage, cardtoSend,messageView, message, titleField, titleString, scrollView;

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
    
    
    [self->scrollView setContentSize:CGSizeMake(320,560)];
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"送信"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(sendClicked:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    messageView.text = message;
    self.cardImage.image = [UIImage imageNamed:cardtoSend];
    self.title = @"タイトル入力";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void)viewDidAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)endTitle:(id)sender {
    
    [titleField resignFirstResponder];
    
}

-(void)sendClicked:(id)sender {
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if([titleField.text length]>0 & [message length]>0){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        titleString = titleField.text;
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSInteger idnumber = [defaults integerForKey:@"mid"];
        NSString * data = [NSString stringWithFormat:@"message=%@&title=%@&userid=%d&cardname=%@", message, titleString, idnumber,cardtoSend];
        NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/cardtitleviewcontroller.php"];
        FLConnection * connection = [[FLConnection alloc]init];
        if([connection connectionWithUrl:url withData:data]){
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
    
}


@end
