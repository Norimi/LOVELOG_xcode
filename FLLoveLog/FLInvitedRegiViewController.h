//
//  InvitedRegiViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/24.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLInvitedRegiViewController : UIViewController{
    
    __weak IBOutlet UIScrollView *scrollView;
    
    
}
- (IBAction)toConfirm:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


- (IBAction)putEmail:(id)sender;
- (IBAction)putPassword:(id)sender;
- (IBAction)putName:(id)sender;



@end
