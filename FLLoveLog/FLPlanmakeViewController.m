//
//  PlanmakeViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLPlanmakeViewController.h"
#import "FLAppDelegate.h"
#import "FLAddurlViewController.h"
#import "FLAddtodoViewController.h"
#import "FLPlanViewController.h"
#import "FLDateViewController.h"
#import "FLCOnnection.h"
#import "WBErrorNoticeView.h"


@interface FLPlanmakeViewController ()
@property(strong,nonatomic)NSString * category;
@property(strong,nonatomic)NSString * dateString;
@property(strong, nonatomic)NSString * passedURL;
@property(strong,nonatomic)NSString * tmpDateString;
@property(strong, nonatomic,readonly)UITextField * userTextField;
@property (strong, nonatomic, readonly)UITextField * categoryField;
@property (strong, nonatomic,readonly)UITextField *dateField;
@property (strong, nonatomic,readonly)UITextField *titleField;
@property (strong, nonatomic,readonly)UITextField *budgetField;
@property(strong, nonatomic)NSMutableArray * URLArray;
@property(strong, nonatomic)NSMutableArray * todoArray;
@property WBErrorNoticeView * notice;
@end

@implementation FLPlanmakeViewController
@synthesize planTable, titleField, dateField, URLArray, todoArray, passedURL, budgetField, categoryField,category,userTextField,tmpDateString,dateString,notice;


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
    
    NSLog(@"planmake");
    [super viewDidLoad];
    self.title=@"プランの編集";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    URLArray = nil;
    todoArray = nil;
    planTable.dataSource = self;
    planTable.delegate = self;
    
  
    [self setNavbarComponents];
    [self setTextFields];
    [self.navigationItem setHidesBackButton: YES animated:YES];
      
}


-(void)setNavbarComponents{
    
    UIBarButtonItem * bbi2 = [[UIBarButtonItem alloc]initWithTitle:@"閉じる"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(closeClicked:)];
    
    [[self navigationItem]setLeftBarButtonItem:bbi2];
    
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"確認"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(seeClicked:)];
    
    [[self navigationItem]setRightBarButtonItem:bbi];
    
    
}

-(void)setTextFields{
    
    
    //各セルにアクセスするため設定
    categoryField.tag =1;
    titleField.tag = 2;
    dateField.tag = 3;
    budgetField.tag = 4;
    
    categoryField = [[UITextField alloc]initWithFrame:CGRectMake(110, 10, 185, 30)];
    categoryField.adjustsFontSizeToFitWidth = YES;
    categoryField.textColor = [UIColor darkGrayColor];
    [categoryField addTarget:self
                      action:@selector(resignResponder:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    titleField = [[UITextField alloc]initWithFrame:CGRectMake(110, 10, 185, 30)];
    titleField.adjustsFontSizeToFitWidth = YES;
    titleField.textColor = [UIColor darkGrayColor];
    [titleField addTarget:self
                   action:@selector(resignResponder:)
         forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    budgetField = [[UITextField alloc]initWithFrame:CGRectMake(110, 10, 185, 30)];
    budgetField.adjustsFontSizeToFitWidth =YES;
    budgetField.textColor = [UIColor darkGrayColor];
    [budgetField addTarget:self
                    action:@selector(budgetResign:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    dateField = [[UITextField alloc]initWithFrame:CGRectMake(110, 10, 185, 30)];
    dateField.adjustsFontSizeToFitWidth = YES;
    dateField.textColor = [UIColor darkGrayColor];
    
    self.categoryField.delegate = self;
    self.titleField.delegate = self;
    self.budgetField.delegate = self;
    self.dateField.delegate = self;
    
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

-(void)budgetResign:(id)sender{
    
    [budgetField resignFirstResponder];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"flplanmakeview");
    [self.planTable setContentOffset:CGPointMake(0, self.planTable.contentSize.height - self.planTable.frame.size.height)];
    
    [self setTexts];
    
    CGRect tableFrame = [planTable frame];
    tableFrame.size.height = 1000;
    //[self scrollTableView];
    
    [planTable setFrame:tableFrame];
    [self.planTable reloadData];
    
    
}

-(void)scrollTableView{
    //scrollしないと、backbuttonで戻ってきたときにtableが消えてしまうので、暫定的に処理
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
    [self.planTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}


-(void)setTexts{
    
    
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
    [categoryField setText:appDelegate.categoryString];
    [titleField setText:appDelegate.titleString];
    [dateField setText:appDelegate.dateString];
    [budgetField setText:appDelegate.budgetString];
    
    URLArray = appDelegate.appurlArray;
    todoArray = appDelegate.apptodoArray;
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 4;
}


-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 2;
        
    } else if(section == 1){
        return 2;
    }else if(section ==2){
        
        
        
        return URLArray.count +1;
        
    } else if(section ==3){
        
        return todoArray.count +1;
    }
    
    return NO;
    
}



- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellforrow");
    UITableViewCell *cell = [planTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.section == 0){
        if([indexPath section] ==0){
            
            if([indexPath row] ==0){
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                titleField.placeholder = @"タイトルを入力してください。";
                titleField.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
                [cell addSubview:titleField];
            
            } else if([indexPath row] ==1){
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                categoryField.placeholder = @"場所を入力してください";
                categoryField.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
                [cell addSubview:categoryField];
                
            }
        }
        
        [categoryField setEnabled:YES];
        
    }
    
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"したいこと";
            cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
        } else if(indexPath.row == 1){
            
            cell.textLabel.text = @"場所";
            cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
            
            
        }
    } else if(indexPath.section == 1)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
        
        
        if(indexPath.row == 0) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"いつ？";
            cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
            
            FLAppDelegate * appDelegate;
            appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
            
  
            cell.detailTextLabel.text = appDelegate.dateString;
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
            
            
            
        } else if(indexPath.row == 1){
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            budgetField.placeholder = @"予算を入力してください";
            budgetField.font =   [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
            
            [cell addSubview:budgetField];
            budgetField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            cell.textLabel.text = @"いくら？";
            cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
            
            
        }
        
    }else if(indexPath.section == 2)
    {
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        if(URLArray.count == 0){
            
            cell.textLabel.text = @"リンクを保存する :";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
            
        }else{
            
            //最後のセルに「リンクをふやす」ボタンの機能をもたせる
            if(indexPath.row == URLArray.count){
                cell.textLabel.text = @"リンクをふやす:";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
                
            } else {
                
                cell.textLabel.text = [URLArray objectAtIndex:indexPath.row];
                cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
            }
            
        }
        
    }else if(indexPath.section == 3){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        if(todoArray.count == 0){
            
            cell.textLabel.text = @"To Doを保存する:";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
            
            
        } else {
            
            
            if(indexPath.row == todoArray.count){
                
                cell.textLabel.text = @"To Doをふやす:";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
                
                
            } else {
                
                cell.textLabel.text = [todoArray objectAtIndex:indexPath.row];
                cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
            }
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    
    [self.categoryField resignFirstResponder];
    [self.titleField resignFirstResponder];
    [self.dateField resignFirstResponder];
    [self.budgetField resignFirstResponder];
    [self.titleField endEditing:YES];
    
    
    
    if(indexPath.section == 1){
        
        if(indexPath.row == 0){
            
            //他のフィールドに対応するキーボードをひっこめる
            [titleField resignFirstResponder];
            [categoryField resignFirstResponder];
            [budgetField resignFirstResponder];
            
            FLAppDelegate * appDelegate;
            appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
            appDelegate.categoryString = categoryField.text;
            appDelegate.titleString = titleField.text;
            appDelegate.dateString = dateField.text;
            appDelegate.budgetString = budgetField.text;
            
            FLDateViewController * DVC = [[FLDateViewController alloc]init];
            [self.navigationController pushViewController:DVC animated:YES];
        }
        
        
    }
    
    
    if(indexPath.section == 2){
        
        
        if(URLArray.count == 0)
        {
            if(indexPath.row == 0){
                
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                FLAppDelegate * appDelegate;
                appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
                appDelegate.categoryString = categoryField.text;
                appDelegate.titleString = titleField.text;
                appDelegate.dateString = dateField.text;
                appDelegate.budgetString = budgetField.text;
                
                FLAddurlViewController * AUVC = [[FLAddurlViewController alloc]init];
                [self.navigationController pushViewController:AUVC  animated:NO];
            }
        } else {
            
            if(indexPath.row == URLArray.count){
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                FLAppDelegate * appDelegate;
                appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
                
                
                appDelegate.categoryString = categoryField.text;
                appDelegate.titleString = titleField.text;
                appDelegate.dateString = dateField.text;
                appDelegate.budgetString = budgetField.text;
                
                FLAddurlViewController * AUVC = [[FLAddurlViewController alloc]init];
                [self.navigationController pushViewController:AUVC  animated:NO];
                
            }
            
        }
    }
    
    
    if(indexPath.section ==3){
        
        if(todoArray.count == 0)
        {
            if(indexPath.row == 0){
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                FLAppDelegate * appDelegate;
                appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
                appDelegate.categoryString = categoryField.text;
                appDelegate.titleString = titleField.text;
                appDelegate.dateString = dateField.text;
                appDelegate.budgetString = budgetField.text;
                
                FLAddtodoViewController * ATVC = [[FLAddtodoViewController alloc]init];
                [self.navigationController pushViewController:ATVC animated:YES];
                
            } else{
                
                if(indexPath.row == todoArray.count){
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                    FLAppDelegate * appDelegate;
                    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
                    appDelegate.categoryString = categoryField.text;
                    appDelegate.titleString = titleField.text;
                    appDelegate.dateString = dateField.text;
                    appDelegate.budgetString = budgetField.text;
                    
                    
                    FLAddtodoViewController * ATVC = [[FLAddtodoViewController alloc]init];
                    [self.navigationController pushViewController:ATVC animated:YES];
 
                    
                }
            }
            
            
        }else {
            
            
            if(indexPath.row == todoArray.count){
                
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 
                FLAddtodoViewController * ATVC = [[FLAddtodoViewController alloc]init];
                [self.navigationController pushViewController:ATVC animated:YES];
            
            }
            
        }
        
    }
    
}


-(IBAction)closeClicked:(id)sender{
    
    //appdelegateのすべての値を初期化してtopへ
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.categoryString = [[NSString alloc]init];
    appDelegate.titleString = [[NSString alloc]init];
    appDelegate.dateString =[[NSString alloc]init];
    appDelegate.budgetString = [[NSString alloc]init];
    appDelegate.appurlArray = [[NSMutableArray alloc]init];
    appDelegate.apptodoArray = [[NSMutableArray alloc]init];
    
    [self.titleField resignFirstResponder];
    [self.dateField resignFirstResponder];
    [self.budgetField resignFirstResponder];
    [self.categoryField resignFirstResponder];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}



- (IBAction)seeClicked:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.categoryString = categoryField.text;
    appDelegate.titleString = titleField.text;
    appDelegate.dateString = dateField.text;
    appDelegate.budgetString = budgetField.text;
    appDelegate.appurlArray = URLArray;
    appDelegate.apptodoArray = todoArray;
    
    
    FLPlanViewController * PVC = [[FLPlanViewController alloc]init];
    PVC.categoryString = categoryField.text;
    PVC.titleString = titleField.text;
    PVC.dateString = dateField.text;
    PVC.budgetString = budgetField.text;
    
    [self.navigationController pushViewController:PVC animated:YES];
    
    [self.titleField resignFirstResponder];
    [self.dateField resignFirstResponder];
    [self.budgetField resignFirstResponder];
    [self.categoryField resignFirstResponder];
}





-(void)resignResponder:(id)sender{
    
    [titleField resignFirstResponder];
    [self.titleField resignFirstResponder];
    [self.dateField resignFirstResponder];
    [self.budgetField resignFirstResponder];
    [self.categoryField resignFirstResponder];
    
    
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ((indexPath.section==0)|| (indexPath.section == 1) ){
        return UITableViewCellEditingStyleNone;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}



-(void)tableView:(UITableView*)tableView
commitEditingStyle:(UITableViewCellEditingStyle) editingStyle
forRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    
    
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        if(indexPath.section == 0){
        }
        
        if(indexPath.section == 2){
            
            [URLArray removeObjectAtIndex:[indexPath row]];
            NSString * urltoPost = [[NSString alloc]init];
            urltoPost = [appDelegate.appurlidArray objectAtIndex:indexPath.row];
            int toPost = [urltoPost intValue];
            [self postUrlIdtoDelete:toPost];
            
        } else {
          
            [todoArray removeObjectAtIndex:[indexPath row]];
            NSString * todotoPost = [[NSString alloc]init];
            todotoPost =   [appDelegate.apptodoidArray objectAtIndex:indexPath.row];
            int toPost =  [todotoPost intValue];
            [self postTodoidToDelete:toPost];
            
        }
        
    }
    
}

-(void)postUrlIdtoDelete:(int)toPost{
    
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/urldelete.php"];
    NSString * data = [NSString stringWithFormat:@"urlid=%d", toPost];
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        //通信成功
        
        
        
    }else{
        //通信失敗
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
        [notice show];    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    
    [planTable reloadData];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSLog(@"beginediting");
    CGRect newFrame = self.view.frame;
    newFrame.size = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+50);
    self.view.frame = newFrame;
}

-(void)postTodoidToDelete:(int)toPost{
    
    
    
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/tododelete.php"];
    NSString * data = [NSString stringWithFormat:@"todoid=%d", toPost];
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        //通信成功
        
    }else{
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
        [notice show];    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
      
    [planTable reloadData];
    
}


@end
