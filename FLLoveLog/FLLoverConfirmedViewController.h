//
//  LoverConfirmedViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/23.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLLoverConfirmedViewController : UIViewController<NSXMLParserDelegate>
{
  
    __weak IBOutlet UIScrollView *scrollView;
}

- (IBAction)toRegistred:(id)sender;

@property NSString * email;
@property NSString * password;
@property NSString * lovername;
@property (weak, nonatomic) IBOutlet UILabel *emailField;
@property (weak, nonatomic) IBOutlet UILabel *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
