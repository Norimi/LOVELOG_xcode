//
//  PlantableViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLPlantableViewController.h"
#import "FLOldplansViewController.h"
#import "FLAppDelegate.h"
#import "FLPlanmakeViewController.h"
#import "FLConnection.h"


@interface FLPlantableViewController ()
@property(strong, nonatomic)NSMutableArray * contentsArray;
@property (strong, nonatomic)NSMutableArray * tmpcontentsArray;
@property(strong, nonatomic)NSMutableData * receivedData;
@property(strong, nonatomic)NSMutableArray * urlArray;
@property(strong, nonatomic)NSMutableArray * todoArray;
@property(strong, nonatomic)NSMutableArray * todoidArray;
@property(strong, nonatomic)NSMutableArray * boolArray;
@property(strong, nonatomic)NSMutableArray * urlidArray;
@property(strong, nonatomic)NSString * nowTagStr;
@property(strong, nonatomic)NSString * categoryString;
@property(strong, nonatomic)NSString * titleString;
@property(strong, nonatomic)NSString * dateString;
@property(strong, nonatomic)NSString * budgetString;
@property(strong, nonatomic)NSString * nameString;
@property(strong, nonatomic)NSString * createdString;
@property(strong, nonatomic)NSString * planid;
@property(strong, nonatomic)NSString * urlString;
@property(strong, nonatomic)NSString * todoString;
@property(strong, nonatomic)NSString * nowdateString;
@property(strong, nonatomic)NSString * userid;
@property(strong, nonatomic)NSString * checked;
@property(strong, nonatomic,readonly)NSDate * nowDate;

@property BOOL inName;
@property BOOL inCategory;
@property BOOL inTitle;
@property BOOL inDate;
@property BOOL inBudget;
@property BOOL inCreated;
@property BOOL inPlanid;
@property BOOL inURL;
@property BOOL inTODO;
@property BOOL inChecked;
@property BOOL inTODOID;
@property BOOL inUserid;
@property BOOL inURLid;
@property BOOL reloading;
@end

@implementation FLPlantableViewController

static const int CELL_MARGIN = 80;
static const int FONT_SIZE = 15;


//インスタンス名をプロパティ名と同じにする
@synthesize planTable,urlArray, nowTagStr, categoryString, titleString, budgetString, dateString, planid, nameString, createdString, receivedData, todoArray, todoidArray,todoString,urlString,contentsArray,boolArray,urlidArray,nowdateString,nowDate,inName,inCategory,inTitle,inDate,inBudget,inCreated,inPlanid,inURL,inTODO,inChecked,inTODOID,inUserid,inURLid,userid,checked,tmpcontentsArray;



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
    
    planTable.dataSource = self;
    planTable.delegate = self;
    
    [self setBarButtonItems];
    [self setContentsArrayFromUserDefaults];
    
    
    //refreshheaderviewの取り付け
    if(refreshHedaerView == nil){
        
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f,0.0f-self.planTable.bounds.size.height, self.view.frame.size.width, self.planTable.bounds.size.height) ];
        view.delegate = self;
        [self.planTable addSubview:view];
        refreshHedaerView = view;
    }
}

-(void)setBarButtonItems{
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refreshFromBarButton:)];
    self.navigationItem.leftBarButtonItem = button;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem * bbi2 = [[UIBarButtonItem alloc]initWithTitle:@"プランを作る"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(toMake:)];
    [[self navigationItem]setRightBarButtonItem:bbi2];

    
}

-(void)setContentsArrayFromUserDefaults{
    
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [self setContentsArray:[defaults objectForKey:@"plancontents"]];
 
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [refreshHedaerView egoRefreshScrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate{
    
    [refreshHedaerView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    _reloading = YES;
    contentsArray = nil;
    [self postIds];
    [self doneLoadingTableViewData];
    
    
    
}

- (void)doneLoadingTableViewData{
    
    [refreshHedaerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.planTable];
    _reloading = NO;
}



-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView * )view{
    
    return _reloading;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.planTable reloadData];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    nowDate = [NSDate date];
    
}


-(void)refreshFromBarButton:(id)sender{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postIds];
}


-(void)postIds{
    
    
    contentsArray = nil;
    
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/postid.php"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSInteger pidnumber = [defaults integerForKey:@"pid"];
    NSString * data = [NSString
     stringWithFormat:@"userid=%d&partnerid=%d", idnumber, pidnumber];
    
    FLConnection * connection = [[FLConnection alloc]init];
    
    if([connection connectionWithUrl:url  withData:data]){
        
        NSURL * newURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/plantableviewcontroller3.php"];
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


-(void)initVariablesForParse{
    
    //parserが最初に戻るたびに呼び出されて初期化する
    nowTagStr = [[NSString alloc]init];
    categoryString = [[NSString alloc]init];
    titleString = [[NSString alloc]init];
    budgetString = [[NSString alloc]init];
    dateString = [[NSString alloc]init];
    createdString = [[NSString alloc]init];
    planid = [[NSString alloc]init];
    
    urlString = [[NSString alloc]init];
    todoString = [[NSString alloc]init];
    
    
    urlArray = [[NSMutableArray alloc]init];
    todoArray = [[NSMutableArray alloc]init];
    boolArray = [[NSMutableArray alloc]init];
    todoidArray = [[NSMutableArray alloc]init];
    
    checked = [[NSString alloc]init];
    userid = [[NSString alloc]init];
    urlidArray = [[NSMutableArray alloc]init];
    
    
    
    inName = NO;
    inCategory = NO;
    inTitle = NO;
    inBudget = NO;
    inDate = NO;
    inCreated = NO;
    inPlanid = NO;
    inURLid =NO;
    inURL = NO;
    inTODO =NO;
    inChecked = NO;
    inTODOID = NO;
    inUserid = NO;
    
}


-(void)parser:(NSXMLParser*)parser
didStartElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
   attributes:(NSDictionary*)attributeDict{
    
    
    if([elementName isEqualToString:@"content"]){
        
        [self initVariablesForParse];
        
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
    
    if([elementName isEqualToString:@"userid"]){
        
        
        inUserid = YES;
        
    }
    
    if([elementName isEqualToString:@"url"]){
        
        
        
        inURL = YES;
    }
    
    if([elementName isEqualToString:@"urlid"]){
        
        
        inURLid = YES;
        
    }
    
    
    if([elementName isEqualToString:@"todo"]){
        
        inTODO = YES;
        
    }
    
    
    if([elementName isEqualToString:@"todoid"]){
        
        inTODOID =YES;
        
        
    }
    
    if([elementName isEqualToString:@"checked"]){
        
        inChecked = YES;
        
    }
    
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString *)string{
    
    
    if(inName){
        
        //書き込みにはプロパティを介してアクセス（メモリ管理属性を参照できる）
        self.nameString = string;
    }
    
    if(inCategory){
        
        self.categoryString = string;
        
    }
    if(inTitle){
        
        self.titleString = string;
        
    }
    if(inDate){
        
        self.dateString = string;
    }
    if(inBudget){
        
        
        self.budgetString = string;
        
    }
    
    if(inCreated){
        
        self.createdString = string;
    }
    
    
    if(inPlanid){
        
        self.planid = string;
    }
    
    
    if(inUserid){
        
        self.userid = string;
        
    }
    
    if(inURL){
        
        [self.urlArray addObject:string];
    }
    
    
    if(inURLid){
        
        [self.urlidArray addObject:string];
    }
    
    if(inTODO){
        
        [self.todoArray addObject:string];
        
    }
    
    if(inTODOID){
        
        [self.todoidArray addObject:string];
        
    }
    
    if(inChecked){
        
        [self.boolArray addObject:string];
    }
    
}



- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"content"] ) {
        
       
        [contentsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:categoryString, @"category", titleString, @"title", dateString, @"date", budgetString, @"budget", createdString, @"created", planid, @"planid",userid, @"userid", urlArray, @"urlarray", urlidArray, @"urlidarray",todoArray, @"todoarray", todoidArray, @"todoid",boolArray, @"checked",nil]];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:contentsArray forKey:@"plancontents"];
        
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
    
    if([elementName isEqualToString:@"userid"]){
        
        inUserid = NO;
        
    }
    
    
    
    if([elementName isEqualToString:@"url"]){
        
        inURL = NO;
        
    }
    
    if([elementName isEqualToString:@"urlid"]){
        
        inURLid = NO;
        
    }
    
    if([elementName isEqualToString:@"todo"]){
        
        inTODO = NO;
        
    }
    
    if([elementName isEqualToString:@"todoid"]){
        
        inTODOID =NO;
        
        
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



-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section{
    
    return contentsArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [planTable dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    
    
    //useridを取得して比べ、自分のものと同じだったらセルをグリーンにする。
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:FONT_SIZE];
    
    cell.textLabel.text = [itemAtIndex objectForKey:@"title"];
    cell.detailTextLabel.text = [itemAtIndex objectForKey:@"date"];
    cell.textLabel.font = font;
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:FONT_SIZE];
    
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    _reloading = NO;
    
    return cell;
}




-(void)parserDidEndDocument:(NSXMLParser*)parser
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    tmpcontentsArray = [defaults objectForKey:@"plancontentsarray"];
    [refreshHedaerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.planTable];
    
    

    if(contentsArray.count > tmpcontentsArray.count){
        [planTable reloadData];
        
    }
    
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSString * tmpId = [itemAtIndex objectForKey:@"userid"];
    NSString * plandate = [itemAtIndex objectForKey:@"date"];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSDate * dateFromString = [[NSDate alloc]init];
    dateFromString = [dateFormatter dateFromString:plandate];
    
    NSComparisonResult result = [nowDate compare:dateFromString];
    int gotId = [tmpId intValue];
   
    if(result == NSOrderedAscending){
        
        int index =  indexPath.row;
        //最新になるはず？
        NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:index];
        NSString * plantoTop = [[NSString alloc]init];
        plantoTop = [itemAtIndex objectForKey:@"title"];
        [defaults setObject:plantoTop forKey:@"plantotop"];

        
        
        if(idnumber == gotId){
            //自分が提案したプラン
            [cell setBackgroundColor:[UIColor colorWithRed:0.90 green:0.98 blue:0.76 alpha:0.76]];
        }　else {
            //パートナーが提案したプラン
            [cell setBackgroundColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.98 alpha:0.76]];
            
        }
        
        
    } else if(result == NSOrderedDescending){
        //その上で、日付を超えていたらグレイにする
        //＋一個をtoppageに記載する。いちばん上のindex＋１をdefaultsで送る
        [cell setBackgroundColor:[UIColor colorWithRed:0.99 green:0.75 blue:0.76 alpha:1.0]];
        
    }  else {
        //それ以外:今がそのときの場合
        if(idnumber == gotId){
            //自分が提案したプラン
            [cell setBackgroundColor:[UIColor colorWithRed:0.90 green:0.98 blue:0.76 alpha:0.76]];
        }else{
            //パートナーが提案したプラン
            [cell setBackgroundColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.98 alpha:0.76]];
            
        }

    }
    
}



- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}





-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLOldplansViewController * OVC = [[FLOldplansViewController alloc]init];
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    
    FLAppDelegate * appDelegate;
    appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.planidtoSend = [itemAtIndex objectForKey:@"planid"];
    OVC.categoryString = [itemAtIndex objectForKey:@"category"];
    OVC.titleString = [itemAtIndex objectForKey:@"title"];
    OVC.budgetString = [itemAtIndex objectForKey:@"budget"];
    OVC.dateString = [itemAtIndex objectForKey:@"date"];
    OVC.urlidArray = [itemAtIndex objectForKey:@"urlidarray"];
    OVC.passedtodoidArray = [itemAtIndex objectForKey:@"todoid"];
    OVC.planurlArray = [itemAtIndex objectForKey:@"urlarray"];
    OVC.plantodoArray = [itemAtIndex objectForKey:@"todoarray"];
    OVC.planboolArray = [itemAtIndex objectForKey:@"checked"];
    [self.navigationController pushViewController:OVC animated:YES];
    
}



-(void)tableView:(UITableView*)tableView
commitEditingStyle:(UITableViewCellEditingStyle) editingStyle
forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/plandelete.php"];
        NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
        [contentsArray removeObjectAtIndex:[indexPath row]];
        NSString * plantoDelete = [itemAtIndex objectForKey:@"planid"];
        int plantoPost = [plantoDelete intValue];
        NSString * data = [NSString stringWithFormat:@"planid=%d", plantoPost];
        FLConnection * connection = [[FLConnection alloc]init];
        if([connection connectionWithUrl:url withData:data]){
            
             [planTable reloadData];
            
        }else{
            
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight;
    
    UITableViewCell *cell = [self tableView:tableView
                      cellForRowAtIndexPath:indexPath];
    CGSize size = [cell.textLabel.text sizeWithFont:cell.textLabel.font
                                  constrainedToSize:tableView.frame.size
                                      lineBreakMode:NSLineBreakByCharWrapping];
    
    cellHeight = size.height + CELL_MARGIN;
    return cellHeight;
}



-(void)toMake:(id)sender{
    
    FLPlanmakeViewController * PVC = [[FLPlanmakeViewController alloc]init];
    [[self navigationController]pushViewController:PVC animated:YES];
    
}

@end
