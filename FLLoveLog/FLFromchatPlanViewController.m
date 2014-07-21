//
//  FromchatPlanViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/06/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLFromchatPlanViewController.h"
#import "WebViewController.h"
#import "FLAppdelegate.h"
#import"FLPlanmakeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FLConnection.h"

@interface FLFromchatPlanViewController ()
@property(strong, nonatomic)NSMutableArray * todoidArray;
@property(strong, nonatomic)NSMutableArray * urlidArray;
@property(strong, nonatomic)NSMutableArray * contentsArray;
@property(strong, nonatomic)NSMutableData * receivedData;
@property(strong, nonatomic)NSMutableArray * urlArray;
@property(strong, nonatomic)NSMutableArray * todoArray;
@property(strong,nonatomic)NSMutableArray * boolArray;
@property(strong, nonatomic)NSString * nowTagStr;
@property(strong, nonatomic)NSString * titleString;
@property(strong, nonatomic)NSString * dateString;
@property(strong, nonatomic)NSString * budgetString;
@property(strong, nonatomic)NSString * nameString;
@property(strong, nonatomic)NSString * createdString;
@property(strong, nonatomic)NSString * urlString;
@property(strong, nonatomic)NSString * todoString;
@property(strong, nonatomic)NSString * checked;
@property(strong, nonatomic)NSMutableDictionary * todoDict;

@property BOOL inName;
@property BOOL inCategory;
@property BOOL inTitle;
@property BOOL inDate;
@property BOOL inBudget;
@property BOOL inCreated;
@property BOOL inPlanid;
@property BOOL inURL;
@property BOOL inTODO;
@property BOOL inTODOID;
@property BOOL inChecked;
@property BOOL inURLID;




@end

@implementation FLFromchatPlanViewController

@synthesize fromchatTable, urlArray, nowTagStr,  titleString, budgetString, dateString, planid, nameString, createdString, receivedData, todoArray, urlString, todoString, contentsArray, todoidArray,checked, todoDict, urlidArray,inName,inCategory,inTitle,inDate,inBudget,inCreated,inPlanid,inURL,inTODO,inTODOID,inChecked,inURLID,boolArray;

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
    
    fromchatTable.delegate = self;
    fromchatTable.dataSource = self;
    
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"編集"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(editClicked:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    
    
    CALayer * layer = [fromchatTable layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:0.0]; //note that when radius is 0, the border is a rectangle
    [layer setBorderWidth:0.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    fromchatTable = nil;
    [self setFromchatTable:nil];
    [super viewDidUnload];
   
    
}



-(void)viewWillAppear:(BOOL)animated{
    contentsArray = nil;
    [self postPlanid];
}


-(void)postPlanid{
    
    contentsArray = nil;
    NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/planid.php"];
    int pid = [planid intValue];
    NSString * data = [NSString
                       stringWithFormat:@"planid=%d", pid];
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        
        
        NSURL * newURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/fromchatviewcontroller.php"];
        NSURLRequest * req = [NSURLRequest requestWithURL:newURL];
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:req delegate:self];
        
        if(connection)
        {
            
            receivedData = [NSMutableData data];
            
        }

        
    }else{
        
       notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
  
    }
}


-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    if(contentsArray == nil){
        contentsArray = [[NSMutableArray alloc]init];
        
    }
    
    NSXMLParser * newParser = [[NSXMLParser alloc]initWithData:receivedData];
    [newParser setDelegate:self];
    [newParser parse];
    
    receivedData = nil;
    connection = nil;
    
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
          
          [self initPropertiesForParser];
      }
    
    if([elementName isEqualToString:@"name"]){
        
        inName  = YES;
        
    }
    
    if([elementName isEqualToString:@"category"]){
        
        inCategory = YES;
    }
    
    if([elementName isEqualToString:@"title"]){
        
        inTitle = YES;
    }
    
    if([elementName isEqualToString:@"date"]){
        
        inDate = YES;
        
    }
    
    if([elementName isEqualToString:@"budget"]){
        
        
        inBudget = YES;
    }
    
    if([elementName isEqualToString:@"created"]){
        
        
        inCreated = YES;
    }
    
    if([elementName isEqualToString:@"planid"]){
        
        inPlanid = YES;
        
    }
    if([elementName isEqualToString:@"url"]){
        
            
        inURL = YES;
    }
    
    if([elementName isEqualToString:@"urlid"]){
        
        
        inURLID = YES;
        
        
    }
    
    
    if([elementName isEqualToString:@"todo"]){
        
        inTODO = YES;
        
    }
    
    if([elementName isEqualToString:@"todoid"]){
        
        inTODOID = YES;
        
    }
    
    if([elementName isEqualToString:@"checked"]){
        
        inChecked = YES;
    }
    
}

-(void)initPropertiesForParser{
    
    
    checked = [[NSString alloc]init];
    nowTagStr = [[NSString alloc]init];
    titleString = [[NSString alloc]init];
    budgetString = [[NSString alloc]init];
    dateString = [[NSString alloc]init];
    createdString = [[NSString alloc]init];
    planid = [[NSString alloc]init];
    todoidArray = [[NSMutableArray alloc]init];
    urlidArray = [[NSMutableArray alloc]init];
    boolArray = [[NSMutableArray alloc]init];
    urlString = [[NSString alloc]init];
    todoString = [[NSString alloc]init];
    urlArray = [[NSMutableArray alloc]init];
    todoArray = [[NSMutableArray alloc]init];
    checked = [[NSString alloc]init];
    todoDict = [[NSMutableDictionary alloc]init];
    
    
    inName = NO;
    inCategory = NO;
    inTitle = NO;
    inBudget = NO;
    inDate = NO;
    inCreated = NO;
    inPlanid = NO;
    inURL = NO;
    inTODO =NO;
    inTODOID =NO;
    inURLID = NO;
    inChecked = NO;
    
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString *)string{
    
    
    if(inName){
        
        nameString = [nameString stringByAppendingString:string];
        
    }
    
    if(inCategory){
        
    }
    if(inTitle){
        
        titleString = [titleString stringByAppendingString:string];
        
    }
    if(inDate){
        
        dateString = [dateString stringByAppendingString:string];
        
        
    }
    if(inBudget){
        
        budgetString = [budgetString stringByAppendingString:string];
        
    }
    
    if(inCreated){
        
        createdString = [createdString stringByAppendingString:string];
    }
    
    
    if(inPlanid){
        
        planid = [planid stringByAppendingString:string];
        
    }
    
    if(inURL){
        
        if (![urlArray containsObject:string])[urlArray addObject:string];
        
        
    }
    
    if(inURLID){
        
        
        if(![urlidArray containsObject:string])[urlidArray addObject:string];
        
    }
    
    if(inTODO){
        
        
        if (![todoArray containsObject:string])[todoArray addObject:string];
        
    }
    
    if(inTODOID){
        
        
        if(![todoidArray containsObject:string])[todoidArray addObject:string];
        
    }
    
    if(inChecked){
        
        checked = [checked stringByAppendingString:string];
        
        [boolArray addObject:string];
    }
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"content"] ) {
        
        
        [contentsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys: titleString, @"title", dateString, @"date", budgetString, @"budget", planid, @"planid", urlArray, @"urlarray",urlidArray, @"urlidArray", todoArray, @"todoarray",todoidArray, @"todoidarray", checked, @"bool", nil]];
    
    }
    
    if([elementName isEqualToString:@"name"]){
        
        inName = NO;
        
    }
    
    if([elementName isEqualToString:@"category"]){
        
        
        inCategory = NO;
    }
    
    if([elementName isEqualToString:@"title"]){
        
        inTitle = NO;
    }
    

    if([elementName isEqualToString:@"date"]){
        
        inDate = NO;
    }
    
    
    if([elementName isEqualToString:@"budget"]){
        
        inBudget = NO;
        
    }
    
    
    if([elementName isEqualToString:@"created"]){
        
        
        inCreated = NO;
        
    }
    if([elementName isEqualToString:@"planid"]){
        
        inPlanid = NO;
        
    }
    
    
    
    if([elementName isEqualToString:@"url"]){
        
        inURL = NO;
        
    }
    
    if([elementName isEqualToString:@"urlid"]){
        
        
        inURLID = NO;
        
    }
    
    if([elementName isEqualToString:@"todo"]){
        
        inTODO = NO;
        
        
    }
    
    if([elementName isEqualToString:@"todoid"]){
        
        inTODOID = NO;
        
    }
    
    if([elementName isEqualToString:@"checked"]){
        
        inChecked = NO;
    }
    
    
}


-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
        
        return urlArray.count;
        
    } else if(section ==3){
        
        return todoArray.count;
    }
    
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [fromchatTable dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor whiteColor];
        
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
    }
    
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:10];
    
    
    if(indexPath.section == 0) {
        
        if(indexPath.row == 0) {
            
            cell.textLabel.text = titleString;
            cell.detailTextLabel.text = @"タイトル";
            
        } else if(indexPath.row == 1){
            
            
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
        
        for(int i=0; i<urlArray.count; ++i){
            
            cell.textLabel.text = [urlArray objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = @"リンク";
        
        }
        
        
    } else if(indexPath.section == 3) {
        
        cell.textLabel.text = [todoArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"To Do";
        
        for(int i=0; i<boolArray.count; ++i){
            if(0< [[boolArray objectAtIndex:indexPath.row] intValue ])
            {
                //セルにチェック
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
            }
        }
    }
    return cell;
}



-(void)parserDidEndDocument:(NSXMLParser*)parser
{
    
    [fromchatTable reloadData];
    if(contentsArray.count == 0){
        
        //プランがないときにエラーを知らせる
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"プランがありません。" message:@"このプランは削除されています。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }
    
}



- (void)connection:(NSURLConnection *)connection
didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.section == 2){
        NSString * checkString = [urlArray objectAtIndex:indexPath.row];
        NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [linkDetector matchesInString:checkString options:0 range:NSMakeRange(0, [checkString length])];
        
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
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            FLConnection * connection = [[FLConnection alloc]init];
            cell.accessoryType = UITableViewCellAccessoryNone;
            NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/todocheck.php"];
            
            int tmptodoid;
            
            //文字列を数値に変換
            tmptodoid =  [[todoidArray objectAtIndex:indexPath.row] intValue];
            int todoid = tmptodoid;
            NSString * data = [NSString stringWithFormat:@"unchecked=%d", todoid];
            if([connection connectionWithUrl:url withData:data]){
                
            }else{
                notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
                [notice show];
               
            }
            
            
        }else{
        
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/todocheck.php"];
            int todoid;
            todoid =  [[todoidArray objectAtIndex:indexPath.row] intValue];
            NSString * data = [NSString stringWithFormat:@"checked=%d", todoid];
            FLConnection * connection = [[FLConnection alloc]init];
            if([connection connectionWithUrl:url withData:data]){
                
            }else{
                
                notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
                [notice show];

            }
            
            
        }
        //通信の失敗、成功に関わらずぐるぐるを消去
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    appDelegate.apptodoArray = [[NSMutableArray alloc]init];
    appDelegate.appurlidArray = [[NSMutableArray alloc]init];
    appDelegate.apptodoidArray = [[NSMutableArray alloc]init];

    appDelegate.titleString = titleString;
    appDelegate.budgetString = budgetString;
    appDelegate.dateString = dateString;
    appDelegate.appurlArray = urlArray;
    appDelegate.apptodoArray = todoArray;
    appDelegate.apptodoidArray = todoidArray;
    appDelegate.appurlidArray = urlidArray;
    appDelegate.planidtoSend = planid;
    
    //arrayの数を取得し、appdelegateの保存。後に増加分と比べる。
    int urls;
    int todos;
    
    urls = urlArray.count;
    todos = todoArray.count;
    
    //stringに戻してappdelegateに保存;
    appDelegate.arrayNumber = [NSString stringWithFormat:@"%d", urls];
    appDelegate.todoNumber = [NSString stringWithFormat:@"%d", todos];
    FLPlanmakeViewController * PVC = [[FLPlanmakeViewController alloc]init];
    appDelegate.EDIT = YES;
    [[self navigationController]pushViewController:PVC animated:YES];
    
    
}


@end
