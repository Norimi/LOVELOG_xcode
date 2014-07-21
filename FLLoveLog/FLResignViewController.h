//
//  ResignViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/02/27.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"

@interface FLResignViewController : UIViewController
{
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *deleteAll;
    WBErrorNoticeView * notice;
    
}
- (IBAction)deleteAll:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
