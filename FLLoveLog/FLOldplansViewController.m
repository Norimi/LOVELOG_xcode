//
//  OldplansViewController.m
//  PlanPrepare
//
//  Created by 立花 法美 on 2013/05/21.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLOldplansViewController.h"
#import "WebViewController.h"
#import "FLAppDelegate.h"
#import "FLPlanmakeViewController.h"
#import "FLConnection.h"


@interface FLOldplansViewController ()
@end

@implementation FLOldplansViewController

static const int NUMBER_OF_SECTIONS = 4;


@synthesize planurlArray, plantodoArray, titleString, categoryString, dateString, budgetString, planTable, oldplanid, planboolArray,passedtodoidArray,urlidArray;

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
    planTable.dataSource= self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setNavbarComponents];
    
}

-(void)setNavbarComponents{
    
    self.title=@"過去のプラン";
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"編集する"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(editClicked:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    
}





-(void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    
    return NUMBER_OF_SECTIONS;
}





-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 2;
        
    } else if(section == 1){
        
        
        return 2;
        
        
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
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:10];
    
    
    
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
        
    }else if(indexPath.section == 2) {
        
        
        for(int i=0; i<planurlArray.count; ++i){
            
            cell.textLabel.text = [planurlArray objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = @"リンク";
        
        }
        
        
    }else if(indexPath.section == 3) {
        
        for(int i=0; i<plantodoArray.count; ++i){
            
            cell.textLabel.text = [plantodoArray objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = @"To Do";
            
            for(int i=0; i<planboolArray.count; ++i){
                
                int check = [[planboolArray objectAtIndex:indexPath.row] intValue];
                if(50< check)
                {
                    //セルにチェック
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    
                }
                
            }
        }
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 2){
        
        NSString * checkString = [planurlArray objectAtIndex:indexPath.row];
        NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [linkDetector matchesInString:checkString options:0 range:NSMakeRange(0, [checkString length])];
        
        for(NSTextCheckingResult * match in matches){
            if([match resultType] == NSTextCheckingTypeLink){
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
                NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/todocheck.php"];
                int tmptodoid;
                tmptodoid =  [[passedtodoidArray objectAtIndex:indexPath.row] intValue];
                int todoid = tmptodoid;
                NSString * data = [NSString stringWithFormat:@"unchecked=%d", todoid];
                FLConnection * connection = [[FLConnection alloc]init];
                if([connection connectionWithUrl:url withData:data]){
                    //通信成功
                    
                }else{
                    //通信失敗
                    
                }
                
                
                
            }else{
                
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/todocheck.php"];
                int todoid;
                todoid =  [[passedtodoidArray objectAtIndex:indexPath.row] intValue];
                NSString * data = [NSString stringWithFormat:@"checked=%d", todoid];
                FLConnection * connection = [[FLConnection alloc]init];
                if([connection connectionWithUrl:url withData:data]){
                    //通信成功時
                    
                }else{
                    //通信失敗時
                    
                }
            }
            
            
        }
    }
    
}







-(void)editClicked:(id)sender{
    
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication  sharedApplication]delegate];
    
    
    appDelegate.categoryString = [[NSString alloc]init];
    appDelegate.titleString = [[NSString alloc]init];
    appDelegate.budgetString = [[NSString alloc]init];
    appDelegate.dateString = [[NSString alloc]init];
    
    appDelegate.appurlArray = [[NSMutableArray alloc]init];
    appDelegate.appurlidArray = [[NSMutableArray alloc]init];
    appDelegate.apptodoArray = [[NSMutableArray alloc]init];
    appDelegate.apptodoidArray = [[NSMutableArray alloc]init];
    
    appDelegate.titleString = titleString;
    appDelegate.budgetString = budgetString;
    appDelegate.dateString = dateString;
    appDelegate.categoryString = categoryString;
    appDelegate.appurlidArray = urlidArray;
    appDelegate.apptodoidArray = passedtodoidArray;
    appDelegate.appurlArray = planurlArray;
    appDelegate.apptodoArray = plantodoArray;
    
    
    //arrayの数を取得し、後に増加分と比べる。
    int urls;
    int todos;
    
    urls = planurlArray.count;
    todos = plantodoArray.count;
    
    //stringに戻してappdelegateに保存;
    appDelegate.arrayNumber = [NSString stringWithFormat:@"%d", urls];
    appDelegate.todoNumber = [NSString stringWithFormat:@"%d", todos];
    FLPlanmakeViewController * PVC = [[FLPlanmakeViewController alloc]init];
    
    
    appDelegate.EDIT = YES;
    [[self navigationController]pushViewController:PVC animated:YES];
    
    
}
@end
