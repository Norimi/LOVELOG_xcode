//
//  MyChatCell.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/10.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>


@interface MyChatCell : UITableViewCell{
    
    
    UIButton * loveInd;
    UIButton * loveInd2;
    UIButton * loveInd3;
    UIButton * loveInd4;
    UIButton * loveInd5;
    CGSize * textsize;
    
    NSString * tmpIndicator;
    int loveIndicator;
    
    
    SystemSoundID soundID;
    
 
    __weak IBOutlet UILabel *dateLabel;
    
    __weak IBOutlet UILabel *mychatLabel;
    
    __weak IBOutlet UIImageView *profilePhoto;
    
    
    //indicator送信の際に渡す値をstringにして
    
    NSString * chatid;
    
    
    NSDictionary * params;
    
    
    int labelHeight;
    int labelWidth;
    
    
    
}

@property (weak, nonatomic) IBOutlet UILabel *mychatLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;

@property(strong, nonatomic)NSString * tmpIndicator;

@property int loveIndicator;

@property(strong, nonatomic)NSString * chatid;
@property(strong, nonatomic)NSString * indicator;
@property CGSize * textsize;
@property int labelHeight;
@property int labelWidth;


@end

