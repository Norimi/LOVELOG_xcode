//
//  AddtodoViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLAddtodoViewController.h"
#import "FLAppDelegate.h"
#import "FLPlanmakeViewController.h"

@interface FLAddtodoViewController ()

@end

@implementation FLAddtodoViewController
@synthesize todoString, addButton, todoField;

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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    todoField = nil;
    addButton = nil;
    [self setTodoField:nil];
    [self setAddButton:nil];
    [super viewDidUnload];
}

- (IBAction)addTodo:(id)sender {
    
    FLPlanmakeViewController *VC = [[FLPlanmakeViewController alloc]init];
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];    todoString = todoField.text;
    [appDelegate.apptodoArray addObject:todoString];
    [self.navigationController pushViewController:VC animated:YES];
}



- (IBAction)enteredTodo:(id)sender {
    
       [todoField resignFirstResponder];
    
    
}
@end
