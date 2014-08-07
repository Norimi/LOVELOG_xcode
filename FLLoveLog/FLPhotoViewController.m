//
//  PhotoViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/17.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLPhotoViewController.h"
#import "PhotoCell.h"
#import "FLPhototitleViewController.h"
#import "UIImageView+WebCache.h"
#import "FLConnection.h"
@interface FLPhotoViewController ()

#pragma mark UI
@property(nonatomic, retain)PhotoCell * customCell;
@property(strong,nonatomic) WBErrorNoticeView * notice;
@property UIImageView * photoView;


#pragma mark use for parser
@property(strong, nonatomic)NSString * photoidString;
@property(strong ,nonatomic)NSString * useridString;
@property(strong,nonatomic)NSMutableData * receivedData;
@property (strong, nonatomic)NSMutableArray * contentsArray;
@property(strong,nonatomic)NSString * nowTagStr;
@property(strong,nonatomic)NSString * photoUrl;
@property(strong,nonatomic)NSString * myIndi;
@property(strong,nonatomic)NSString * partnerIndi;
@property(strong,nonatomic) NSString * titleString;
@property (strong,nonatomic)NSString * photourl;
@property Boolean inUrl;
@property Boolean inMyindi;
@property Boolean inPindi;
@property Boolean inPhotoid;
@property Boolean inUserid;
@property Boolean inTitle;
@property int postCount;
@property int deleteid;



#pragma mark loveindicator
@property int loveIndicator;
@property(nonatomic,strong)UIButton * loveInd;
@property(strong,nonatomic,readonly)UIButton * loveInd2;
@property(strong,nonatomic,readonly)UIButton * loveInd3;
@property(strong,nonatomic,readonly)UIButton * loveInd4;
@property(readonly)UIButton * loveInd5;
@property int myIndivalue;
@property int pIndivalue;
@end

@implementation FLPhotoViewController
@synthesize photoTable,customCell,notice,photoView,photoidString,useridString,receivedData,contentsArray,nowTagStr,photoUrl,myIndi,titleString,partnerIndi,inUrl,inMyindi,inPindi,inUserid,inTitle,postCount,deleteid,inPhotoid;


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
    [self.photoTable registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellReuseIdentifier:@"PhotoCell"];
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSURL * URL;
    URL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"heartsound2" ofType:@"wav"] isDirectory:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    photoTable.dataSource = self;
    photoTable.delegate = self;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &soundID);
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"camerabutton.png"]
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(uploadClicked:)];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = button;
    [[self navigationItem]setRightBarButtonItem:bbi];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    BOOL after = [defaults boolForKey:@"photoview"];
    
    if(!after){
        
        NSString * body = @"写真を投稿しましょう。投稿された写真はつけられたハートの数の多い順に表示されます。パートナーの投稿した写真につけたハートの数はパートナーのものとしてカウントされます。";
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:body delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag = 1;
        [alertView show];
        [defaults setBool:YES forKey:@"photoview"];
        
    }
    
    
    contentsArray = nil;
    contentsArray = [defaults objectForKey:@"photoscontents"];
    
    UIButton * toHistory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [toHistory addTarget:self
                  action:@selector(toHistory:)
        forControlEvents:UIControlEventTouchUpInside];
    if(contentsArray.count > 29){
        
        photoTable.tableFooterView = toHistory;
    }
    
    
    if(_refreshHeaderView == nil){
        
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f,0.0f-self.photoTable.bounds.size.height, self.view.frame.size.width, self.photoTable.bounds.size.height) ];
        
        view.delegate = self;
        [self.photoTable addSubview:view];
        _refreshHeaderView = view;
        
        
    }
    
    [self.photoTable reloadData];
    
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
    
    
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.photoTable];
    _reloading = NO;
}



-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView * )view{
    
    return _reloading;
    
}

-(void)refresh:(id)sender{
    
    contentsArray = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self postandGet];
    
    
}

-(void)postandGet{
    
    contentsArray = nil;
    NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/postid.php"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSInteger pidnumber = [defaults integerForKey:@"pid"];
    NSString * data = [NSString
                       stringWithFormat:@"userid=%d&partnerid=%d",idnumber, pidnumber];
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        
        NSURL *newURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/photoview.php"];
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




-(void)parser:(NSXMLParser*)parser
didStartElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
   attributes:(NSDictionary*)attributeDict{
    
    if([elementName isEqualToString:@"content"]){
        nowTagStr = [[NSString alloc]init];
        myIndi = [[NSString alloc]init];
        partnerIndi = [[NSString alloc]init];
        photoUrl = [[NSString alloc]init];
        photoidString = [[NSString alloc]init];
        useridString = [[NSString alloc]init];
        titleString = [[NSString alloc]init];
        
        
        inUrl = NO;
        inMyindi = NO;
        inPindi = NO;
        inPhotoid = NO;
        inUserid = NO;
        inTitle = NO;
        
    }
    
    
    if([elementName isEqualToString:@"url"]){
        
        inUrl = YES;
    }
    
    if([elementName isEqualToString:@"title"]){
        
        
        inTitle = YES;
        
    }
    
    
    if([elementName isEqualToString:@"photoid"]){
        
        
        inPhotoid = YES;
        
    }
    
    
    if([elementName isEqualToString:@"userid"]){
        
        
        inUserid = YES;
        
    }
    
    
    
    if([elementName isEqualToString:@"myindicator"]){
        
        inMyindi = YES;
        
    }
    
    if([elementName isEqualToString:@"partnerindicator"]){
        
        inPindi = YES;
        
    }
    
}



-(void)parser:(NSXMLParser *)parser
foundCharacters:(NSString*)string{
    
    if(inUrl){
        
        photoUrl = [photoUrl stringByAppendingString:string];
    }
    
    if(inTitle){
        
        titleString = [titleString stringByAppendingString:string];
    }
    
    if(inPhotoid){
        
        photoidString = [photoidString stringByAppendingString:string];
    }
    
    if(inUserid){
        
        
        useridString = [useridString stringByAppendingString:string];
      
        
    }
    
    if(inMyindi){
        
        
        myIndi = [myIndi stringByAppendingString:string];
        
            }
    
    if(inPindi){
        
        partnerIndi = [partnerIndi stringByAppendingString:string];
        
              
    }
    
    
    
}



- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"content"] ) {
        
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSInteger idnumber = [defaults integerForKey:@"mid"];
        int user = [useridString intValue];
        
        //useridがパートナーか自分かで条件分岐する
        if(user == idnumber){
            //データーベースにはカラムにidがupload者本位で入っているのでパーサーではidが混ざっている。
            //ここでユーザーかパートナーかどちらがアップロードした写真か区別する
            [contentsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:photoUrl, @"url", titleString, @"title", photoidString, @"photoid", useridString, @"userid", myIndi,@"myindi",partnerIndi,@"partnerindi", nil]];
                
              } else {
            
            
            [contentsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:photoUrl, @"url", titleString, @"title", photoidString, @"photoid", useridString, @"userid", myIndi,@"partnerindi",partnerIndi,@"myindi", nil]];
            
        }
        
        if(contentsArray.count < 31){
            
            [defaults setObject:contentsArray forKey:@"photoscontents"];
       
        }
        
    }
    
    if([elementName isEqualToString:@"url"]){
        
        inUrl = NO;
        
    }
    
    if([elementName isEqualToString:@"title"]){
        
        
        inTitle = NO;
        
    }
    
    if([elementName isEqualToString:@"photoid"]){
        
        
        inPhotoid = NO;
        
    }
    
    if([elementName isEqualToString:@"userid"]){
        
        
        
        inUserid = NO;
    }
    
    
    
    
    if([elementName isEqualToString:@"myindicator"]){
        
        
        inMyindi = NO;
        
    } if([elementName isEqualToString:@"partnerindicator"]){
        
        
        inPindi = NO;
        
    }
    
}


-(void)parserDidEndDocument:(NSXMLParser*)parser
{
    
    if(contentsArray.count == 0){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    [photoTable reloadData];
    
}


-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView*)tableView
numberOfRowsInSection:(NSInteger)section{
    
    return contentsArray.count;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //カスタムセルの高さを指定
    return 230;
}




-(UITableViewCell *) tableView:(UITableView*)tableView
cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
   
    PhotoCell * cell  = [photoTable dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    NSDictionary * itemAtIndex = (NSDictionary *)[contentsArray objectAtIndex:indexPath.row];
    //indicatorの値を取得してUIに反映させる
    
    
    NSString * intMindi = [itemAtIndex objectForKey:@"myindi"];
    NSString * intPindi = [itemAtIndex objectForKey:@"partnerindi"];
    NSString * photoidtoPass = [itemAtIndex objectForKey:@"photoid"];
    NSString * useridtoPass = [itemAtIndex objectForKey:@"userid"];
    NSString * titletoPass = [itemAtIndex objectForKey:@"title"];
    cell.photoid = photoidtoPass;
    cell.userid = useridtoPass;
    cell.tString = titletoPass;
    cell.loveIndicator = [intMindi intValue];
    cell.frompartnerInd = [intPindi intValue];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * urlString = [itemAtIndex objectForKey:@"url"];
    NSString * http = @"http://norimingconception.net/lovelog/photo_uploaded/" ;
    NSString * postUrl =  [NSString stringWithFormat:@"%@%@", http,urlString];
    [cell.photoView setContentMode:UIViewContentModeScaleAspectFill];
    [cell.photoView setImageWithURL:[NSURL URLWithString:postUrl]placeholderImage:[UIImage imageNamed:@"backgroundview.png" ]options:SDWebImageRetryFailed];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.photoTable];
        
   
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
  //TODO:写真の消去
    
}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1 && alertView.tag == 2){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/deletephoto.php"];
        NSString * data = [NSString
         stringWithFormat:@"photoid=%d",deleteid];
        FLConnection * connection = [[FLConnection alloc]init];
        if([connection connectionWithUrl:url withData:data]){
            
        }else{
            
            
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

            
        }
        
             
        [self postandGet];
        
        
    }
    
}





-(void)uploadClicked:(id)sender{
    
    //imagepickerが出現
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
    imagePicker.allowsEditing = YES;
    
}



-(void)imagePickerController:(UIImagePickerController*)picker
didFinishPickingMediaWithInfo:(NSDictionary*)editingInfo{
    
    
    //選んだ写真を表示するviewへ移行。タイトルをつけていただく。（コメント機能は次のversで）
    FLPhototitleViewController * PTVC = [[FLPhototitleViewController alloc]init];
    UIImage * toUpload = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    PTVC.toShow = toUpload;
    //TODO:コンプリーションブロックの活用
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.navigationController pushViewController:PTVC animated:YES];
        
    }];
    
}



-(void)toHistory:(id)sender{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/postpage.php"];
    postCount = contentsArray.count + 30;
    NSString * data = [NSString
                       stringWithFormat:@"page=%d",postCount];
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        
        contentsArray = nil;
        NSURL *newURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/photoview.php"];
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
