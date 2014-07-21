//
//  PartnerAcViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FLPartnerAcViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    
    __weak IBOutlet UIButton *emailButton;
    __weak IBOutlet UIButton *phoneButton;
    __weak IBOutlet UIButton *smsButton;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *indiValue;
    __weak IBOutlet UIImageView *partnerImage;
    __weak IBOutlet UIScrollView *scrollView;
    UIImage * addedPhoto;
}
@property (weak, nonatomic) IBOutlet UIButton *smsButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *partnerImage;
@property(strong, nonatomic)NSString * email;
@property(strong, nonatomic)NSString * telNumber;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong, nonatomic)UIImage * addedPhoto;
@property (weak, nonatomic) IBOutlet UILabel *indiValue;
@property (weak, nonatomic) IBOutlet UIButton *addAddress;

- (IBAction)sendEmail:(id)sender;
- (IBAction)callPhone:(id)sender;
- (IBAction)sendSMS:(id)sender;


@end
