//
//  LoginViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/16.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"


@interface FLLoginViewController : UIViewController<NSXMLParserDelegate, UITabBarControllerDelegate>{
    
     __weak IBOutlet UIScrollView *scrollView;
    
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)toTabbar:(id)sender;
- (IBAction)enteredEmail:(id)sender;
- (IBAction)enteredPassword:(id)sender;



@end
