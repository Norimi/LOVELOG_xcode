//
//  ChatlogViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"

@interface FLChatlogViewController : UIViewController{
    
    __weak IBOutlet UITextView *chatField;
    UIButton * loveInd;
    UIButton * loveInd2;
    UIButton * loveInd3;
    UIButton * loveInd4;
    UIButton * loveInd5;
    
    __weak IBOutlet UIScrollView *scrollView;
    int loveIndicator;
    
}
@property (weak, nonatomic) IBOutlet UITextView *chatField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
-(IBAction)sendClicked:(id)sender;

@end
