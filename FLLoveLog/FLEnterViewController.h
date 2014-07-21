//
//  EnterViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/03/05.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLEnterViewController : UIViewController <NSXMLParserDelegate>{
    
    __weak IBOutlet UIScrollView *scrollView;
    
}


@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


- (IBAction)toConfirme:(id)sender;
- (IBAction)inputEmail:(id)sender;
- (IBAction)inputPassword:(id)sender;

@end
