//
//  WaitingViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/21.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLWaitingViewController.h"
#import "FLWarningViewController.h"
#import "FLSignedViewController.h"
#import "WBErrorNoticeView.h"

@interface FLWaitingViewController ()

@property NSString * nowTagStr;
@property NSString * flag;
@property int value;
@property Boolean inFlag;
@property Boolean inLovername;
@end

@implementation FLWaitingViewController
FLWarningViewController * WVC;
FLSignedViewController * SVC;

@synthesize time, lovername, lovercode, nameField, lovernameLabel, codeLabel, titleName, scrollView,nowTagStr,flag,value,inFlag,inLovername;

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
    
    NSArray * imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"waitingviewcontroller.png"],
                            [UIImage imageNamed:@"waitingviewcontroller1.png"],
                            [UIImage imageNamed:@"waitingviewcontroller2.png"],
                            [UIImage imageNamed:@"waitingviewcontroller3.png"],
                            nil];
    waitImage.animationImages = imageArray;
    waitImage.animationDuration = 2.4;
    waitImage.animationRepeatCount = 0;
    [waitImage startAnimating];
    
    
    time = [NSTimer
            scheduledTimerWithTimeInterval:5.0
            target:self
            selector:@selector(searchRegistration:)
            userInfo:nil
            repeats:YES];
    [self.navigationItem setHidesBackButton: YES animated:YES];
    
    
    
}

-(void)searchRegistration:(NSTimer*)timer{
    //調べてflagをたてる。parserでflagが1だったら次のviewへ
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *myURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/waitingviewcontroller.php"];
    NSXMLParser *myParser = [[NSXMLParser alloc]initWithContentsOfURL:myURL];
    myParser.delegate = self;
    [myParser parse];
    
}



-(void)parserDidStartDocument:(NSXMLParser*)parser
{
    
    nowTagStr = @"";
    flag = @"";
    
}


-(void)parser:(NSXMLParser*)parser
didStartElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
   attributes:(NSDictionary*)attributeDict{
 
    if([elementName isEqualToString:@"content"]){
        
        nowTagStr = [NSString stringWithString:elementName];
    }
    
    
    if([elementName isEqualToString:@"lovername"]){
        
        inLovername = YES;
    }
    
    
    if([elementName isEqualToString:@"flag"]){
        
        inFlag = YES;
        
    }
}



-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString *)string{
    if(inLovername){
        
        
    }
    
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
        //ここで判定。次のページへ
        
        if([nameField.text length] == 0){
            nameField.text = [nameField.text
                              stringByAppendingFormat:@"%@", lovername];
            titleName.text = [titleName.text stringByAppendingFormat:@"%@", lovername];
            lovernameLabel.text = [lovernameLabel.text stringByAppendingFormat:@"%@", lovername];
            codeLabel.text = [codeLabel.text stringByAppendingFormat:@"%@", lovercode];
            
        }
        
        if([flag isEqualToString:@"ok"]){
            SVC = [[FLSignedViewController alloc]
                   initWithNibName:@"SignedViewController"
                   bundle:nil];
            
            SVC.loverName = lovername;
            [[self navigationController]pushViewController:SVC
                                                  animated:YES];
        }
        
    }
    
    if([elementName isEqualToString:@"lovername"]){
        
        inLovername = NO;
        
    }
    
    
    if([elementName isEqualToString:@"flag"]){
        
        inFlag = NO;
        
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

@end
