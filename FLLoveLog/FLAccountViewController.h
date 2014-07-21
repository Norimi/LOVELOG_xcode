//
//  AccountViewController.h
//  sendMsg7
//
//  Created by 立花 法美 on 2013/02/14.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBErrorNoticeView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"



@interface FLAccountViewController : UIViewController<NSXMLParserDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    
    WBErrorNoticeView* notice;
    
    __weak IBOutlet UIButton *addPhoto;
    __weak IBOutlet UIImageView *myImage;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UILabel *mynameLabel;
    __weak IBOutlet UILabel *emailLabel;
    __weak IBOutlet UIButton *toEdit;
    __weak IBOutlet UILabel *indiLabel;
    
    Boolean inPartnername;
    Boolean inUsername;
    Boolean inEmail;
    Boolean inNumber;
    
    __weak IBOutlet UIButton *logOut;
    __weak IBOutlet UIButton *resign;
}

- (IBAction)logOut:(id)sender;
- (IBAction)reSign:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *mynameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addPhoto;
@property (weak, nonatomic) IBOutlet UIButton *logOut;
@property (weak, nonatomic) IBOutlet UIButton *resign;
@property (weak, nonatomic) IBOutlet UIButton *toEdit;
@property (weak, nonatomic) IBOutlet UILabel *indiLabel;

- (IBAction)editPushed:(id)sender;
- (IBAction)toAddphoto:(id)sender;

@end
