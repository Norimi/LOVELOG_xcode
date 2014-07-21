//
//  LovernameViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/19.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLLovernameViewController : UIViewController{
    
    __weak IBOutlet UIScrollView *scrollView;
    
}
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *lovernameField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)toLoverNumber:(id)sender;
- (IBAction)inputUsername:(id)sender;
- (IBAction)inputLovername:(id)sender;

@end
