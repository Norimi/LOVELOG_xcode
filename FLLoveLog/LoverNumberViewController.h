//
//  LoverNumberViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/19.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoverNumberViewController : UIViewController<NSXMLParserDelegate>
{
    __weak IBOutlet UILabel *lovernameField;
    __weak IBOutlet UILabel *lovernumberField;
    __weak IBOutlet UIScrollView *scrollView;
}

@property NSString * loverName;
@property NSString * loverNumber;
@property (weak, nonatomic) IBOutlet UILabel *lovernameField;
@property (weak, nonatomic) IBOutlet UILabel *lovernumberField;
- (IBAction)toWarning:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
