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
#import "WBErrorNoticeView.h"

@interface PhotoCell()
@property AFHTTPRequestOperationManager * manager;
@property   WBErrorNoticeView* notice;
@property FLConnection * connection;
@end


@implementation PhotoCell
@synthesize loveIndicator, indicator, photoView, frompartnerInd, photoid, userid,titleLabel,tString, partnerLabel, myLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _connection = [[FLConnection alloc]init];
        
        
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
    
    _connection = [[FLConnection alloc]init];
    
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
    
    
    loveInd = [UIButton buttonWithType:UIButtonTypeCustom];
    loveInd2 = [UIButton buttonWithType:UIButtonTypeCustom];
    loveInd3 = [UIButton buttonWithType:UIButtonTypeCustom];
    loveInd4 = [UIButton buttonWithType:UIButtonTypeCustom];
    loveInd5 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
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
        //1を活性（非選択にするため)
        [loveInd setEnabled:YES];
        [loveInd2 setEnabled:YES];
        
    }else if(loveIndicator == 2){
        
        [loveInd setSelected:YES];
        [loveInd2 setSelected:YES];
        
        //1を活性
        [loveInd setEnabled:YES];
        [loveInd2 setEnabled:YES];
        
        
    }else if(loveIndicator == 3){
        
        [loveInd setSelected:YES];
        [loveInd2 setSelected:YES];
        [loveInd3 setSelected:YES];
    }else if(loveIndicator == 4){
        
        
        [loveInd setSelected:YES];
        [loveInd2 setSelected:YES];
        [loveInd3 setSelected:YES];
        [loveInd4 setSelected:YES];
        
    }else if(loveIndicator == 5){
        
        
        [loveInd setSelected:YES];
        [loveInd2 setSelected:YES];
        [loveInd3 setSelected:YES];
        [loveInd4 setSelected:YES];
        
        [loveInd5 setSelected:YES];
        
    }else{
        //love indicatorが0/初期状態のとき
        //1を活性
        [loveInd setEnabled:YES];
    
        
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

-(void)setLoveind1Enabled{
    [loveInd setEnabled:YES];
    
    [loveInd2 setEnabled:NO];
    [loveInd3 setEnabled:NO];
    [loveInd4 setEnabled:NO];
    [loveInd5 setEnabled:NO];
}

-(void)setLoveind12Enabled{
    [loveInd setEnabled:YES];
    [loveInd2 setEnabled:YES];
    
    [loveInd3 setEnabled:NO];
    [loveInd4 setEnabled:NO];
    [loveInd5 setEnabled:NO];
}

-(void)setLoveind23Enabled{
    [loveInd2 setEnabled:YES];
    [loveInd3 setEnabled:YES];
    
    [loveInd setEnabled:NO];
    [loveInd4 setEnabled:NO];
    [loveInd5 setEnabled:NO];
}

-(void)setLoveind34Enabled{
    
    [loveInd3 setEnabled:YES];
    [loveInd4 setEnabled:YES];
    
    [loveInd setEnabled:NO];
    [loveInd2 setEnabled:NO];
    [loveInd5 setEnabled:NO];
}

-(void)setLoveind45Enabled{
    [loveInd4 setEnabled:YES];
    [loveInd5 setEnabled:YES];
    
    [loveInd setEnabled:NO];
    [loveInd2 setEnabled:NO];
    [loveInd3 setEnabled:NO];
    
}

-(void)setLoveind5Enabled{
    
    [loveInd5 setEnabled:YES];
    
    [loveInd setEnabled:NO];
    [loveInd2 setEnabled:NO];
    [loveInd3 setEnabled:NO];
    [loveInd4 setEnabled:NO];
}



-(void)setIndicatorWithParam:(NSString*)parameter{
    
    NSLog(@"%s",__func__);
    
    /*
     NSString * url = [NSString stringWithFormat:@"http://flatlevel56.org/lovelog/photoindicator.php"];
     if([_connection connectionWithUrl:url withData:parameter]){
     
     NSLog(@"connection");
     
     }else{
     
     
     //エラーは出力しない
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     
     }
     */
    
    NSLog(@"params description %@",params.description);
    
    NSString * urlString = @"http://flatlevel56.org/lovelog/photoindicator.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //phpで指定したcontents typeの指定
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
    
    
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
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"1", @"indicator",@"1", @"myphoto",
                                      
                                      nil];
                            
                        }else {
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"1", @"indicator",@"0", @"myphoto",
                                      nil];
                        }
                        
                        [self setIndicatorWithParam:params];
                        //loveIndicator = 1;
                        
                        
                    } else {
                        
                        //ここにも入れる。
                        
                        if(myPhoto == YES){
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"0", @"indicator",@"1", @"myphoto",
                                      
                                      nil];
                            
                            
                        }else {
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"0", @"indicator",@"0", @"myphoto",
                                      
                                      nil];
                            
                        }
                        
                        [self setIndicatorWithParam:params];
                        //loveIndicator =0;
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
                    //トグル
                    loveInd2.selected = !loveInd2.selected;
                    
                    
                    
                    if(loveInd2.selected){
                        //結果選択状態
                        //[self setLoveind23Enabled];
                        
                        if(myPhoto == YES){
                           
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"2", @"indicator",@"1", @"myphoto",
                                      
                                      nil];
                            
                        }else {
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"2", @"indicator",@"0", @"myphoto",
                                      
                                      nil];
                            
                        }
                        
                        [self setIndicatorWithParam:params];
                        
                        //loveIndicator = 2;
                        AudioServicesPlaySystemSound(soundID);
                        
                        
                        
                    } else {
                        
                        //結果非選択状態
                        //[self setLoveind12Enabled];
                        
                        if(myPhoto == YES){
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"1", @"indicator",@"1", @"myphoto",
                                      nil];

                            
                        }else {
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"1", @"indicator",@"0", @"myphoto",
                                      
                                      nil];
                        }
                        
                        [self setIndicatorWithParam:params];
                        //loveIndicator =1;
                    
                
                    }
                
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
                      
                        //loveIndicator = 3;
                        AudioServicesPlaySystemSound(soundID);
                        if(myPhoto == YES){
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"3", @"indicator",@"1", @"myphoto",
                                      nil];
                        }else {
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"3", @"indicator",@"0", @"myphoto",
                                      nil];
                        }
                        
                        [self setIndicatorWithParam:params];
                        
                        
                    } else {
                        //結果非選択
                        
                        if(myPhoto == YES){
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"2", @"indicator",@"1", @"myphoto",
                                      
                                      nil];
                            
                        }else {
                            
                           
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"2", @"indicator",@"0", @"myphoto",
                                      
                                      nil];

                        }
                        
                        [self setIndicatorWithParam:params];
                        //loveIndicator =2;
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
                        
                        //loveIndicator = 4;
                        AudioServicesPlaySystemSound(soundID);
                        
                        if(myPhoto == YES){
                            
                           
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"4", @"indicator",@"1", @"myphoto",
                                      
                                      nil];
                            
                        }else {
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"4", @"indicator",@"0", @"myphoto",
                                      
                                      nil];
                        }
                        
                        [self setIndicatorWithParam:params];
                        
                    } else {
                        
                        
                        if(myPhoto == YES){
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"3", @"indicator",@"1", @"myphoto",
                                      
                                      nil];
                        }else {
                            
                            params = [NSDictionary dictionaryWithObjectsAndKeys:
                                      photoid, @"photoid",
                                      @"3", @"indicator",@"0", @"myphoto",
                                      
                                      nil];
                            
                        }
                        
                        [self setIndicatorWithParam:params];
                        //loveIndicator =3;
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
                                
                                
                                params = [NSDictionary dictionaryWithObjectsAndKeys:
                                          photoid, @"photoid",
                                          @"5", @"indicator",@"1", @"myphoto",
                                          nil];
                                
                            }else {
                                
                                params = [NSDictionary dictionaryWithObjectsAndKeys:
                                          photoid, @"photoid",
                                          @"5", @"indicator",@"0", @"myphoto",
                                          nil];
                            }
                            
                            [self setIndicatorWithParam:params];
                            
                        } else {
                            //結果非選択
                            
                            if(myPhoto == YES){
                                
                                
                                params = [NSDictionary dictionaryWithObjectsAndKeys:
                                          photoid, @"photoid",
                                          @"4", @"indicator",@"1", @"myphoto",
                                          nil];
                            }else {
                                
                                params = [NSDictionary dictionaryWithObjectsAndKeys:
                                          photoid, @"photoid",
                                          @"4", @"indicator",@"0", @"myphoto",
                                          nil];
                            }
                            [self setIndicatorWithParam:params];
                            
                            
                            
                            //loveIndicator =4;
                        }
                    }
                }
            }
        }
    }
    
}




@end
