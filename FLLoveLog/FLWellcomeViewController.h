//
//  WellcomeViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/22.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLWellcomeViewController : UIViewController{
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *firstButton;
    __weak IBOutlet UIButton *loginButton;
    __weak IBOutlet UIButton *invitedButton;
}
- (IBAction)toFirst:(id)sender;
- (IBAction)toInvited:(id)sender;
- (IBAction)toLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *logIn;
@property (weak, nonatomic) IBOutlet UIButton *toLogin;

@end
