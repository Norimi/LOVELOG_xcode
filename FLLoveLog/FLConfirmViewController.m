//
//  ConfirmViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/15.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLConfirmViewController.h"
#import "WBErrorNoticeView.h"
#import "FLLovernameViewController.h"
#import "FLConnection.h"


@interface FLConfirmViewController ()
@property NSString * nowTagStr;
@property Boolean inEmail;
@property Boolean inPassword;
@property WBErrorNoticeView * notice;
@end

@implementation FLConfirmViewController
@synthesize passwordLabel, emailLabel, scrollView,nowTagStr,email,password,inEmail,inPassword,notice;
FLLovernameViewController * LVC;


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
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *myURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/confirmviewcontroller.php"];
    NSXMLParser *myParser = [[NSXMLParser alloc]initWithContentsOfURL:myURL];
    myParser.delegate = self;
    [myParser parse];
    
}



-(void)parserDidStartDocument:(NSXMLParser*)parser
{
    
    nowTagStr = @"";
    
}

-(void)parser:(NSXMLParser*)parser
didStartElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
   attributes:(NSDictionary*)attributeDict{
    
    if([elementName isEqualToString:@"content"]){
        
        nowTagStr = [NSString stringWithString:elementName];
        email = @"";
        password =@"";
    }
    
    
    if([elementName isEqualToString:@"email"]){
        
        inEmail = YES;
      
    }
    
    
    if([elementName isEqualToString:@"password"]){
        
        inPassword = YES;
    }
    
    
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString *)string{
    
    if(inEmail){
        
        email = [email stringByAppendingString:string];
    }
    
    if(inPassword)
    {
        password = [password stringByAppendingString:string];
        
        
    }
}

-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
{
    
    if([elementName isEqualToString:@"content"]){
        
        emailLabel.text = [emailLabel.text stringByAppendingFormat:@"%@", email];
        
        
        passwordLabel.text = @"表示されません";
        
    }
    
    
    if([elementName isEqualToString:@"email"]){
        
        inEmail = NO;
        
    }
    
    
    if([elementName isEqualToString:@"password"]){
        
        inPassword = NO;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}



- (IBAction)toSigned:(id)sender
{
    
    //このボタンによって登録される。phpによる連携.confirmeviewcontrollerをただリクエスト。
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/confirmedviewcontroller.php"];
    FLConnection * connection = [[FLConnection alloc]init];
    //todo:以下nilでよいかどうかを吟味する
    if([connection connectionWithUrl:url withData:nil]){
        
        LVC = [[FLLovernameViewController alloc]
               initWithNibName:@"FLLovernameViewController"
               bundle:nil];
        
        [[self navigationController]pushViewController:LVC
                                              animated:YES];
        

        
    }else{
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }
    
}


@end