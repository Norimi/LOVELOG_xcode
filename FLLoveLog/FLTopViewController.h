//
//  TopViewController.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/16.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FLTopViewController : UIViewController<NSXMLParserDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
   
    __weak IBOutlet UIButton *youraccountButton;
    __weak IBOutlet UIButton *myaccountButton;
    __weak IBOutlet UIImageView *topImage;
    __weak IBOutlet UIImageView *yourImage;
    __weak IBOutlet UIImageView *myImage;
    NSMutableData * receivedData;
    __weak IBOutlet UIButton *toPlan;
    
    NSString * fileString;
    NSString * titleString;
    NSString * userphotoString;
    NSString * partnerphotoString;
    NSString * plantitle;
    NSString * mychatString;
    NSString * yourchatString;
    
    Boolean inFilename;
    Boolean inTitle;
    Boolean inUserphoto;
    Boolean inPartnerphoto;
    Boolean inPlantitle;
    Boolean inMychat;
    Boolean inYourchat;
    
    
    __weak IBOutlet UIButton *toChatview;
    __weak IBOutlet UIButton *toPhoto;
    __weak IBOutlet UILabel *planLabel;
    NSDictionary * filenamedict;
    __weak IBOutlet UILabel *mychatLabel;
    __weak IBOutlet UILabel *yourchatLabel;
}

@property (weak, nonatomic) IBOutlet UIButton *youraccountButton;
@property (weak, nonatomic) IBOutlet UIButton *myaccountButton;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UIImageView *yourImage;
@property(strong, nonatomic)NSDictionary * filenamedict;
@property (weak, nonatomic) IBOutlet UIButton *toPlan;

- (IBAction)toyourAccount:(id)sender;
- (IBAction)tomyAccount:(id)sender;
- (IBAction)tochatView:(id)sender;
- (IBAction)toplanView:(id)sender;
- (IBAction)tophotoView:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *planLabel;
@property (weak, nonatomic) IBOutlet UIButton *toChatview;
@property (weak, nonatomic) IBOutlet UILabel *mychatLabel;
@property (weak, nonatomic) IBOutlet UILabel *yourchatLabel;
@property (weak, nonatomic) IBOutlet UIButton *toPhoto;


@property(strong, nonatomic)NSMutableData * receivedData;
@property(strong,nonatomic)NSString * fileString;
@property(strong, nonatomic)NSString * titleString;
@property(strong, nonatomic)NSString * userphotoString;
@property(strong, nonatomic)NSString * partnerphotoString;



@end
