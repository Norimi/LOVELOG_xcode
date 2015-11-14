//
//  AccountViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/02/14.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLAccountViewController.h"
#import "FLEditviewController.h"
#import "FLLoginViewController.h"
#import "FLAppDelegate.h"
#import "FLResignViewController.h"
#import "FLPartnerAcViewController.h"
#import "AFNetworking.h"
#import "FLEditViewController.h"
#import "FLConnection.h"

@interface FLAccountViewController ()
@property(strong, nonatomic)NSString * nowTagStr;
@property(strong, nonatomic)NSString * partnerName;
@property(strong, nonatomic)NSString * userName;
@property(strong, nonatomic)NSString * mName;
@property(strong, nonatomic)NSString * mEmail;
@property   WBErrorNoticeView* notice;
@property AFHTTPRequestOperationManager * manager;
@end

@implementation FLAccountViewController
@synthesize mynameLabel, mName, mEmail, myImage, indiLabel,addPhoto,  nowTagStr, partnerName, userName, logOut, resign,toEdit,notice;


FLEditViewController * EVC;
FLLoginViewController * LVC;
FLResignViewController * RVC;
FLPartnerAcViewController * PVC;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //init時にインスタンスをひとつだけ保持
        _manager = [AFHTTPRequestOperationManager manager];
        

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self->scrollView setContentSize:CGSizeMake(320, 550)];
    self.title = @"アカウント";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    mName = [defaults stringForKey:@"mname"];
    mEmail = [defaults stringForKey:@"memail"];
    int mindi = [defaults integerForKey:@"msum"];
    int photoindi = [defaults integerForKey:@"myphotosum"];
    int sum = mindi + photoindi;
    NSString * value = [[NSString stringWithFormat:@"♡%d", sum]init];
    indiLabel.text = value;
    mynameLabel.text = mName;
    emailLabel.text = mEmail;
    
    NSString * profile = @"http://norimingconception.net/lovelog/profile_photos/";
    NSString * file = [defaults stringForKey:@"myphoto"];
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",profile, file];
    [myImage setImageWithURL:[NSURL URLWithString:postUrl]placeholderImage:[UIImage imageNamed:@"backgroundview.png"]];
    [myImage setContentMode:UIViewContentModeScaleAspectFill];
    
    
}



-(void)toEdit:(id)sender{
    
    EVC = [[FLEditViewController alloc]init];
    [[self navigationController]pushViewController:EVC
                                          animated:YES];
    
}

-(void)toPartner:(id)sender{
    
    FLPartnerAcViewController * PVC = [[FLPartnerAcViewController alloc]init];
    [[self navigationController]pushViewController:PVC
                                          animated:YES];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)reSign:(id)sender {
    //セッション情報を空にする。UserDefaultを空にする。
    //サーバー上のすべての情報を消去する。
    RVC = [[FLResignViewController alloc]init];
    [[self navigationController]pushViewController:RVC
                                          animated:YES];
    
    
    
}
- (IBAction)logOut:(id)sender {
    
    FLConnection * connection = [[FLConnection alloc]init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/logoutviewcontroller.php"];
    if([connection connectionWithUrl:url withData:nil]){
        
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        
        [defaults removeObjectForKey:@"mid"];
        [defaults removeObjectForKey:@"pid"];
        [defaults synchronize];
        
        
        LVC = [[FLLoginViewController alloc]init];
        FLAppDelegate * appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
        [appDelegate.window setRootViewController:LVC];
        
        [self.view removeFromSuperview];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }else{
        
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"接続を確認してください。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
    }
    
}

- (IBAction)toAddphoto:(id)sender {
    
    //プロフィール写真のアップロード。以下デリゲートメソッドに移行
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
    imagePicker.allowsEditing = YES;
    
}



-(UIImage*)resizeImage:(UIImage*)img scale:(float)scale{
    
    CGSize resizedSize = CGSizeMake(img.size.width*scale, img.size.height*scale);
    UIGraphicsBeginImageContext(resizedSize);
    [img drawInRect:CGRectMake(0,0,resizedSize.width, resizedSize.height)];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
    
    
}


-(void)imagePickerController:(UIImagePickerController*)picker
didFinishPickingMediaWithInfo:(NSDictionary*)editingInfo{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    UIImage * toUpload = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    //サイズを半分にして送信する
    UIImage * resizedImage = [self resizeImage:toUpload scale:0.5 ];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString * ext = @".jpg";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSString * idtoPost = [NSString stringWithFormat:@"%d", idnumber];
    UIImage * img = resizedImage;
    NSData * imageData = UIImageJPEGRepresentation(img, 90);
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:ext, @"extension", idtoPost, @"userid",nil];
    NSString * urlString = @"http://flatlevel56.org/lovelog/labaccount.php";
    [_manager POST:urlString parameters:params constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Resposne: %@", responseObject);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //<#code#>
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}



- (IBAction)editPushed:(id)sender {
    
    FLEditViewController * EVC = [[FLEditViewController alloc]init];
    [self.navigationController pushViewController:EVC animated:YES];
    
}



@end
