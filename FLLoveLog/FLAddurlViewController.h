//
//  AddurlViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/05/28.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLAddurlViewController : UIViewController{
    
    __weak IBOutlet UIButton *addButton;
    __weak IBOutlet UITextField *urlField;
}
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *urlField;
@property(strong, nonatomic)NSString * urlString;

- (IBAction)tapButton:(id)sender;
- (IBAction)endEnter:(id)sender;

@end
