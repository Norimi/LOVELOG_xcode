//
//  DateViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/08/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLDateViewController.h"
#import "FLPlanmakeViewController.h"
#import "FLAppDelegate.h"

@interface FLDateViewController ()

@end

@implementation FLDateViewController

@synthesize dateField, dp,doneButton;

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
    [dp setDatePickerMode:UIDatePickerModeDateAndTime];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dateChanged:(id)sender {
    
    // 日付の表示形式を設定
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd HH:mm";
    dateField.text = [df stringFromDate:dp.date];
    
    
}
- (IBAction)toMake:(id)sender {
    
    NSString * toPass = dateField.text;
    FLAppDelegate* appDelegate;
    appDelegate = (FLAppDelegate *)[[UIApplication sharedApplication]delegate];
    FLPlanmakeViewController * PMVC = [[FLPlanmakeViewController alloc]init];
    appDelegate.dateString = toPass;
    [self.navigationController pushViewController:PMVC animated:YES];
    
}
@end
