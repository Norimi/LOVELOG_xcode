//
//  EditViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/02/14.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"

/**
 * アカウント情報を編集するためのviewcontroller
 *
 */
@interface FLEditViewController : UIViewController<NSXMLParserDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    __weak IBOutlet UIButton *addPhoto;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UITextField *passwordField;
    
    WBErrorNoticeView * notice;
    
}
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *addPhoto;

- (IBAction)addPhoto:(id)sender;

- (IBAction)enteredName:(id)sender;
- (IBAction)enteredEmail:(id)sender;
- (IBAction)enteredPassword:(id)sender;





@end
