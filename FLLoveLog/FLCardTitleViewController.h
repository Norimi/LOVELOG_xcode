//
//  CardTitleViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/04/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBErrorNoticeView.h"



@interface FLCardTitleViewController : UIViewController{
    
    
    __weak IBOutlet UIImageView *cardImage;
    __weak IBOutlet UITextView *messageView;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UITextField *titleField;
    
    WBErrorNoticeView * notice;
    
}

//cardtextviewcontrollerからアクセス
@property(strong, nonatomic)NSString * cardtoSend;
@property(strong, nonatomic)NSString * message;
@property(strong, nonatomic)NSString * titleString;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *messageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


- (IBAction)endTitle:(id)sender;

@end
