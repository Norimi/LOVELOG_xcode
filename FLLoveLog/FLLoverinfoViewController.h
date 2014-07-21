//
//  LoverinfoViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBSuccessNoticeView.h"

@interface FLLoverinfoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *addPhoto;
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UITextField *telField;
    WBSuccessNoticeView * notice;
}

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
