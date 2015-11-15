//
//  PhotoCell.m
//  LOVE LOG
//
//  Created by 立花 法美 on 2013/07/16.
//  Copyright (c) 2013年 norimingconception.net. All rights reserved.
//

#import "PhotoCell.h"
#import "AFNetworking.h"
#import "FLConnection.h"

@interface PhotoCell()
@property AFHTTPRequestOperationManager * manager;
@end


@implementation PhotoCell
@synthesize loveIndicator, indicator, photoView, frompartnerInd, photoid, userid,titleLabel,tString, partnerLabel, myLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        for(UIView *view in self.contentView.subviews){
            if ([view isKindOfClass:[UIView class]]) {
                [view removeFromSuperview];
            }}
        // Initialization code
    }
    return self;
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString *  mName = [defaults stringForKey:@"mname"];
    NSString * pName = [defaults stringForKey:@"pname"];
    
    
    [myLabel setText:mName];
    [partnerLabel setText:pName];
    [titleLabel setText:tString];
    
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSURL * URL;
    URL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"heartsound2" ofType:@"caf"] isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &soundID);
    
    //自分の上げた写真のindi
    UIImageView * photo = [[UIImageView alloc]initWithImage:nil];
    photo = [[UIImageView alloc] initWithFrame:CGRectMake(24, 208, 100, 15)];
    UIImage * image0 = [UIImage imageNamed:@"heartsimages0.png"];
    UIImage *image1 = [UIImage imageNamed:@"heartsimages1.png"];
    UIImage * image2 = [UIImage imageNamed:@"heartsimages2.png"];
    UIImage * image3 = [UIImage imageNamed:@"heartsimages3.png"];
    UIImage * image4 = [UIImage imageNamed:@"heartsimages4.png"];
    UIImage * image5 = [UIImage imageNamed:@"heartsimages5.png"];
    
    
    
    
    if(frompartnerInd == 0){
        
        photo.image = image0;
        
    } else if(frompartnerInd == 1){
        
        photo.image = image1;
        
    } else if(frompartnerInd == 2){
        
        photo.image = image2;
        
        
    } else if(frompartnerInd == 3){
        
        photo.image = image3;
        
        
    } else if(frompartnerInd == 4){
        
        
        photo.image = image4;
        
    } else if(frompartnerInd == 5){
        
        photo.image = image5;
        
    }
    [self addSubview:photo];
    UIImage * img = [UIImage imageNamed:@"heartbuttonpink.png"];
    UIImage * img2 = [UIImage imageNamed:@"heartbuttongray.png"];
    //selectedのtagの取得。変数へ。そこの色を変える
    
    
    loveInd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loveInd2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loveInd3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loveInd4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loveInd5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    loveInd.adjustsImageWhenHighlighted = NO;
    loveInd5.adjustsImageWhenHighlighted = NO;
    loveInd2.adjustsImageWhenHighlighted = NO;
    loveInd3.adjustsImageWhenHighlighted = NO;
    loveInd4.adjustsImageWhenHighlighted = NO;
    
    
    [loveInd setBackgroundImage:img2 forState:UIControlStateNormal];
    [loveInd setBackgroundImage:img forState:UIControlStateSelected];
    
    [loveInd2 setBackgroundImage:img2 forState:UIControlStateNormal];
    [loveInd2 setBackgroundImage:img forState:UIControlStateSelected];
    
    [loveInd3 setBackgroundImage:img2 forState:UIControlStateNormal];
    [loveInd3 setBackgroundImage:img forState:UIControlStateSelected];
    
    [loveInd4 setBackgroundImage:img2 forState:UIControlStateNormal];
    [loveInd4 setBackgroundImage:img forState:UIControlStateSelected];
    
    [loveInd5 setBackgroundImage:img2 forState:UIControlStateNormal];
    [loveInd5 setBackgroundImage:img forState:UIControlStateSelected];
    
    
    
    loveInd.frame = CGRectMake(190, 205, 20, 20);
    loveInd2.frame = CGRectMake(215, 205, 20, 20);
    loveInd3.frame = CGRectMake(240, 205, 20, 20);
    loveInd4.frame = CGRectMake(265, 205, 20, 20);
    loveInd5.frame = CGRectMake(290, 205, 20, 20);
    
    
    [loveInd addTarget:self
                action:@selector(toTouched:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [loveInd2 addTarget:self
                 action:@selector(toTouched2:)
       forControlEvents:UIControlEventTouchUpInside];
    [loveInd3 addTarget:self
                 action:@selector(toTouched3:)
       forControlEvents:UIControlEventTouchUpInside];
    [loveInd4 addTarget:self
                 action:@selector(toTouched4:)
       forControlEvents:UIControlEventTouchUpInside];
    [loveInd5 addTarget:self
                 action:@selector(toTouched5:)
       forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //viewが登場したときに値をボタンに反映させるのように書く
    if(loveIndicator == 1){
        
        //selectedにsetする
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
    
    
    if(loveIndicator == 4){
        
        
        [loveInd setSelected:YES];
        [loveInd2 setSelected:YES];
        [loveInd3 setSelected:YES];
        [loveInd4 setSelected:YES];
        
    }
    
    if(loveIndicator == 5){
        
        
        [loveInd setSelected:YES];
        [loveInd2 setSelected:YES];
        [loveInd3 setSelected:YES];
        [loveInd4 setSelected:YES];
        
        [loveInd5 setSelected:YES];
        
    }
    
    
    
    //分岐を終えてからaddsubview
    
    [self.contentView addSubview:loveInd];
    [self.contentView addSubview:loveInd2];
    [self.contentView addSubview:loveInd3];
    [self.contentView addSubview:loveInd4];
    [self.contentView addSubview:loveInd5];
    
    
    
    
    //photoが自分のものであるかどうか確認。この場所でよいか検討
    
    
    NSInteger idnumber = [defaults integerForKey:@"mid"];
    int photoCreator = [userid intValue];
    
    
    if(photoCreator == idnumber){
        
        
        
        myPhoto = YES;
        
    } else {
        
        myPhoto = NO;
        
    }
    
    
    
}




-(void)toTouched:(id)sender{
    
    //contentsarrayの数を取得し、indexpathと同じか確かめる？
    if(!loveInd2.selected){
        if(!loveInd3.selected){
            if(!loveInd4.selected){
                if(!loveInd5.selected){
                    loveInd.selected = !loveInd.selected;
                    if(loveInd.selected){
                        
                        //上書きしながらひとつずつidicatorの値を送信。
                        
                        AudioServicesPlaySystemSound(soundID);
                        //ここに送信する値をpost入れる。
                        //photoidの取得。こちらに渡す。
                        //stringを送っていますが、サーバー内でintになるのでしょうか
                        //useridが自分であるとき＝myindicatorとなるintに変えて、userdefaultとの値を比べる。
                        //myphotoがYESのとき1をpostする。
                        
                        if(myPhoto == YES){
                           
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"1", @"1"];
                            
                        }else {
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"1", @"0"];
                        }
                        [self setIndicatorWithParam:params];
                        loveIndicator = 1;
                        
                        
                    } else {
                        
                        //ここにも入れる。
                        
                        if(myPhoto == YES){
                           
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"0", @"1"];
                            
                            
                        }else {
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"0", @"0"];
                            
                        }
                        
                        [self setIndicatorWithParam:params];
                        loveIndicator =0;
                    }
                }
            }
        }
    }
    
}

-(IBAction)toTouched2:(id)sender{
    
    if(loveInd.selected){
        if(!loveInd3.selected){
            if(!loveInd4.selected){
                if(!loveInd5.selected){
                    loveInd2.selected = !loveInd2.selected;
                    if(loveInd2.selected){
                        
                        if(myPhoto == YES){
                           
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"2", @"1"];
                            
                        }else {
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"2", @"0"];
                            
                        }
                        
                        [self setIndicatorWithParam:params];
                        
                        loveIndicator = 2;
                        AudioServicesPlaySystemSound(soundID);
                        
                        
                        
                    } else {
                        
                        
                        if(myPhoto == YES){
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"1", @"1"];
                            
                        }else {
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"1", @"0"];                        }
                        
                       
                    
                    }
                    
                    [self setIndicatorWithParam:params];
                    loveIndicator =1;
                    
                }
            }
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
                        
                        loveIndicator = 3;
                        AudioServicesPlaySystemSound(soundID);
                        if(myPhoto == YES){
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"3", @"1"];
                        }else {
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"3", @"0"];
                        }
                        
                        [self setIndicatorWithParam:params];
                        
                        
                    } else {
                        
                        
                        
                        if(myPhoto == YES){
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"2", @"1"];
                        }else {
                            
                           
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"2", @"0"];
                        }
                        
                        [self setIndicatorWithParam:params];
                        loveIndicator =2;
                    }
                    
                    
                    
                }
            }
        }
    }
}




-(IBAction)toTouched4:(id)sender{
    
    if(loveInd.selected){
        
        if(loveInd2.selected){
            
            if(loveInd3.selected){
                if(!loveInd5.selected){
                    
                    
                    
                    loveInd4.selected = !loveInd4.selected;
                    
                    
                    
                    if(loveInd4.selected){
                        
                        loveIndicator = 4;
                        AudioServicesPlaySystemSound(soundID);
                        
                        if(myPhoto == YES){
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"4", @"1"];
                            
                        }else {
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"4", @"0"];
                        }
                        
                        [self setIndicatorWithParam:params];
                        
                    } else {
                        
                        
                        
                        if(myPhoto == YES){
                            
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"3", @"1"];
                            
                            
                            
                        }else {
                            
                            params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"3", @"0"];
                            
                        }
                        
                        [self setIndicatorWithParam:params];
                        loveIndicator =3;
                    }
                    
                }
            }
        }
    }
}




-(IBAction)toTouched5:(id)sender{
    
    if(loveInd.selected){
        if(loveInd2.selected){
            if(loveInd3.selected){
                if(loveInd4.selected){
                    if(loveInd4.selected){
                        
                        
                        loveInd5.selected = !loveInd5.selected;
                        
                        
                        if(loveInd5.selected){
                            
                            loveIndicator = 5;
                            AudioServicesPlaySystemSound(soundID);
                            if(myPhoto == YES){
                                
                                
                                params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"5", @"1"];
                                
                            }else {
                                
                               
                                params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"5", @"0"];
                            }
                            
                            [self setIndicatorWithParam:params];
                            
                        } else {
                            
                            
                            if(myPhoto == YES){
                                
                                
                                params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"4", @"1"];
                            }else {
                                
                                params = [NSString stringWithFormat:@"photoid=%@&indicator=%d&myphoto=%d", photoid, @"4", @"0"];
                                
                            }
                            [self setIndicatorWithParam:params];
                            
                            
                            
                            loveIndicator =4;
                        }
                    }
                }
            }
        }
    }
    
}

-(void)setIndicatorWithParam:(NSString*)parameter{
    


    /*
    NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/chatlogviewcontroller.php"];

    FLConnection * connection = [[FLConnection alloc]init];
    if([connection connectionWithUrl:url withData:parameter]){
        
    }else{
        
        //WBErrorNoticeView * notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"接続エラー" message:@"ネットワーク接続を確認してください。"];
        //[notice show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }
     */
    
    /*
    NSString * urlString = @"http://flatlevel56.org/lovelog/photoindicator.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
     */

    /*
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //JSONではないので通常用のシリアライズ
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * urlString = @"http://flatlevel56.org/lovelog/photoindicator.php";
    [manager POST:urlString parameters:parameter constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Resposne: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //<#code#>
    }];
     */
    
}




@end
