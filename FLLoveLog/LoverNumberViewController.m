//
//  LoverNumberViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/19.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "LoverNumberViewController.h"
#import "FLWarningViewController.h"
#import "WBErrorNoticeView.h"

@interface LoverNumberViewController ()
@property NSString * nowTagStr;
@property Boolean inLovername;
@property Boolean inLovernumber;
@property WBErrorNoticeView * notice;
@end

@implementation LoverNumberViewController

FLWarningViewController * WVC;

@synthesize nowTagStr,loverName,loverNumber,inLovername,inLovernumber,lovernameField, lovernumberField, scrollView,notice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *myURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/lovernumberviewcontroller.php"];
    NSXMLParser *myParser = [[NSXMLParser alloc]initWithContentsOfURL:myURL];
    myParser.delegate = self;
    [myParser parse];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    }
    
    [self->scrollView setContentSize:CGSizeMake(320, 600)];
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
        
       lovernameField.text = [lovernameField.text stringByAppendingFormat:@"%@", loverName];
        lovernumberField.text = [lovernumberField.text
                              stringByAppendingFormat:@"%@",loverNumber];
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
    
}

- (IBAction)toWarning:(id)sender {
    
     [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    WVC = [[FLWarningViewController alloc]
            initWithNibName:@"FLWarningViewController"
            bundle:nil];
    
    [[self navigationController]pushViewController:WVC
                                          animated:YES];
    
}
@end
