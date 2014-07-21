//
//  SelectedCardViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/04/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLSelectedCardViewController.h"

@interface FLSelectedCardViewController ()

@end

@implementation FLSelectedCardViewController
@synthesize cardView, messageView, message, imageName, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cardView.image = [UIImage imageNamed:imageName];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:16];
    messageView.font = font;
    messageView.text = message;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
     [self->scrollView setContentSize:CGSizeMake(320, 600)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
