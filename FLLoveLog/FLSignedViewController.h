//
//  SignedViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/01/15.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FLSignedViewController :UIViewController
{
   
    __weak IBOutlet UIScrollView *scrollView;
}


@property (weak, nonatomic) IBOutlet UILabel *loverNameField;
@property(nonatomic, copy)NSString* loverName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)dismissSCVC:(id)sender;
@end



  
    
