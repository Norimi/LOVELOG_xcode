//
//  ConfirmViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/03/05.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLConfirmViewController : UIViewController<NSXMLParserDelegate>
{
    
    __weak IBOutlet UILabel *emailLabel;
    __weak IBOutlet UILabel *passwordLabel;
    __weak IBOutlet UIScrollView *scrollView;
    
}

@property NSString * email;
@property NSString * password;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
- (IBAction)toSigned:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
