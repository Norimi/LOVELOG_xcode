//
//  LoginViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/16.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLLoginViewController.h"
#import "FLAppDelegate.h"
#import "FLWellcomeViewController.h"
#import "FLAccountViewController.h"
#import "FLChatViewController.h"
#import "FLCardSelectViewController.h"
#import "FLPhotoViewController.h"
#import "FLTopViewController.h"
#import "FLPlantableViewController.h"
#import "FLConnection.h"


@interface FLLoginViewController ()

@property NSString* nowTagStr;
@property NSString *   flag;
@property NSString * idstring;
@property NSString * pidstring;
@property NSString * mname;
@property NSString * memail;
@property NSString * pname;
@property NSMutableData * receivedData;

@property int mid;
@property int pid;

@property Boolean inFlag;
@property Boolean inId;
@property Boolean inPid;
@property Boolean inMname;
@property Boolean inMemail;
@property Boolean inPname;
@property Boolean inError;
@property WBErrorNoticeView * notice;
@end

@implementation FLLoginViewController


FLWellcomeViewController * WVC;
FLAccountViewController * AVC;


@synthesize scrollView,nowTagStr,flag,idstring,pidstring,mname,memail,pname,mid,pid,inFlag,inId,inPid,inMname,inMemail,inPname,inError,notice,receivedData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self->scrollView setContentSize:CGSizeMake(320, 690)];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _passwordField.secureTextEntry = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toTabbar:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if([_emailField.text length]>0 & [_passwordField.text length]>0){
        
        NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/loginviewcontroller.php"];
        NSString * data = [NSString
                           stringWithFormat:@"email=%@&password=%@",
                           _emailField.text, _passwordField.text];
        
        FLConnection * connection = [[FLConnection alloc]init];
        
        if([connection connectionWithUrl:url withData:data]){
            //通信成功
            
            NSURL * myURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/loginviewcontrollerxml.php"];
            NSURLRequest * req = [NSURLRequest requestWithURL:myURL];
            NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:req delegate:self];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if(connection)
            {
                
                receivedData = [NSMutableData data];
                
                
            }
            
        }else{
            //通信失敗
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        }
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
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
    
    //ふたりの名前やemailも取得してuserdefaultsへ
    
    if([elementName isEqualToString:@"content"]){
        nowTagStr = [NSString stringWithString:elementName];
        
        flag = @"";
        idstring = @"";
        pidstring = @"";
        mname = @"";
        memail = @"";
        pname = @"";
        
        
    }
    
    
    if([elementName isEqualToString:@"flag"]){
        
        inFlag = YES;
    }
    
    if([elementName isEqualToString:@"id"]){
        
        inId = YES;
    }
    
    if([elementName isEqualToString:@"pid"]){
        
        inPid = YES;
    }
    
    if([elementName isEqualToString:@"mname"]){
        
        inMname = YES;
        
    }
    
    if([elementName isEqualToString:@"memail"]){
        
        inMemail = YES;
        
    }
    
    if([elementName isEqualToString:@"pname"]){
        
        
        inPname = YES;
        
    }
    
    
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString*)string {
    
    if(inFlag){
        
        flag= [flag stringByAppendingString:string];
    }
    
    if(inId){
        idstring = [idstring stringByAppendingString:string];
        
        mid = [idstring intValue];
    }
    
    if(inPid){
        
        pidstring = [pidstring stringByAppendingString:string];
        pid = [pidstring intValue];
    }
    
    if(inMname){
        
        mname = [mname stringByAppendingString:string];
    }
    
    if(inMemail){
        
        memail = [memail stringByAppendingString:string];
        
    }
    
    
    if(inPname){
        
        pname = [pname stringByAppendingString:string];
        
    }
    
}

-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
{
    
    //boolでログインできたかどうかを値をpostして確認する。didendelementでboolを判定。できてなかったらalertviewを
    //xmlにidを取得しておいて表示。ログインできたらuserdefaultsに値を保存して遷移する
    
    
    if([elementName isEqualToString:@"content"]){
        
        if([flag isEqualToString:@"ok"]){
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            
            
            
            [defaults removeObjectForKey:@"mid"];
            [defaults setInteger:mid forKey:@"mid"];
            [defaults removeObjectForKey:@"pid"];
            [defaults setInteger:pid forKey:@"pid"];
            [defaults removeObjectForKey:@"logged_in"];
            [defaults setBool:YES forKey:@"logged_in"];
            [defaults removeObjectForKey:@"mname"];
            [defaults setObject:mname forKey:@"mname"];
            [defaults removeObjectForKey:@"memail"];
            [defaults setObject:memail forKey:@"memail"];
            [defaults removeObjectForKey:@"pname"];
            [defaults setObject:pname forKey:@"pname"];
            [defaults synchronize];
            
            
            
            
            UITabBarController * tabBarController = [[UITabBarController alloc]init];
            FLCardSelectViewController * CSVC = [[FLCardSelectViewController alloc]init];
            FLPhotoViewController * AVC = [[FLPhotoViewController alloc]init];
            FLTopViewController * CVC = [[FLTopViewController alloc]init];
            FLPlantableViewController * PVC = [[FLPlantableViewController alloc]init];
            FLChatViewController * CHVC = [[FLChatViewController alloc]init];
            
            
            
            UINavigationController * nav0Controller = [[UINavigationController alloc]initWithRootViewController:CVC];
            UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:CSVC];
            UINavigationController* nav2Controller = [[UINavigationController alloc]initWithRootViewController:AVC];
            UINavigationController * nav3Controller = [[UINavigationController alloc]initWithRootViewController:PVC];
            UINavigationController * nav4Controller = [[UINavigationController alloc]initWithRootViewController:CHVC];
            
            
            
            
            nav0Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
            navController.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
            nav2Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
            nav3Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
            nav4Controller.navigationBar.tintColor = [UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0];
            
            
            nav0Controller.tabBarItem = [[UITabBarItem alloc]init];
            [nav0Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"box3.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"box1.png"]];
            nav4Controller.tabBarItem = [[UITabBarItem alloc]init];
            [nav4Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"chattab2.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"chattab1.png"]];
            
            nav3Controller.tabBarItem = [[UITabBarItem alloc]init];
            [nav3Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"plantab8.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"plantab7.png"]];
            navController.tabBarItem = [[UITabBarItem alloc]init];
            [navController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"cardtab2.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"cardtab1.png"]];
            nav2Controller.tabBarItem = [[UITabBarItem alloc]init];
            [nav2Controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"phototab2.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"phototab1.png"]];
            
            
            
            nav0Controller.title = @"ホーム";
            nav4Controller.title = @"チャット";
            nav3Controller.title = @"プラン";
            navController.title = @"カード";
            nav2Controller.title = @"アルバム";
            
            
            
            
            NSArray * viewControllers =[NSArray arrayWithObjects:nav0Controller, nav4Controller, nav3Controller, navController, nav2Controller, nil];
            
            
            [tabBarController setViewControllers:viewControllers];
            
            
            
            FLAppDelegate * appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
            
            
            
            [appDelegate.window setRootViewController:tabBarController];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            
            [self.view removeFromSuperview];
            
        }else{
        
            
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"ログインに失敗しました。" message:@"emailとpasswordをご確認の上、やりなおしてください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        }
        
    }
    
    if([elementName isEqualToString:@"flag"]){
        
        inFlag = NO;
    }
    
    if([elementName isEqualToString:@"id"]){
        
        inId = NO;
    }
    
    if([elementName isEqualToString:@"pid"]){
        
        inPid = NO;
    }
    
    if([elementName isEqualToString:@"mname"]){
        inMname = NO;
        
    }
    
    if([elementName isEqualToString:@"memail"]){
        inMemail = NO;
        
    }
    
    if([elementName isEqualToString:@"pname"]){
        inPname = NO;
        
    }
}


- (IBAction)enteredEmail:(id)sender {
    
    [_emailField resignFirstResponder];
    
}

- (IBAction)enteredPassword:(id)sender {
    
    [_passwordField resignFirstResponder];
}
@end
