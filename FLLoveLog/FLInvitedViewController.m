//
//  InvitedViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/23.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLInvitedViewController.h"
#import "FLInvitedRegiViewController.h"
#import "FLConnection.h"
#import "WBErrorNoticeView.h"

@interface FLInvitedViewController ()
@property NSString * nowTagStr;
@property NSString * flag;
@property Boolean inFlag;
@property int value;
@property WBErrorNoticeView * notice;
@property NSMutableData * receivedData;
@end

@implementation FLInvitedViewController
FLInvitedRegiViewController * IRVC;

@synthesize scrollView,nowTagStr,flag,inFlag,notice,receivedData;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toEmail:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if([_nameField.text length]>0 & [_numberField.text length]>0){
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/invitedviewcontroller.php"];
        NSString * data = [NSString
                           stringWithFormat:@"lovername=%@&lovernumber=%@", _nameField.text, _numberField.text ];
        FLConnection * connection = [[FLConnection alloc]init];
        
        if([connection connectionWithUrl:url withData:data]){
            
            NSURL * myURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/invitedviewcontrollerxml.php"];
            NSURLRequest * req = [NSURLRequest requestWithURL:myURL];
            NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:req delegate:self];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if(connection)
            {
                
                receivedData = [NSMutableData data];
                
                
            }
            
        }else{
            
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        }
 
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
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

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
   attributes:(NSDictionary*)attributeDict{

    if([elementName isEqualToString:@"content"]){
        nowTagStr = [NSString stringWithString:elementName];
        flag = @"";
        
    }
    
    if([elementName isEqualToString:@"flag"]){
        
        inFlag = YES;
        NSLog(@"inflag");
    }
    
}


-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString*)string{
    
    if(inFlag){
        
        flag = [flag stringByAppendingString:string];
    }
}


-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
{
    
    
    if([elementName isEqualToString:@"content"]){
        if([flag isEqualToString:@"ok"]){
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            FLInvitedRegiViewController * IRVC = [[FLInvitedRegiViewController alloc]init];
            [[self navigationController]pushViewController:IRVC animated:YES];
            
        } else {
            
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"認証できません。"
                                                            message:@"ラバーネームとラバーナンバーを入力してください。"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            
            [alert show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        
    }
    
    if(([elementName isEqualToString:@"flag"])) {
        
        inFlag = NO;
    }
}


- (IBAction)putName:(id)sender {
    
    
    [_nameField resignFirstResponder];
    
}

- (IBAction)putNumber:(id)sender {
    
    [_numberField resignFirstResponder];
    
}
@end
