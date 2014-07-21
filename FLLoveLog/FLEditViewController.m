//
//  EditViewController.m
//  sendMsg7
//
//  Created by 立花 法美 on 2013/02/14.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "FLEditViewController.h"
#import "FLAccountViewController.h"
#import "FLLoginViewController.h"
#import "FLAppDelegate.h"
#import "FLConnection.h"

@interface FLEditViewController ()
@property(strong, nonatomic)NSString * nowTagStr;
@property(strong, nonatomic)NSString * userName;
@property(strong, nonatomic)NSString * email;
@property(strong, nonatomic)NSString * password;
@property Boolean inUsername;
@property Boolean inEmail;
@property Boolean inPassword;

@end

@implementation FLEditViewController


@synthesize nameField, emailField, passwordField, addPhoto, nowTagStr, userName, email, password, inUsername, inEmail, inPassword;


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


- (void)viewWillAppear:(BOOL)animated {
    
    passwordField.secureTextEntry = YES;
    [self->scrollView setContentSize:CGSizeMake(320, 620)];
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc]initWithTitle:@"送信"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(sendClicked:)];
    
    [[self navigationItem]setRightBarButtonItem:bbi];
    
    NSURL * myURL = [NSURL URLWithString:@"http://norimingconception.net/accountviewcontrollerxml.php"];
    NSXMLParser * myParser = [[NSXMLParser alloc]initWithContentsOfURL:myURL];
    myParser.delegate = self;
    [myParser parse];
    
    
}

-(void)parserDidStartDocument:(NSXMLParser*)parser
{
    nowTagStr = @"";
}


-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName
   attributes:(NSDictionary*)attributeDict{
    
    
    if([elementName isEqualToString:@"content"]){
        
        nowTagStr = [NSString stringWithString:elementName];
        userName = @"";
        email = @"";
        
    }
    
    if([elementName isEqualToString:@"username"]){
        
        inUsername = YES;
        
    }
    
    if([elementName isEqualToString:@"email"]){
        
        inEmail = YES;
    }
    
    if([elementName isEqualToString:@"password"]){
        
        inPassword = YES;
    }
}


-(void)parser:(NSXMLParser*)parser
foundCharacters:(NSString*)string {
    
    if(inUsername){
        
        userName = [userName stringByAppendingString:string];
        
    }
    
    if(inEmail) {
        
        email = [email stringByAppendingString:string];
        
    }
    
    if(inPassword){
        
        password = [password stringByAppendingString:string];
    }
    
}

-(void)parser:(NSXMLParser*)parser
didEndElement:(NSString*)elementName
 namespaceURI:(NSString*)namespaceURI
qualifiedName:(NSString*)qName

{
    
    if([elementName isEqualToString:@"content"]){
        
        
        if([nameField.text length]==0){
            nameField.text = [nameField.text stringByAppendingFormat:@"%@", userName];
            emailField.text = [emailField.text stringByAppendingFormat:@"%@", email];
        }
        
    }
    
    if([elementName isEqualToString:@"username"]){
        
        inUsername = NO;
    }
    
    if([elementName isEqualToString:@"email"]){
        
        inEmail = NO;
        
    }
    
    if([elementName isEqualToString:@"password"]){
        
        inPassword = NO;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
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


-(void)sendClicked:(id)sender{
    
    if([nameField.text length]>0 & [emailField.text length]>0 & [passwordField.text length]>0){
        
        FLConnection * connection = [[FLConnection alloc]init];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        int idnumber = [defaults integerForKey:@"mid"];
        NSString * url = [NSString stringWithFormat:@"http://norimingconception.net/lovelog/editviewcontroller.php"];
        NSString * data = [NSString stringWithFormat:@"name=%@&email=%@&password=%@&id=%d", nameField.text, emailField.text, passwordField.text, idnumber];
        if([connection connectionWithUrl:url withData:data]){
            
            FLLoginViewController * LVC = [[FLLoginViewController alloc]init];
            FLAppDelegate * appDelegate = (FLAppDelegate*)[[UIApplication sharedApplication]delegate];
            [appDelegate.window setRootViewController:LVC];
            [self.view removeFromSuperview];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

            
        }else{
            
            notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
            [notice show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            
        }
    }
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
    
    
    FLAccountViewController * AVC = [[FLAccountViewController alloc]init];
    UIImage * myPhoto = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(myPhoto);
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"myimage"];
  
    [self dismissViewControllerAnimated:YES completion:^{
        
         [[self navigationController]pushViewController:AVC animated:YES];
    
    }];
   
}



- (IBAction)enteredName:(id)sender {
    
    [nameField resignFirstResponder];
}

- (IBAction)enteredEmail:(id)sender {
    
    
    [emailField resignFirstResponder];
}

- (IBAction)enteredPassword:(id)sender {
    
    [passwordField resignFirstResponder];
}


@end
