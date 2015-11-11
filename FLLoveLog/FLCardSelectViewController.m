//
//  CardSelectViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/04/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLCardSelectViewController.h"
#import "FLSelectedCardViewController.h"
#import "FLAppDelegate.h"
#import "FLCardViewController.h"
#import "FLConnection.h"

@interface FLCardSelectViewController ()
@property(strong, nonatomic)NSMutableArray * contentsArray;
@property(strong, nonatomic)NSString * nowTagStr;
@property(nonatomic, strong)NSString * cardTitle;
@property(strong, nonatomic)NSString * cardMessage;
@property(strong, nonatomic)NSString * cardName;
@property(strong, nonatomic)NSMutableData * receivedData;
@property(strong,nonatomic)NSString * userid;
@property Boolean inTitle;
@property Boolean inMessage;
@property Boolean inCardname;
@property Boolean inUserid;


@end

@implementation FLCardSelectViewController
@synthesize dateTable, cardTitle, cardMessage, cardName, nowTagStr, contentsArray, receivedData,userid,inTitle,inMessage,inCardname,inUserid;


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
    [self.dateTable.backgroundView  setContentMode:UIViewContentModeScaleAspectFill];
    
    dateTable.dataSource = self;
    dateTable.delegate = self;
    [dateTable setBackgroundView:nil];
    
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"カードを贈る"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(viewCards:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = button;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    contentsArray = [defaults objectForKey:@"cardcontents"];
    
    [self createRefreshHeaderView];
    
  
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
}


-(void)createRefreshHeaderView{
    
    if(_refreshHeaderView == nil){
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f,0.0f-self.dateTable.bounds.size.height, self.view.frame.size.width, self.dateTable.bounds.size.height) ];
        view.delegate = self;
        [self.dateTable addSubview:view];
        _refreshHeaderView = view;
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    _reloading = YES;
    contentsArray = nil;
    [self postIdtoStartParse];
    [self doneLoadingTableViewData];
}

- (void)doneLoadingTableViewData{
    
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.dateTable];
    _reloading = NO;
}



-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView * )view{
    
    return _reloading;
}


-(void)refresh:(id)sender{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postIdtoStartParse];
    
}

-(void)postIdtoStartParse{
    
    contentsArray = nil;
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/postid.php"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger pidnumber = [defaults integerForKey:@"pid"];
    NSString * data = [NSString
                         stringWithFormat:@"partnerid=%d",pidnumber];
    
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        
        NSURL * newURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/cardselectviewcontroller.php"];
        NSURLRequest * req = [NSURLRequest requestWithURL:newURL];
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:req delegate:self];
        if(connection)
        {
            
            receivedData = [NSMutableData data];
        }
        
    }else{
        
        WBErrorNoticeView * notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        [notice show];
    }
    
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}



-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    
    if(contentsArray == nil)
        contentsArray = [[NSMutableArray alloc]init];
    NSXMLParser * newParser = [[NSXMLParser alloc]initWithData:receivedData];
    [newParser setDelegate:self];
    
    [newParser parse];
    receivedData = nil;
    connection = nil;
}

- (void)viewDidUnload {
    dateTable = nil;
    [self setDateTable:nil];
    [super viewDidUnload];
    
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
        
        nowTagStr = [[NSMutableString alloc]init];
        cardTitle = [[NSMutableString alloc]init];
        cardMessage = [[NSMutableString alloc]init];
        cardName = [[NSMutableString alloc]init];
        userid = [[NSString alloc]init];
        
        inTitle = NO;
        inMessage = NO;
        inCardname = NO;
        inUserid = NO;
        
        
    }
    
    if([elementName isEqualToString:@"title"]){
        
        inTitle = YES;
    }
    
    if([elementName isEqualToString:@"message"]) {
        
        inMessage = YES;
        
    }
    
    if([elementName isEqualToString:@"cardname"]){
        
        inCardname = YES;
    }
    
    
    if([elementName isEqualToString:@"userid"]){
        
        inUserid = YES;
        
    }
}

-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString*)string{
    
    if(inTitle){
        
        cardTitle = [cardTitle stringByAppendingString:string];
        
    }
    
    if(inMessage){
        
        cardMessage = [cardMessage stringByAppendingString:string];
        
    }
    
    if(inCardname){
        
        cardName = [cardName stringByAppendingString:string];
        
    }
    
    if(inUserid){
        
        userid = [userid stringByAppendingString:string];
        
        
    }
}



- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"content"] ) {
        [contentsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:cardTitle, @"titles", cardMessage, @"messages", cardName, @"cardnames", userid,@"userid",nil]];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:contentsArray forKey:@"cardcontents"];
    }
    
    if([elementName isEqualToString:@"title"]){
        
        inTitle = NO;
    }
    
    if([elementName isEqualToString:@"message"]){
        
        inMessage = NO;
    }
    if([elementName isEqualToString:@"cardname"]){
        
        inCardname = NO;
    }
    
    if([elementName isEqualToString:@"userid"]){
        
        inUserid = NO;
        
    }
}

-(void)parserDidEndDocument:(NSXMLParser*)parser
{
    
    
    if(contentsArray.count == 0){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    
    [dateTable reloadData];
}

-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    WBErrorNoticeView * notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section{
    
    return (contentsArray == nil) ?0:[contentsArray count];
    
    
}



- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight;
    
    UITableViewCell *cell = [self tableView:tableView
                      cellForRowAtIndexPath:indexPath];
    CGSize size = [cell.textLabel.text sizeWithFont:cell.textLabel.font
                                  constrainedToSize:tableView.frame.size
                                      lineBreakMode:NSLineBreakByCharWrapping];
    
    cellHeight = size.height + 80;
    return cellHeight;
}





-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    
    if(cell == nil){
        cell =
        [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
    cell.textLabel.text = [itemAtIndex objectForKey:@"titles"];
    cell.textLabel.font = font;
    cell.textLabel.numberOfLines = 0;
    cell.frame = CGRectOffset(cell.frame, 10, 10);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [cell setBackgroundColor:[UIColor colorWithRed:0.90 green:0.98 blue:0.76 alpha:0.76]];
    
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.dateTable];
    
    return  cell;
    
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLSelectedCardViewController * SCVC = [[FLSelectedCardViewController alloc]init];
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    SCVC.imageName = [itemAtIndex objectForKey:@"cardnames"];
    SCVC.message = [itemAtIndex objectForKey:@"messages"];
    
    [self.navigationController pushViewController:SCVC animated:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSString * tmpId = [itemAtIndex objectForKey:@"userid"];
    int gotId = [tmpId intValue];
    
    if(idnumber == gotId){
        
        [cell setBackgroundColor:[UIColor colorWithRed:0.90 green:0.98 blue:0.76 alpha:0.76]];
    }
    
    else {[cell setBackgroundColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.98 alpha:0.76]];
        
    }
    
}

-(void)viewCards:(id)sender{
    
    FLCardViewController * CVC = [[FLCardViewController alloc]init];
    [self.navigationController pushViewController:CVC animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
