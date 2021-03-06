//
//  PhototitleViewController.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/22.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLPhototitleViewController.h"
#import "AFNetworking.h"
@interface FLPhototitleViewController ()
@property AFHTTPRequestOperationManager * manager;
@property UIBarButtonItem * bbi;
@end

@implementation FLPhototitleViewController
@synthesize toShow, titleField,choosedImage,resizedImage2,bbi;

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

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UIImage*resizedImage = [self resizeImage:toShow scale:0.5];
    choosedImage.image = resizedImage;
    resizedImage2 = resizedImage;
  
    bbi = [[UIBarButtonItem alloc]initWithTitle:@"送信"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(upClicked:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    
      
}


-(UIImage*)resizeImage:(UIImage*)img scale:(float)scale{
    
    
    CGSize resizedSize = CGSizeMake(img.size.width*scale, img.size.height*scale);
    
    UIGraphicsBeginImageContext(resizedSize);
    [img drawInRect:CGRectMake(0,0,resizedSize.width, resizedSize.height)];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return resizedImage;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setChoosedImage:nil];
    [self setTitleField:nil];
    choosedImage = nil;
    titleField = nil;
    [super viewDidUnload];
}
- (IBAction)enteredText:(id)sender {
    
    [titleField resignFirstResponder];
    
}


-(void)upClicked:(id)sender{
    
    //ボタンを非活性にする
    [bbi setEnabled:false];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * ext = @".jpg";
    NSString * title = titleField.text;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    NSString * idtoPost = [NSString stringWithFormat:@"%d", idnumber];
    NSData * imageData = UIImageJPEGRepresentation(resizedImage2, 90);
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            title, @"title",
                            ext, @"extension", idtoPost, @"userid", nil];
    NSString * urlString = @"http://flatlevel56.org/lovelog/photoviewcontroller.php";
    
    
    _manager = [AFHTTPRequestOperationManager manager];
    [_manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:@"upfile" fileName:@"title" mimeType:@"image/jpeg"];
        NSLog(@"通信開始: %@");
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if([operation.response statusCode] == 403){
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"エラーが検出されました。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            return;
        
        }
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //[self.navigationController popToRootViewControllerAnimated:YES];
        //最終的にボタンを活性にする
        [bbi setEnabled:true];

    }];
    

    
    
    
}

    

@end
