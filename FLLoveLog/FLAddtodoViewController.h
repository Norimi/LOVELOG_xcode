//
//  AddtodoViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLAddtodoViewController : UIViewController{
    
    
    __weak IBOutlet UITextField *todoField;
    __weak IBOutlet UIButton *addButton;
    NSString * urlString;
    
}
@property (weak, nonatomic) IBOutlet UITextField *todoField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addTodo:(id)sender;

@property(strong, nonatomic)NSString * todoString;
- (IBAction)enteredTodo:(id)sender;

@end
