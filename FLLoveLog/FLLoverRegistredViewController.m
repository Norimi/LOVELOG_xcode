//
//  LoverRegistredViewController.m
//
//
//  Created by 立花 法美 on 2013/01/23.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLLoverRegistredViewController.h"
#import "FLAppDelegate.h"
#import "FLLoginViewController.h"

@interface FLLoverRegistredViewController ()
@property Boolean inUsername;
@property Boolean inPartnername;
@end

@implementation FLLoverRegistredViewController

FLLoginViewController * LVC;

@synthesize scrollView,userName, loverName,nowTagStr,username,partnername,inUsername,inPartnername;

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
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL * myURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/loverregisteredviewcontroller.php"];
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
        username = @"";
        partnername = @"";
    }
    
    
    if([elementName isEqualToString:@"username"]){
        
        inUsername = YES;
        
    }
    
    if([elementName isEqualToString:@"lovername"]){
        
        inPartnername = YES;
        
    }
    
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString*)string{
    
    if(inUsername){
        
        username = [username stringByAppendingString:string];
    }
    
    
    if(inPartnername){
        
        partnername = [partnername stringByAppendingString:string];
    }
    
    
}


-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName

{
    
    NSLog(@"didendelement");
    
    
    if([elementName isEqualToString:@"content"]){
        
        userName.text = [userName.text
                         stringByAppendingFormat:@"%@", username];
        loverName.text = [loverName.text
                          stringByAppendingFormat:@"%@", partnername];
        
        
    }
    
    
    if([elementName isEqualToString:@"username"]){
        
        inUsername = NO;
        
    }
    
    if([elementName isEqualToString:@"lovername"]){
        
        inPartnername = NO;
    }
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}

-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    WBErrorNoticeView * notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toLogin:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLLoginViewController * LVC = [[FLLoginViewController alloc]initWithNibName:@"FLLoginViewController" bundle:nil];
    [self presentViewController:LVC animated:true completion:nil];

}
@end
