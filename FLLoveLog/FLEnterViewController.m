//
//  EnterViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/15.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLEnterViewController.h"
#import "FLConfirmViewController.h"
#import "FLConnection.h"
#import "WBErrorNoticeView.h"
#import "FLWarningViewController.h"

@interface FLEnterViewController ()
@property(strong, nonatomic)NSMutableData * receivedData;
@property Boolean inError;
@property(strong, nonatomic) NSString * nowTagStr;
@property(strong, nonatomic) NSString * errorMessage;
@property WBErrorNoticeView * notice;


@end

@implementation FLEnterViewController

@synthesize scrollView, nowTagStr, errorMessage, receivedData, emailField, passwordField,inError,notice;

FLConfirmViewController * CVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //FLLoverWarningViewControllerで取得するlovernameとlovernumberが
        //すでにある場合、warningviewcontrollerへ移動する
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * loverName = [defaults objectForKey:@"lover_name"];
        NSString * loverNumber = [defaults objectForKey:@"lover_number"];
        
        if(loverName && loverNumber){
            FLWarningViewController * FLWVC = [[FLWarningViewController alloc]init];
            FLWVC.loverName = loverName;
            FLWVC.loverNumber = loverNumber;
            [self.navigationController pushViewController:FLWVC animated:YES];
        }
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)toConfirme:(id)sender {
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //情報を送信する
    if([emailField.text length]>0 & [passwordField.text length]>0){
        
        
        NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/enterviewcontroller.php"];
        NSString * data = [NSString
                           stringWithFormat:@"email=%@&password=%@",  emailField.text, passwordField.text];
        FLConnection * connection = [[FLConnection alloc]init];
        if([connection connectionWithUrl:url withData:data]){
            //成功時
             [self startParse];
            
        }else{
            //失敗時
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        }
        
    }
    
}


-(void)startParse{
    
    NSURL *newURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/enterviewcontrollerxml.php"];
    NSURLRequest * req = [NSURLRequest requestWithURL:newURL];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    
    if(connection)
    {
        
        receivedData = [NSMutableData data];
    }
    
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    
    NSXMLParser * newParser = [[NSXMLParser alloc]initWithData:receivedData];
    [newParser setDelegate:self];
    
    [newParser parse];
    receivedData = nil;
    connection = nil;
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
    
        inError = NO;
    
    if([elementName isEqualToString:@"content"]){
        
        nowTagStr = [[NSString alloc]init];
        errorMessage = [[NSString alloc]init];
        
    }
    if([elementName isEqualToString:@"error"]){
        
        inError = YES;
    }
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString *)string{
    if(inError){
        
        errorMessage = [errorMessage stringByAppendingString:string];
    }
}


-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"content"] ) {
        
    }  if([elementName isEqualToString:@"error"]){
        inError = NO;
    }
    
}

-(void)parserDidEndDocument:(NSXMLParser*)parser
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if(errorMessage.length > 0){
        
        NSLog(@"errormessage%@", errorMessage);
        NSString *body = @"すでに登録済みのemailアドレスです。";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:body delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
       
        
    } else {
        
        
        
        CVC = [[FLConfirmViewController alloc]
               initWithNibName:@"FLConfirmViewController"
               bundle:nil];
        [[self navigationController]pushViewController:CVC
                                              animated:YES];
        
        
    }
}


- (IBAction)inputEmail:(id)sender {
    
    [emailField resignFirstResponder];
}



- (IBAction)inputPassword:(id)sender {
    
    [passwordField resignFirstResponder];
}


@end
