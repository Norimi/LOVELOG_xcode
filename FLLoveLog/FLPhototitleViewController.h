//
//  PhototitleViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/22.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "WBErrorNoticeView.h"





@interface FLPhototitleViewController : UIViewController{
    
    __weak IBOutlet UIImageView *choosedImage;
    __weak IBOutlet UITextField *titleField;
    WBErrorNoticeView * notice;
}
@property (weak, nonatomic) IBOutlet UIImageView *choosedImage;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic)UIImage * toShow;
@property(strong, nonatomic)UIImage * resizedImage2;
- (IBAction)enteredText:(id)sender;

@end
