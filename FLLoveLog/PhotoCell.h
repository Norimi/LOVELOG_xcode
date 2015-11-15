//
//  PhotoCell.h
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/16.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AFNetworking.h"

@interface PhotoCell : UITableViewCell{
    
    
    UIButton * loveInd;
    UIButton * loveInd2;
    UIButton * loveInd3;
    UIButton * loveInd4;
    UIButton * loveInd5;
    
    __weak IBOutlet UIImageView *photoView;
    
    
    __weak IBOutlet UILabel *titleLabel;
    
    //それぞれviewcontrollerから渡される。
    
    int loveIndicator;
    int frompartnerInd;

    NSString * photoid;
    NSString *  userid;
    NSString * tString;
    NSString * params;
  
    
    __weak IBOutlet UILabel *partnerLabel;

    __weak IBOutlet UILabel *myLabel;
    
    NSString * indicator;
    
    
     SystemSoundID soundID;
    
    
    Boolean myPhoto;
    
    
}


//ラブインジケーター画像のはしっこにボーダーを。
//条件分岐により、UIImageを左右に。ボタンの表示か画像の表示か。
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *partnerLabel;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property int loveIndicator;
@property int frompartnerInd;
@property(strong, nonatomic)NSString * indicator;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property(strong, nonatomic)NSString * photoid;
@property(strong, nonatomic)NSString * userid;
@property(strong, nonatomic)NSString * tString;

@end
