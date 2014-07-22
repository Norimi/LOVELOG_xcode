//
//  TopViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/16.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLTopViewController.h"
#import "FLAccountViewController.h"
#import "FLPartnerAcViewController.h"
#import "FLPlantableViewController.h"
#import "FLChatViewController.h"
#import "AFNetworking.h"
#import "FLChatlogViewController.h"
#import "FLConnection.h"
#import "WBErrorNoticeView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"

@interface FLTopViewController ()
@property WBErrorNoticeView * notice;
@end

@implementation FLTopViewController
@synthesize youraccountButton, myaccountButton, topImage, myImage, yourImage, receivedData, fileString, titleString, userphotoString, partnerphotoString, filenamedict, planLabel, mychatLabel, yourchatLabel,toPhoto,toChatview,toPlan,notice;


FLAccountViewController * AVC;
FLPartnerAcViewController * PAVC;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    CGRect screenSize = [UIScreen mainScreen].bounds;
    
    //topの画面をiPhoneの縦のサイズで条件分岐
    if(screenSize.size.height <= 480){
        
        nibNameOrNil=@"TopView3.5";
        
        
    } else {
        
        nibNameOrNil = @"FLTopViewController";
    }
    
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初回起動時のメッセージ
    NSUserDefaults * defautls = [NSUserDefaults standardUserDefaults];
    BOOL after = [defautls boolForKey:@"topview"];
    
    if(!after){
        
        NSString * body = @"プロフィール写真をUPしますか?";
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:body delegate:self cancelButtonTitle:@"あとで" otherButtonTitles:@"はい", nil];
        alertView.tag = 1;
        [alertView show];
        
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    planLabel.text = [defaults objectForKey:@"plantitle"];
    mychatLabel.text = [defaults objectForKey:@"mychatstring"];
    yourchatLabel.text = [defaults objectForKey:@"yourchatstring"];
    
}




- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 1){
        
        //次のarletviewを出す
        NSString * body = @"パートナーに最初のメッセージを送りますか？";
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:body delegate:self cancelButtonTitle:@"あとで" otherButtonTitles:@"はい", nil];
        alertView.tag = 2;
        [alertView show];
        
    }else if (buttonIndex == 1 && alertView.tag==1){
        
        //プロフ写真を選択。
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker.allowsEditing = YES;
        //delegateメソッドへ移行
        
    } else if(buttonIndex == 0 && alertView.tag ==2){
        
        //alert表示済みの値をuserdefaultに入れる
        NSUserDefaults * defaults = [[NSUserDefaults alloc]init];
        [defaults setBool:YES forKey:@"topview"];
        
        
    }else if(buttonIndex == 1 && alertView.tag == 2){
        
        
        self.tabBarController.selectedIndex = 1;
        
    }
    
}


#pragma mark delegate_method
-(void)imagePickerController:(UIImagePickerController*)picker
didFinishPickingMediaWithInfo:(NSDictionary*)editingInfo{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIImage * toUpload = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    //TODO:completionblockにして、終了後次の処理へ
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString * ext = @".jpg";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSString * idtoPost = [NSString stringWithFormat:@"%d", idnumber];
    UIImage * img = toUpload;
    NSData * imageData = UIImageJPEGRepresentation(img, 90);
    AFHTTPClient * client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://norimingconception.net"]];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ext, @"extension", idtoPost, @"userid",
                            nil];
    NSMutableURLRequest * request =  [client multipartFormRequestWithMethod:@"POST" path:@"/lovelog/labaccount.php" parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData: imageData name:@"upfile" fileName:@"title" mimeType:@"image/jpeg"];
    }];
    [request setTimeoutInterval:80];
    
    //TODO:成功処理とエラー処理
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * body = @"パートナーに最初のメッセージを送りますか？";
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:body delegate:self cancelButtonTitle:@"あとで" otherButtonTitles:@"はい", nil];
        alertView.tag = 2;
        [alertView show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if([operation.response statusCode] == 403){
            
            return;
        }
        
    }];
    
    [operation start];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    [self postandGet];
    
    
}


-(void)postandGet{
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"mychatstring"];
    planLabel.text = nil;
    mychatLabel.text = nil;
    yourchatLabel.text = nil;
    
    NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/postid.php"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSInteger pidnumber = [defaults integerForKey:@"pid"];
    NSString * data = [NSString
                       stringWithFormat:@"userid=%d&partnerid=%d",idnumber, pidnumber];
    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:data]){
        //通信成功時
        NSURL *newURL = [NSURL URLWithString:@"http://norimingconception.net/lovelog/topviewcontroller.php"];
        NSURLRequest * req = [NSURLRequest requestWithURL:newURL];
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:req delegate:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
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
        
        fileString = [[NSString alloc]init];
        titleString = [[NSString alloc]init];
        userphotoString = [[NSString alloc]init];
        partnerphotoString = [[NSString alloc]init];
        plantitle = [[NSString alloc]init];
        mychatString = [[NSString alloc]init];
        yourchatString = [[NSString alloc]init];
        
        inFilename = NO;
        inTitle = NO;
        inUserphoto = NO;
        inPartnerphoto = NO;
        inPlantitle = NO;
        inMychat = NO;
        inYourchat  = NO;
        
    }
    
    if([elementName isEqualToString:@"filename"]){
        
        inFilename = YES;
        
    }
    
    if([elementName isEqualToString:@"title"]){
        
        
        inTitle =YES;
        
    }
    
    if([elementName isEqualToString:@"userphoto"]){
        
        inUserphoto = YES;
        
        
    }
    
    if([elementName isEqualToString:@"partnerphoto"]){
        
        
        inPartnerphoto = YES;
        
    }
    
    if([elementName isEqualToString:@"plantitle"]){
        
        
        inPlantitle = YES;
        
    }
    
    if([elementName isEqualToString:@"mychat"]){
        
        inMychat = YES;
        
    }
    
    if([elementName isEqualToString:@"yourchat"]){
        
        
        inYourchat = YES;
    }
    
}




-(void)parser:(NSXMLParser *)parser
foundCharacters:(NSString*)string{
    
    
    if(inFilename){
        
        fileString = [fileString stringByAppendingString:string];
        
    }
    
    if(inTitle){
        
        titleString = [titleString stringByAppendingString:string];
    }
    
    if(inUserphoto ){
        
        userphotoString = [userphotoString stringByAppendingString:string];
        
    }
    
    if(inPartnerphoto){
        
        partnerphotoString = [partnerphotoString stringByAppendingString:string];
    }
    
    
    if(inPlantitle){
        
        plantitle = [plantitle stringByAppendingString:string];
        
        
    }
    
    if(inMychat){
        
        
        mychatString = [mychatString stringByAppendingString:string];
        
    }
    
    
    if(inYourchat){
        
        yourchatString = [yourchatString stringByAppendingString:string];
    }
    
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:@"content"] ) {
        
        //ここで自分のphotoと相手のphotoの名前をuserdefaultsに入れる。
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:fileString forKey:@"filestring"];
        [defaults setObject:titleString forKey:@"titlestring"];
        [defaults setObject:plantitle forKey:@"plantitle"];
        [defaults setObject:mychatString forKey:@"mychatstring"];
        [defaults setObject:yourchatString forKey:@"yourchatstring"];
        [defaults setObject:userphotoString forKey:@"myphoto"];
        [defaults setObject:partnerphotoString forKey:@"partnerphoto"];
    }
    
    if([elementName isEqualToString:@"filename"]){
        
        inFilename = NO;
        
    }
    
    if([elementName isEqualToString:@"title"]){
        
        inTitle =NO;
        
    }
    
    if([elementName isEqualToString:@"userphoto"]){
        
        inUserphoto =NO;
        
    }
    if([elementName isEqualToString:@"partnerphoto"]){
        
        inPartnerphoto = NO;
        
    }
    
    if([elementName isEqualToString:@"plantitle"]){
        
        
        inPlantitle = NO;
        
        
    }
    
    if([elementName isEqualToString:@"mychat"]){
        
        inMychat = NO;
        
    }
    
    if([elementName isEqualToString:@"yourchat"]){
        
        
        inYourchat = NO;
        
    }
    
}


-(void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError{
    
    notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"パースエラー" message:@"エラーが検出されました。"];
    [notice show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void)parserDidEndDocument:(NSXMLParser*)parser
{
    
    //画像を取得して表示する
    NSString * http = @"http://norimingconception.net/lovelog/photo_uploaded/" ;
    NSString * profile = @"http://norimingconception.net/lovelog/profile_photos/";
    NSString * postUrl =  [NSString stringWithFormat:@"%@%@", http,fileString];
    NSString * userUrl = [NSString stringWithFormat:@"%@%@", profile, userphotoString];
    NSString * partnerUrl  = [NSString stringWithFormat:@"%@%@", profile, partnerphotoString];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * topPlan = [defaults objectForKey:@"plantotop"];
    
    [topImage setImageWithURL:[NSURL URLWithString:postUrl]placeholderImage:[UIImage imageNamed:@"backgroundview.png"]];
    [topImage setContentMode:UIViewContentModeScaleAspectFill];
    [myImage setImageWithURL:[NSURL URLWithString:userUrl]placeholderImage:[UIImage imageNamed:@"myprofile.png"]];
    [myImage setContentMode:UIViewContentModeScaleAspectFill];
    [yourImage setImageWithURL:[NSURL URLWithString:partnerUrl]placeholderImage:[UIImage imageNamed:@"yourprofile.png"]];
    [yourImage setContentMode:UIViewContentModeScaleAspectFill];
    mychatLabel.text = mychatString;
    yourchatLabel.text = yourchatString;
    planLabel.text = topPlan;
}


- (IBAction)toyourAccount:(id)sender {
    
    FLPartnerAcViewController * PAVC = [[FLPartnerAcViewController alloc]init];
    [self.navigationController
     pushViewController:PAVC animated:YES];
}

- (IBAction)tomyAccount:(id)sender {
    
    FLAccountViewController * AVC = [[FLAccountViewController alloc]init];
    [self.navigationController pushViewController:AVC animated:YES];
}
- (IBAction)toplanView:(id)sender {
    
    self.tabBarController.selectedIndex = 2;
    
}
- (IBAction)tochatView:(id)sender {
    
    self.tabBarController.selectedIndex = 1;
    
    
}
- (IBAction)tophotoView:(id)sender {
    
    self.tabBarController.selectedIndex = 4;
    
}
@end
