//
//  CardTextViewController.h
//  LOVEDRILL
//
//  Created by 立花 法美 on 2013/03/31.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLCardTextViewController : UIViewController<UITextViewDelegate>{
    
    __weak IBOutlet UIImageView *cardImage;
    __weak IBOutlet UITextView *cardMessage;
    __weak IBOutlet UIScrollView *scrollView;
}

//外部アクセスあり
@property(strong, nonatomic)NSString * cardName;
@property(strong, nonatomic)NSString * textValue;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UITextView *cardMessage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
