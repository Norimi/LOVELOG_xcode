//
//  LoverinfoViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLLoverinfoViewController.h"
#import "FLPartnerAcViewController.h"


@interface FLLoverinfoViewController ()
@property(strong, nonatomic)UIImage * toPartner;
@end

@implementation FLLoverinfoViewController
@synthesize scrollView, emailField, telField, toPartner;

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
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"保存"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(saveClicked:)];
    [[self navigationItem]setRightBarButtonItem:bbi];
    [self->scrollView setContentSize:CGSizeMake(320, 520)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPhoto:(id)sender {
    
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
    imagePicker.allowsEditing = YES;
    
}

-(void)imagePickerController:(UIImagePickerController*)picker
       didFinishPickingMediaWithInfo:(NSDictionary*)editingInfo{
  
   toPartner = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    FLPartnerAcViewController * PAVC = [[FLPartnerAcViewController alloc]initWithNibName:@"PartnerAcViewController" bundle:nil];
    PAVC.addedPhoto = toPartner;
    NSData *imageData = UIImagePNGRepresentation(self.toPartner);
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"partnerimage"];
   
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[self navigationController]pushViewController:PAVC animated:YES];
    }];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}




-(void)saveClicked:(id)sender{
    //userdefaultsに保存
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * emailString = emailField.text;
    [defaults setObject:emailString forKey:@"partneremail"];
    NSString * telString = telField.text;
    [defaults setObject:telString forKey:@"partnertel"];
    [defaults synchronize];
    
    
    if(emailString.length > 0 || telString.length > 0){
        notice = [WBSuccessNoticeView successNoticeInView:self.view title:@"設定が保存されました。"];
        [notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
}


-(void)didreceivememorywarning {
   
    toPartner = nil;
    [super didReceiveMemoryWarning];
    
}


@end
