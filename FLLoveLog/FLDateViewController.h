//
//  DateViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/08/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLDateViewController : UIViewController{
    
    
    __weak IBOutlet UITextField *dateField;
    __weak IBOutlet UIDatePicker *dp;
    __weak IBOutlet UIButton *doneButton;
    
    
}

@property (weak, nonatomic) IBOutlet UIDatePicker *dp;
- (IBAction)dateChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)toMake:(id)sender;



@end
