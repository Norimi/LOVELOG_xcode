//
//  PartnerAcViewController.m
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLPartnerAcViewController.h"
#import "FLLoverinfoViewController.h"
#import "FLAccountViewController.h"
#import "AFNetworking.h"
#import "FLLoverinfoViewController.h"

@interface FLPartnerAcViewController ()

@end

@implementation FLPartnerAcViewController

FLLoverinfoViewController * LIVC;

@synthesize emailButton, phoneButton, smsButton, nameLabel, email, telNumber, partnerImage, scrollView, addedPhoto, indiValue,addAddress;

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
    
}

-(void)viewWillAppear:(BOOL)animated{

        
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"設定"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(infoClicked:)];
    
    [[self navigationItem]setRightBarButtonItem:bbi];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * pName = [defaults stringForKey:@"pname"];
    nameLabel.text = pName;
    int pindi = [defaults integerForKey:@"psum"];
    int pphotosum = [defaults integerForKey:@"pphotosum"];
    int sum = pindi + pphotosum;
    NSString * value = [[NSString stringWithFormat:@"♡%d", sum]init];
    indiValue.text = value;
    
    NSString * profile = @"http://flatlevel56.org/lovelog/profile_photos/";
    NSString * file = [defaults stringForKey:@"partnerphoto"];
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",profile, file];
    [partnerImage setImageWithURL:[NSURL URLWithString:postUrl]placeholderImage:[UIImage imageNamed:@"backgroundview.png"]];
    [partnerImage setContentMode:UIViewContentModeScaleAspectFill];
    
    
    if(pName.length == 0){
        
        nameLabel.text = @"パートナーはLOVE LOGを退会されています。";
        nameLabel.font = [UIFont systemFontOfSize:9];
        
    }
    
    [self->scrollView setContentSize:CGSizeMake(320, 460)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmail:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * partnermail = [NSString stringWithFormat:@"%@", [defaults objectForKey:@"partneremail"]];
    
    
    
    if(partnermail){
        
    MFMailComposeViewController * mc = [[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate = self;
        
        if (!mc) {
            // When the device is not add mail account mailViewController is empty, the following present view controller will cause the program to crash, here to judge
            NSLog(@"Device is not add mail accounts");
        }else{
            
            [mc  setToRecipients:[NSArray arrayWithObjects:partnermail,nil]];
            [self presentViewController:mc animated:YES completion:NULL];
            
            
        }
    }
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
   
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)callPhone:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * partnertel = [NSString stringWithFormat:@"tel:%@", [defaults objectForKey:@"partnertel"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:partnertel]];
}

- (IBAction)sendSMS:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * partnersms = [NSString stringWithFormat:@"sms:%@", [defaults objectForKey:@"partnertel"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:partnersms]];
}


-(void)toAccount:(id)sender{
    
    FLAccountViewController * AVC = [[FLAccountViewController alloc]init];
      [[self navigationController]pushViewController:AVC animated:YES];
    
    
}

-(void)infoClicked:(id)sender {
    
    FLLoverinfoViewController * LIVC = [[FLLoverinfoViewController alloc]init];
    
    // Animation定義開始
    [UIView  beginAnimations:nil context:NULL];
    // Animationの速度設定：徐々に加速
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // Animation実行時間：0.75秒
    [UIView setAnimationDuration:0.75];
    // 次画面遷移
    [self.navigationController pushViewController:LIVC  animated:NO];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    // Animation開始
    [UIView commitAnimations];
    
    
}
- (IBAction)addAddress:(id)sender {
    
    FLLoverinfoViewController * LIVC = [[FLLoverinfoViewController alloc]init];
    [self.navigationController pushViewController:LIVC animated:YES];
    
    
}
@end
