//
//  ChatViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLChatViewController.h"
#import"FLChatlogViewController.h"
#import "WebViewController.h"
#import "FLFromchatPlanViewController.h"
#import "FLFromchatPlanViewController.h"
#import "MyChatCell.h"
#import "YourChatCell.h"
#import "FLConnection.h"
#import <QuartzCore/QuartzCore.h>


@interface FLChatViewController ()
@property(nonatomic, strong)NSString * nowTagStr;
@property(nonatomic, strong)NSString * loggedName;
@property(nonatomic, strong)NSString * loggedMessage;
@property(nonatomic, strong)NSString * logDate;
@property(nonatomic, strong)NSString * planid;
@property(nonatomic, strong)NSString * heart;
@property(nonatomic,strong)NSString * yourphotoName;
@property(nonatomic, strong)NSString * userid;
@property(strong,nonatomic)NSString * chatid;
@property int heartValue;
@property int myIndivalue;
@property int pIndivalue;
@property Boolean inName;
@property Boolean inMessage;
@property Boolean inDate;
@property Boolean inPlanid;
@property Boolean inHeartindi;
@property Boolean inMyindicator;
@property Boolean inPindicator;
@property Boolean inUserid;
@property Boolean inChatid;
@property Boolean inPhoto;
@property Boolean inMyphotosum;
@property Boolean inPphotosum;
@property int loveIndicator;
@property int postCount;
@property(nonatomic, strong)NSString * mysum;
@property(nonatomic,strong)NSString * psum;
@property(nonatomic, strong)NSString * myphotosum;
@property(nonatomic,strong)NSString * pphotosum;
@property(nonatomic, strong)NSString * myphotoName;
@property(nonatomic,strong)NSString * pphotoName;
@property(nonatomic, strong)NSString * myIndi;
@property(nonatomic, strong)NSString * pIndi;
@property(nonatomic, strong)NSMutableArray * contentsArray;
@property(nonatomic,strong)NSMutableArray * tmpcontentsArray;
@property(nonatomic,strong)NSString * photoFile;
@property(nonatomic,strong)NSMutableData * receivedData;
@property(nonatomic, strong) UIButton * loveInd;
@property(nonatomic, strong) UIButton * loveInd2;
@property(nonatomic, strong) UIButton * loveInd3;
@property(nonatomic, strong) UIButton * loveInd4;
@property(nonatomic, strong) UIButton * loveInd5;
@property(nonatomic, strong)UILabel * chatLabel;
@property(nonatomic, strong)WBErrorNoticeView * notice;
-(void)postandGet;
-(void)toHistory:(id)sender;





@end

@implementation FLChatViewController

@synthesize chatTable, loggedName, loggedMessage, nowTagStr, contentsArray, logDate, planid, heart, myIndi, pIndi, tmpcontentsArray, photoFile, loveInd, loveInd2, loveInd3, loveInd4, loveInd5, mysum, psum, userid,myphotosum,pphotosum,chatid,receivedData,chatLabel,notice,myphotoName,pphotoName,myIndivalue,pIndivalue,loveIndicator,postCount, inName, inMessage, inDate, inPlanid, inHeartindi, inMyindicator, inPindicator,inUserid, inChatid, inPhoto, inMyphotosum,inPphotosum,soundID,yourphotoName;

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
    
    [chatTable registerNib:[UINib nibWithNibName:@"MyChatCell" bundle:nil] forCellReuseIdentifier:@"MyChatCell"];
    [chatTable registerNib:[UINib nibWithNibName:@"YourChatCell"bundle:nil]forCellReuseIdentifier:@"YourChatCell"];
    [self setNavigationComponents];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSURL * URL;
    URL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"heartsound2" ofType:@"wav"] isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &soundID);
    
    chatTable.dataSource = self;
    chatTable.delegate = self;
    [chatTable setBackgroundView:nil];
    
    contentsArray = [self getContentsArrayFromUserDefaults];
   
    
    if(_refreshHeaderView == nil){
        
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f,0.0f-self.chatTable.bounds.size.height, self.view.frame.size.width, self.chatTable.bounds.size.height) ];
        
        view.delegate = self;
        [self.chatTable addSubview:view];
        _refreshHeaderView = view;
    }
    
    [chatTable reloadData];
    
}


-(NSMutableArray *)getContentsArrayFromUserDefaults{
    
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"chatcontents"];

    
}

-(void)setNavigationComponents{
    
    
    [self.navigationItem setHidesBackButton: YES animated:YES];
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"writeicon3.png"]
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(sendClicked:)];
    
    [[self navigationItem]setRightBarButtonItem:bbi];
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = button;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //すでに保持している最新のデータを表示
    [self.chatTable reloadData];
    
    if(contentsArray.count > 29){
        
        UIButton * toHistory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [toHistory addTarget:self
                      action:@selector(toHistory:)
            forControlEvents:UIControlEventTouchUpInside];
        

        
        chatTable.tableFooterView = toHistory;
        
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    BOOL after = [defaults objectForKey:@"topview"];
    
    if(!(after)){
        
        FLChatlogViewController * ALVC = [[FLChatlogViewController alloc]init];
        [self.navigationController pushViewController:ALVC animated:YES];
        [defaults setBool:YES forKey:@"topview"];
        
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
    postCount = nil;
    
    [self postandGet];
    [self doneLoadingTableViewData];
    
}

- (void)doneLoadingTableViewData{
    
    
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.chatTable];
    
    _reloading = NO;
}



-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView * )view{
    
    return _reloading;
    
}


-(int)getIdFromUserDefaults{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"mid"];
}

-(int)getPidFromUserDefaults{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"pid"];
}


-(void)postandGet{
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/postid.php"];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSInteger pidnumber = [defaults integerForKey:@"pid"];
    NSLog(@"pid%d", pidnumber);
    NSString * data = [NSString
                       stringWithFormat:@"userid=%d&partnerid=%d",idnumber, pidnumber];
    
    FLConnection * connection = [[FLConnection alloc]init];
    connection.delegate = self;
    [connection connectionAndParseWithUrl:url withData:data];
}

-(void)startParse{
    
    NSLog(@"startparse");
    NSURL *newURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/labchatviewcontroller.php"];
    NSURLRequest * req = [NSURLRequest requestWithURL:newURL];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(connection)
    {
        receivedData = [NSMutableData data];
    }
}

-(void)showAlert{
    

        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
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


- (void)viewDidUnload {
    chatTable = nil;
    
    [self setChatTable:nil];
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
        
        nowTagStr = [[NSString alloc]init];
        loggedName = [[NSString alloc]init];
        userid = [[NSString alloc]init];
        loggedMessage = [[NSString alloc]init];
        logDate = [[NSString alloc]init];
        planid = [[NSString alloc]init];
        heart = [[NSString alloc]init];
        myIndi = [[NSString alloc]init];
        pIndi = [[NSString alloc]init];
        chatid = [[NSString alloc]init];
        photoFile = [[NSString alloc]init];
        mysum = [[NSString alloc]init];
        psum = [[NSString alloc]init];
        myphotosum = [[NSString alloc]init];
        pphotosum = [[NSString alloc]init];
        
        
        inName = NO;
        inUserid = NO;
        inMessage =NO;
        inChatid = NO;
        inDate = NO;
        inPlanid = NO;
        inHeartindi = NO;
        inMyindicator = NO;
        inPindicator = NO;
        inPhoto = NO;
        inMyphotosum = NO;
        inPphotosum = NO;
        
    }
    
    
    if([elementName isEqualToString:@"chatid"]){
        
        inChatid = YES;
        
    }
    
    if([elementName isEqualToString:@"name"]){
        
        inName = YES;
        
    }
    
    if([elementName isEqualToString:@"userid"]){
        
        inUserid = YES;
    }
    
    
    if([elementName isEqualToString:@"log"]){
        
        inMessage = YES;
    }
    
    if([elementName isEqualToString:@"photo"]){
        
        inPhoto = YES;
        
    }
    
    if([elementName isEqualToString:@"date"]){
        
        inDate = YES;
        
    }if([elementName isEqualToString:@"planid"]){
        
        inPlanid = YES;
    }if([elementName isEqualToString:@"heartindi"]){
        
        inHeartindi = YES;
        
    }
    if([elementName isEqualToString:@"mysum"]){
        
        inMyindicator = YES;
        
    }
    if([elementName isEqualToString:@"psum"]){
        
        inPindicator = YES;
        
    }
    
    if([elementName isEqualToString:@"myphotosum"]){
        
        inMyphotosum = YES;
        
    }
    
    if([elementName isEqualToString:@"pphotosum"]){
        
        inPphotosum = YES;
    }
    
    
    
}



-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString *)string{
    
    
    if(inChatid){
        
        
        chatid = [chatid stringByAppendingString:string];
        
    }
    
    
    if(inName){
        
        loggedName = [loggedName stringByAppendingString:string];
        
    }
    
    if(inUserid){
        
        userid = [userid stringByAppendingString:string];
        
        
    }
    
    if(inMessage)
    {
        
        loggedMessage = [loggedMessage stringByAppendingString:string];
        
    }
    
    if(inPhoto)
        
    {
        
        photoFile = [photoFile stringByAppendingString:string];
    }
    
    if(inDate)
    {
        
        logDate = [logDate stringByAppendingString:string];
        
        
    } if(inPlanid){
        
        
        planid = [planid stringByAppendingString:string];
    }
    if(inHeartindi){
        
        
        heart = [heart stringByAppendingString:string];
        
    }
    
    if(inMyindicator){
        
        myIndi = [myIndi stringByAppendingString:string];
        
    }
    
    if(inPindicator){
        
        pIndi = [pIndi stringByAppendingString:string];
        
    }
    
    if(inMyphotosum){
        
        
        myphotosum = [myphotosum stringByAppendingString:string];
        
        
        
    }
    
    if(inPphotosum){
        
        pphotosum = [pphotosum stringByAppendingString:string];
        
        
    }
    
    
}


//tableviewのとき、どこでわりあてるのか

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"content"] ) {
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [contentsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:chatid, @"chatid", loggedName, @"names", userid, @"userid", loggedMessage, @"messages", photoFile, @"photo",logDate, @"date",planid, @"planid",heart, @"heartindi",myIndi, @"msum", pIndi, @"psum",myphotosum,@"myphotosum", pphotosum,@"pphotosum", nil]];
        
        myIndivalue = [myIndi intValue];
        pIndivalue = [pIndi intValue];
        int  myphotoIndi = [myphotosum intValue];
        int pphotoIndi = [pphotosum intValue];
        
        NSLog(@"contentsArraycount%d", contentsArray.count);
        
        
        [defaults setInteger:myIndivalue forKey:@"msum"];
        [defaults setInteger:pIndivalue forKey:@"psum"];
        [defaults setInteger:myphotoIndi forKey:@"myphotosum"];
        [defaults setInteger:pphotoIndi forKey:@"pphotosum"];
        
        if(contentsArray.count <31){
            
            [defaults setObject:contentsArray forKey:@"chatcontents"];
            
        }
        
    }
    
    if([elementName isEqualToString:@"chatid"]){
        
        inChatid = NO;
        
    }
    
    if([elementName isEqualToString:@"name"]){
        inName = NO;
    }
    
    
    if([elementName isEqualToString:@"userid"]){
        
        
        inUserid = NO;
    }
    
    if([elementName isEqualToString:@"log"]){
        inMessage = NO;
    }
    
    if([elementName isEqualToString:@"photo"]){
        
        inPhoto = NO;
        
    }
    
    if([elementName isEqualToString:@"date"]){
        inDate = NO;
        
    }
    
    if([elementName isEqualToString:@"planid"]){
        
        inPlanid = NO;
        
    }
    
    if([elementName isEqualToString:@"heartindi"]){
        
        inHeartindi = NO;
        
    }
    if([elementName isEqualToString:@"mysum"]){
        
        inMyindicator = NO;
        
    }
    
    if([elementName isEqualToString:@"psum"]){
        
        inPindicator= NO;
        
    }
    
}


-(void)parserDidEndDocument:(NSXMLParser*)parser
{
    
    if(contentsArray.count == 0){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.chatTable];

    
    [chatTable reloadData];
    
}

-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}





-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView{
    return 1;
}




-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section
{
    
    
    if(postCount > 0){
        
        return postCount;
        
    } else {
        
        return contentsArray.count;
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    NSString * chatString = [itemAtIndex objectForKey:@"messages"];
	CGSize size = [chatString sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:CGSizeMake(210.0, 480.0) lineBreakMode:NSLineBreakByWordWrapping];
	return size.height + 80;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    NSString * useridString = [itemAtIndex objectForKey:@"userid"];
    int userId = [useridString intValue];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    static NSString * identifier;
    
    NSString * chatString = [[NSString alloc]init];
    chatString = [itemAtIndex objectForKey:@"messages"];
    MyChatCell * cell;

    
    if(userId == idnumber){
        
        //if(!cell){
            
            identifier = @"MyChatCell";
            myphotoName =  [itemAtIndex objectForKey:@"photo"];
            cell =  [chatTable dequeueReusableCellWithIdentifier:identifier];
            cell.backgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"greencell2.png"]stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
        //}
        
        chatLabel = nil;
        CGSize bounds = CGSizeMake(210, 480);
        CGSize size = [chatString sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:bounds lineBreakMode:NSLineBreakByWordWrapping];
        int height = size.height + 30;
        int width = size.width;
        cell.labelHeight = height;
        cell.labelWidth = width;
        cell.textsize = &(size);
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:11];
        cell.textLabel.font = font;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = chatString;
        cell.textLabel.numberOfLines = 0;
        [cell sizeToFit];

    }else{
        
        //if(!cell){
            
            identifier = @"YourChatCell";
            yourphotoName = [itemAtIndex objectForKey:@"photo"];
            cell =  [chatTable dequeueReusableCellWithIdentifier:identifier];

        //}
    
        //変数identiferで二つのセルを場合によって読み込む。
        //MyChatCell * cell = [chatTable dequeueReusableCellWithIdentifier:identifier  forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"cellblue.png"]stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
        chatLabel = nil;
        CGSize bounds = CGSizeMake(210, 480);
        CGSize size = [chatString sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:bounds lineBreakMode:NSLineBreakByWordWrapping];
        int height = size.height + 30;
        int width = size.width;
        cell.labelHeight = height;
        cell.labelWidth = width;
        cell.textsize = &(size);
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:11];
        cell.textLabel.font = font;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = chatString;
        cell.textLabel.numberOfLines = 0;
        [cell sizeToFit];

    }
    
     
    cell.dateLabel.text = [itemAtIndex objectForKey:@"date"];
    cell.tmpIndicator = [itemAtIndex objectForKey:@"heartindi"];
    cell.chatid = [itemAtIndex objectForKey:@"chatid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * profile = @"http://flatlevel56.org/lovelog/profile_photos/";
    NSString * photoString = [itemAtIndex objectForKey:@"photo"];
    NSString * photoUrl = [NSString stringWithFormat:@"%@%@", profile, photoString];
    [cell.profilePhoto setImageWithURL:[NSURL URLWithString:photoUrl]placeholderImage:[UIImage imageNamed:@"backgroundview.png"]];
    [cell.profilePhoto setContentMode:UIViewContentModeScaleAspectFill];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    _reloading = NO;
    
    
    return  cell;
}



-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    NSDictionary * itemAtIndex = (NSDictionary*)[contentsArray objectAtIndex:indexPath.row];
    NSString * checkString = [itemAtIndex objectForKey:@"messages"];
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [linkDetector matchesInString:checkString options:0 range:NSMakeRange(0, [checkString length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypeLink) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSURL * url = [match URL];
            WebViewController * WVC = [[WebViewController alloc]init];
            WVC.url = url;
            [self.navigationController pushViewController:WVC animated:YES];
            
        }
    }
    
    NSString * plantoPass = [itemAtIndex objectForKey:@"planid"];
    int value = [plantoPass intValue];
    if(value > 0){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        FLFromchatPlanViewController * FPVC = [[FLFromchatPlanViewController alloc]init];
        FPVC.planid = plantoPass;
        [self.navigationController pushViewController:FPVC animated:YES];
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}




-(void)refresh:(id)sender{
    contentsArray = nil;
    postCount = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postandGet];
    
}



-(void)sendClicked:(id)sender{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    FLChatlogViewController * CLVC = [[FLChatlogViewController alloc]init];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:CLVC  animated:NO];
}




-(void)toHistory:(id)sender{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/postpage.php"];
    postCount = contentsArray.count + 30;
    NSString * data = [NSString
                       stringWithFormat:@"page=%d",postCount];
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        
        
        contentsArray = nil;
        postCount = nil;
        NSURL *newURL = [NSURL URLWithString:@"http://flatlevel56.org/lovelog/labchatviewcontroller.php"];
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




@end
