//
//  InvitedViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/23.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLInvitedViewController : UIViewController<NSXMLParserDelegate>
{
    
    __weak IBOutlet UIScrollView *scrollView;
   
}

- (IBAction)toEmail:(id)sender;
- (IBAction)putName:(id)sender;
- (IBAction)putNumber:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;



@end
