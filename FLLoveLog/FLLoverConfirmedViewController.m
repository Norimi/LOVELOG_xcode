//
//  LoverConfirmedViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/23.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLLoverConfirmedViewController.h"
#import "FLLoverRegistredViewController.h"
#import "WBErrorNoticeView.h"
#import "FLConnection.h"

@interface FLLoverConfirmedViewController ()
@property NSString * nowTagStr;
@property Boolean inEmail;
@property Boolean inPassword;
@property Boolean inName;
@property WBErrorNoticeView * notice;

@end

@implementation FLLoverConfirmedViewController

FLLoverRegistredViewController * LRVC;

@synthesize scrollView,nowTagStr,email,password,lovername,inEmail,inPassword,inName,notice;

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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL * myURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/loverconfirmedviewcontroller2.php"];
    NSXMLParser * myParser = [[NSXMLParser alloc]initWithContentsOfURL:myURL];
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
        lovername = @"";
        
        
    }
    
    if([elementName isEqualToString:@"email"]){
        
        inEmail = YES;
        
    }
    
    
    if([elementName isEqualToString:@"password"]){
        
        inPassword = YES;
        
    }
    
    if([elementName isEqualToString:@"name"]){
        
        inName = YES;
        
    }
}

-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString*)string{
    if(inEmail){
        
        email = [email stringByAppendingString:string];
        
    }
    
    if(inPassword)
    {
        
        password = [password stringByAppendingString:string];
        
    }
    
    if(inName)
    {
        
        lovername = [lovername stringByAppendingString:string];
        
    }
    
}


-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
{
    
    if([elementName isEqualToString:@"content"]){
        
        _emailField.text = [_emailField.text
                            stringByAppendingFormat:@"%@", email];
        
        _passwordField.text =@"表示されません";
        
        _nameField.text = [_nameField.text
                           stringByAppendingFormat:@"%@",
                           lovername];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    
    if([elementName isEqualToString:@"email"]){
        
        inEmail = NO;
        
    }
    
    if([elementName isEqualToString:@"password"]){
        
        inPassword = NO;
        
    }
    
    if([elementName isEqualToString:@"name"]){
        
        inName = NO;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toRegistred:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/loverconfirmedviewcontroller.php"];
    FLConnection * connection = [[FLConnection alloc]init];
    
    //TODO:以下、nilで良いかどうか吟味する
    if([connection connectionWithUrl:url withData:nil]){
        
        FLLoverRegistredViewController * LRVC = [[FLLoverRegistredViewController alloc]init];
        [[self navigationController]pushViewController:LRVC
                                              animated:YES];
        
    }else{
        
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        

        
    }
   }
@end
