//
//  WebViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/04/16.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize url;

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
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = CGRectMake(0,0,frame.size.width, frame.size.height);
    UIWebView *wv = [[UIWebView alloc] initWithFrame:rect];
    wv.delegate = self;
    [self.view  addSubview:wv];
      wv.scalesPageToFit = YES;
    
    NSURLRequest *URLreq = [NSURLRequest requestWithURL:url];
    [wv loadRequest: URLreq];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
