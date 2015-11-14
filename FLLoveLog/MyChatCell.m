//
//  MyChatCell.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/10.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "MyChatCell.h"
#import "AFNetworking.h"


@interface MyChatCell()
@property AFHTTPRequestOperationManager * manager;
@end

@implementation MyChatCell
@synthesize mychatLabel, loveIndicator,chatid, indicator, textsize, labelHeight, labelWidth, tmpIndicator,dateLabel,profilePhoto;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //init時に通信用のインスタンスを一つ作成
        _manager = [AFHTTPRequestOperationManager manager];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


-(void)setLoveIndicatorButtons{
    
    
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSURL * URL;
    URL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"heartsound2" ofType:@"wav"] isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &soundID);
    
    UIImage * img = [UIImage imageNamed:@"heartbuttonpink.png"];
    UIImage * img2 = [UIImage imageNamed:@"heartbuttongray.png"];
    
    if([self.reuseIdentifier isEqual: @"YourChatCell"]){
        
        //パートナー用のセルの設定：インジケーターはボタン
        loveInd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loveInd2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loveInd3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        loveInd.adjustsImageWhenHighlighted = NO;
        loveInd.highlighted = NO;
        
        [loveInd setBackgroundImage:img2 forState:UIControlStateNormal];
        [loveInd setBackgroundImage:img forState:UIControlStateSelected];
        [loveInd2 setBackgroundImage:img2 forState:UIControlStateNormal];
        [loveInd2 setBackgroundImage:img forState:UIControlStateSelected];
        [loveInd3 setBackgroundImage:img2 forState:UIControlStateNormal];
        [loveInd3 setBackgroundImage:img forState:UIControlStateSelected];
       
        
        loveInd.frame = CGRectMake(2, 70, 10, 10);
        loveInd2.frame = CGRectMake(24, 70, 10, 10);
        loveInd3.frame = CGRectMake(46, 70, 10, 10);
        

        [loveInd addTarget:self
                    action:@selector(toTouched:)
          forControlEvents:UIControlEventTouchUpInside];
        
        [loveInd2 addTarget:self
                     action:@selector(toTouched2:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [loveInd3 addTarget:self
                     action:@selector(toTouched3:)
           forControlEvents:UIControlEventTouchUpInside];
       
        loveIndicator = [tmpIndicator intValue];
        
        
        if(loveIndicator == 1){
            
            [loveInd setSelected:YES];
            
        }
        
        
        if(loveIndicator == 2){
            
            [loveInd setSelected:YES];
            [loveInd2 setSelected:YES];
            
            
        }
        
        if(loveIndicator == 3){
            
            [loveInd setSelected:YES];
            [loveInd2 setSelected:YES];
            [loveInd3 setSelected:YES];
            
        }
        
   
        
        
        [self addSubview:loveInd];
        [self addSubview:loveInd2];
        [self addSubview:loveInd3];
        
        
    } else {
        
        //自分用のセルの設定：インジケーターは画像
        UIImageView * photo = [[UIImageView alloc]initWithImage:nil];
        photo = [[UIImageView alloc] initWithFrame:CGRectMake(264, 65, 53, 8)];
        
        
        UIImage * image0 = [UIImage imageNamed:@"0heart.png"];
        UIImage *image1 = [UIImage imageNamed:@"1heart.png"];
        UIImage * image2 = [UIImage imageNamed:@"2hearts.png"];
        UIImage * image3 = [UIImage imageNamed:@"3hearts.png"];
        
        
        loveIndicator = [tmpIndicator intValue];
        
        
        if(loveIndicator == 0){
            
            photo.image = image0;
            
        } else if(loveIndicator == 1){
            
            photo.image = image1;
            
        } else if(loveIndicator == 2){
            
            photo.image = image2;
            
            
        } else if(loveIndicator == 3){
            
            photo.image = image3;
            
            
        }
        
        [self addSubview:photo];
    }

    
}



-(void)layoutSubviews{
    
    
    [super layoutSubviews];
    self.textLabel.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:11];
    self.textLabel.font = font;
    if([self.reuseIdentifier isEqual: @"MyChatCell"]){
        
        CGRect frame = CGRectMake(15.0,30.0, labelWidth, labelHeight);
        
        self.textLabel.frame = frame;
        self.textLabel.contentMode = UIViewContentModeScaleAspectFit;
    
    } else {
        
        CGRect frame = CGRectMake(85.0,30.0, labelWidth, labelHeight);
        self.textLabel.frame = frame;
        self.textLabel.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    [self setLoveIndicatorButtons];
    
    
  }




-(void)toTouched:(id)sender{
    
    if(!loveInd2.selected){
        if(!loveInd3.selected){
            
                    loveInd.selected = !loveInd.selected;
                    if(loveInd.selected){
                        //他のボタンが全て選択状態でない場合に一つ目のボタンを押したことによって選択状態になった場合
                        //選択されたそのときにサウンドを出す
                        AudioServicesPlaySystemSound(soundID);
                        [self setIndicatorWithValue:@"1"];
                    } else {
                        
                        
                       [self setIndicatorWithValue:@"0"];
                        
                
            }
        }
    }
    
    
}

-(IBAction)toTouched2:(id)sender{
    if(loveInd.selected){
        if(!loveInd3.selected){
            loveInd2.selected = !loveInd2.selected;
                    if(loveInd2.selected){
                        AudioServicesPlaySystemSound(soundID);
                        [self setIndicatorWithValue:@"2"];
                        
                    } else {
                        
                        [self setIndicatorWithValue:@"1"];                    }
                    
                }
            }
    
    
}


-(IBAction)toTouched3:(id)sender{
    if(loveInd.selected){
        if(loveInd2.selected){
            if(!loveInd4.selected){
                if(!loveInd5.selected){
                    loveInd3.selected = !loveInd3.selected;
                    if(loveInd3.selected){
                        
                        AudioServicesPlaySystemSound(soundID);
                        [self setIndicatorWithValue:@"3"];
                  
                    } else {
                        [self setIndicatorWithValue:@"2"];
                    }
                    
                }
            }
        }
    }
}


-(void)setIndicatorWithValue:(NSString*)value{
    

    params = [NSDictionary dictionaryWithObjectsAndKeys:
              chatid, @"chatid",
              value, @"indicator",
              nil];
    
    [_manager POST:@"http://flatlevel56.org/lovelog/chatindicator.php" parameters:params constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Resposne: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //<#code#>
    }];
    
}




@end
