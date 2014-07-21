//
//  WaitingViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/21.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLWaitingViewController : UIViewController<NSXMLParserDelegate>
{
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *waitImage;
    __weak IBOutlet UILabel *titleName;
    __weak IBOutlet UILabel *nameField;
    __weak IBOutlet UILabel *lovernameLabel;
    __weak IBOutlet UILabel *codeLabel;
}


@property NSString * lovername;
@property NSString * lvercode;
@property NSString * lovercode;
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *lovernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property NSTimer * time;

@end
