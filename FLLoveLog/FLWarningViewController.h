//
//  WarningViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/21.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FLWarningViewController : UIViewController<NSXMLParserDelegate, MFMailComposeViewControllerDelegate>
{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *mailButton;
    
}

@property NSString * loverName;
@property NSString * loverNumber;
@property (weak, nonatomic) IBOutlet UILabel *nameConfirm;
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *numberField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *mailButton;
- (IBAction)toWaiting:(id)sender;
- (IBAction)sendMail:(id)sender;

@end
