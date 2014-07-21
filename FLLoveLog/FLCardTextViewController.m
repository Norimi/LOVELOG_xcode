//
//  CardTextViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/31.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLCardTextViewController.h"
#import "FLCardTitleViewController.h"


@interface FLCardTextViewController ()

@end

@implementation FLCardTextViewController

@synthesize cardImage, cardName, textValue, cardMessage, scrollView;

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
    self.cardImage.image = [UIImage imageNamed:cardName];
    self.title = @"テキスト作成";
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self->scrollView setContentSize:CGSizeMake(320, 680)];
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"つぎへ"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(sendClicked:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


-(void)sendClicked:(id)sender{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLCardTitleViewController * CTVC = [[FLCardTitleViewController alloc]init];
    CTVC.cardtoSend = cardName;
    textValue = [NSString stringWithFormat:@"%@", cardMessage.text];
    CTVC.message = textValue;
    [self.navigationController pushViewController:CTVC animated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    [self.cardMessage resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [cardMessage resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
