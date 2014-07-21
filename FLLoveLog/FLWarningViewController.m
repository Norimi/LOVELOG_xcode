//
//  WarningViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/21.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLWarningViewController.h"
#import "FLWaitingViewController.h"
#import "WBErrorNoticeView.h"


@interface FLWarningViewController ()

@property NSString * nowTagStr;

@property Boolean inLovername;
@property Boolean inLovernumber;
@property WBErrorNoticeView * notice;


@end

@implementation FLWarningViewController
@synthesize loverName, loverNumber,scrollView, mailButton,nowTagStr,inLovername,inLovernumber,notice;

FLWaitingViewController *WVC;
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
    // Do any additional setup after loading the view from its nib.
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    [self.navigationItem setHidesBackButton: YES animated:YES];
    [self->scrollView setContentSize:CGSizeMake(320, 600)];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    NSURL *myURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/lovernumberviewcontroller.php"];
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
    
    NSLog(@"did start element");
    
    
    if([elementName isEqualToString:@"content"]){
        
        nowTagStr = [NSString stringWithString:elementName];
        loverName = @"";
        loverNumber = @"";
    }
    
    
    if([elementName isEqualToString:@"loverName"]){
        
        inLovername = YES;
      
    }
    
    
    if([elementName isEqualToString:@"loverNumber"]){
        
        inLovernumber = YES;
    }
    
}




-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString *)string{
    
    if(inLovername){
        
        loverName = [loverName stringByAppendingString:string];
    }
    
    if(inLovernumber)
    {
        
        loverNumber = [loverNumber stringByAppendingString:string];
    }
}

-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
{
    
    if([elementName isEqualToString:@"content"]){
        
        
        _nameConfirm.text = [_nameConfirm.text stringByAppendingFormat:@"%@", loverName];
        _nameField.text = [_nameField.text stringByAppendingFormat:@"%@", loverName];
        _numberField.text = [_numberField.text
                                 stringByAppendingFormat:@"%@",loverNumber];
        FLWaitingViewController * WVC = [[FLWaitingViewController alloc]init];
        WVC.lovername = loverName;
        WVC.lovercode = loverNumber;
    }
    
    
    if([elementName isEqualToString:@"loverName"]){
        
        inLovername = NO;
        
    }
    
    
    if([elementName isEqualToString:@"loverNumber"]){
        
        inLovernumber = NO;
    }
    
    
       [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toWaiting:(id)sender {
    
     [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLWaitingViewController * WVC = [[FLWaitingViewController alloc]initWithNibName:@"WaitingViewController" bundle:nil];
    WVC.lovername = loverName;
    WVC.lovercode = loverNumber;
    
    [[self navigationController]pushViewController:WVC
                                          animated:YES];
    
}
- (IBAction)sendMail:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * subject = @"LOVE LOGをはじめませんか?";
    NSString * body = [NSString stringWithFormat:@"%@さんのラバーネーム\n%@\n\n%@さんのラバーコード\n%@", loverName, loverName, loverName, loverNumber];
    MFMailComposeViewController * mc = [[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate = self;
    [mc setSubject:subject];
    [mc setMessageBody:body isHTML:NO];
    
    [self presentViewController:mc animated:YES completion:NULL];
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"エラー" message:@"エラーが検出されました。"];
            [notice show];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
