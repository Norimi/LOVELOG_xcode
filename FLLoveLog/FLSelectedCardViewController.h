//
//  SelectedCardViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/04/01.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLSelectedCardViewController : UIViewController{
    
    __weak IBOutlet UIImageView *cardView;
    __weak IBOutlet UITextView *messageView;
    __weak IBOutlet UIScrollView *scrollView;

    
}
@property (weak, nonatomic) IBOutlet UIImageView *cardView;
@property (weak, nonatomic) IBOutlet UITextView *messageView;
@property(strong, nonatomic)NSString * message;
@property(strong, nonatomic)NSString * imageName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
