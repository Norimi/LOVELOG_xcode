//
//  PlanViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLPlanViewController.h"
#import "FLAppDelegate.h"
#import "FLOldplansViewController.h"
#import "WebViewController.h"
#import "FLChatViewController.h"
#import "WebViewController.h"
#import "FLConnection.h"


typedef NS_ENUM(NSInteger, FLEditingStyle) {
    FLEditingStyleNone = 0,
    FLEditingStyleYes
};

@interface FLPlanViewController ()
@property(strong, nonatomic)NSMutableArray * planurlArray;
@property(strong, nonatomic)NSMutableArray * plantodoArray;
@property(assign, readwrite)BOOL  EDIT;
@property(strong, nonatomic)NSString * url;
@property(strong, nonatomic)NSString * plantoSend;
@end

@implementation FLPlanViewController


static const int CELL_NUMBER_FOR_FIRST_PART = 2;
static const int CELL_NUMBER_FOR_SECOND_PART = 2;
static const int FONT_SIZE_FOR_TITLE = 14;
static const int FONT_SIZE_FOR_SUBTITLE = 10;



@synthesize planTable, planurlArray, plantodoArray, categoryString, titleString, dateString, budgetString,scrollView, EDIT, plantoSend,url;



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
    
    planTable.delegate = self;
    planTable.dataSource = self;
    [self addNavbarComponents];
    
    [self->scrollView setContentSize:CGSizeMake(320, 518)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)addNavbarComponents{
    
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"送信"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(sendClicked:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    self.title=@"確認して送信";

}


-(void)viewDidAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



-(void)viewWillAppear:(BOOL)animated
{
    
    
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];  planurlArray = appDelegate.appurlArray;
    plantodoArray = appDelegate.apptodoArray;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    
    return 4;
}


-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return CELL_NUMBER_FOR_FIRST_PART;
        
    } else if(section == 1){
        
        return CELL_NUMBER_FOR_SECOND_PART;
        
        
    }else if(section ==2){
        
        return planurlArray.count;
        
    } else if(section ==3){
        
        return plantodoArray.count;
    }
    
    return NO;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [planTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:FONT_SIZE_FOR_TITLE];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:FONT_SIZE_FOR_SUBTITLE];
    
    
    if(indexPath.section == 0) {
        
        if(indexPath.row == 0) {
            
            cell.textLabel.text = titleString;
            cell.detailTextLabel.text = @"タイトル";
            
        } else if(indexPath.row == 1){
            
            cell.textLabel.text = categoryString;
            cell.detailTextLabel.text = @"場所";
            
        }
    } else if(indexPath.section == 1)
    {
        
        if(indexPath.row == 0) {
            cell.textLabel.text = dateString;
            cell.detailTextLabel.text = @"日程";
            
        } else if(indexPath.row == 1){
            cell.textLabel.text = budgetString;
            cell.detailTextLabel.text = @"予算";
            
        }
        
    }else if(indexPath.section == 2)
    {
        
        cell.detailTextLabel.text = @"リンク";
        
        url = [[NSString alloc]init];
        url = [planurlArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = url;
        
    }else if(indexPath.section == 3) {
        
        cell.textLabel.text = [plantodoArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"To Do";
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.section == 2){
        
        NSString * checkString = [planurlArray objectAtIndex:indexPath.row];
        NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [linkDetector matchesInString:checkString options:0 range:NSMakeRange(0, [checkString length])];
        
        //リンクが含まれていた場合、クリックしたらwebviewへ
        for(NSTextCheckingResult * match in matches){
            if([match resultType] == NSTextCheckingTypeLink){
                NSURL * nsurl = [match URL];
                WebViewController * WVC = [[WebViewController alloc]init];
                WVC.url = nsurl;
                [[self navigationController]pushViewController:WVC animated:NO];
                
            }
        }
        
    }
    
    
    
    if(indexPath.section == 3){
        //選択されたセルを取得
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //セルにチェックが付いている場合はチェックを外し、付いていない場合はチェックを付ける
        if(indexPath.section == 3){
            
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
            {
                cell
                .accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//TODO:ここのメソッド切り分ける
-(IBAction)sendClicked:(id)sender{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //bool edit yesornoでphpfileを分ける
    //yesのとき,oldplansからplanidを渡しておくこと。
    NSUserDefaults * defautls = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defautls integerForKey:@"mid"];
    //AppDelegateに変更した値を全て持たせている
    //それをクラスにすること
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication  sharedApplication]delegate];
    NSMutableData * body = [NSMutableData data];
    
    //FLConnectionに渡す値の条件分岐
    if(appDelegate.EDIT == FLEditingStyleYes){
        
        url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/planviewcontrolleredit.php"];
        FLAppDelegate * appDelegate;
        appDelegate = (FLAppDelegate*)[[UIApplication  sharedApplication]delegate];
        NSString * planidPost = appDelegate.planidtoSend;
        [body appendData:[[NSString stringWithFormat:@"userid=%d&category=%@&title=%@&date=%@&budget=%@&planid=%@", idnumber,categoryString, titleString, dateString,budgetString, planidPost]dataUsingEncoding:NSUTF8StringEncoding]];
        
    
    } else {
        
        
        url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/planviewcontroller.php"];
        [body appendData:[[NSString stringWithFormat:@"userid=%d&category=%@&title=%@&date=%@&budget=%@", idnumber,categoryString, titleString, dateString, budgetString]dataUsingEncoding:NSUTF8StringEncoding]];

    }
    
    
    
    //editの場合、増えた分だけをカウントしてpostする。
    //TODO:減っていた場合の処置？
    int urls =[appDelegate.arrayNumber intValue];
    
    for(int i=urls; i<planurlArray.count; ++i){
        //ひとつずつ取り出す
        NSString * eachurl = [[NSString alloc]init];
        eachurl = [planurlArray objectAtIndex:i];
        
        //bodyにひとつずつappend
        [body appendData:[[NSString stringWithFormat:@"&url[]=%@", eachurl] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    int todos =[appDelegate.todoNumber intValue];
    
    //TODOSが０の場合はminusを0に設定しなくてはいけないので
    for(int i=todos; i<plantodoArray.count; ++i){
        
        NSString * eachtodo = [[NSString alloc]init];
        eachtodo = [plantodoArray objectAtIndex:i];
        [body appendData:[[NSString stringWithFormat:@"&todo[]=%@", eachtodo] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withNSData:body])
    {
        //送信成功
        //appdelegateの値をリセット
        appDelegate = (FLAppDelegate*)[[UIApplication  sharedApplication]delegate];
        appDelegate.categoryString = nil;
        appDelegate.titleString = nil;
        appDelegate.budgetString = nil;
        appDelegate.dateString = nil;
        appDelegate.appurlArray = nil;
        appDelegate.apptodoArray = nil;
        appDelegate.planidtoSend = nil;
        
        //arrayを初期化して次回使えるようにする。
        appDelegate.appurlArray = [[NSMutableArray alloc]init];
        appDelegate.apptodoArray = [[NSMutableArray alloc]init];
        appDelegate.categoryString = [[NSString alloc]init];
        appDelegate.budgetString = [[NSString alloc]init];
        appDelegate.dateString = [[NSString alloc]init];
        appDelegate.titleString = [[NSString alloc]init];
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        //edit終了
        appDelegate.EDIT = NO;
        
    }else{
        
        //送信失敗:値はそのままにしてこの画面にとどまる
        WBErrorNoticeView * notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}


- (void)viewDidUnload {
    planTable = nil;
    scrollView = nil;
    [self setScrollView:nil];
    [super viewDidUnload];
    
}
@end
