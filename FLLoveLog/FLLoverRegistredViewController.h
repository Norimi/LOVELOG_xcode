//
//  LoverRegistredViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/23.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLLoverRegistredViewController : UIViewController<NSXMLParserDelegate>
{
    __weak IBOutlet UILabel *userName;
    __weak IBOutlet UILabel *loverName;
    __weak IBOutlet UIScrollView *scrollView;
    
}
- (IBAction)toLogin:(id)sender;

@property NSString * nowTagStr;
@property NSString * username;
@property NSString * partnername;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *loverName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
