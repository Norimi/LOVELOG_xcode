//
//  FLChatItem.h
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2015/12/02.
//  Copyright © 2015年 norimingconception.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLChatItem : NSObject<NSCoding>


-(id)initWithChatid:(NSString*)chatid
         loggedName:(NSString*)name
      loggedMessage:(NSString*)message
             userid:(NSString*)userid
          photoFile:(NSString*)photo
            logData:(NSString*)data
             planid:(NSString*)planid
              heart:(NSString*)indicator
        myIndicator:(NSString*)myIndi
   partnerIndicator:(NSString *)pIndi
         myPhotoSum:(NSString*)sumIndi
          pphotosum:(NSString*)sum;

@property(strong,nonatomic)NSString * chatid;
@property(strong,nonatomic)NSString * loggedName;
@property(strong,nonatomic)NSString * loggedMessage;
@property(strong,nonatomic)NSString * userid;
@property(strong,nonatomic)NSString * photoFile;
@property(strong,nonatomic)NSString * logData;
@property(strong,nonatomic)NSString * planid;
@property(strong,nonatomic)NSString * heart;
@property(strong,nonatomic)NSString * myIndi;
@property(strong,nonatomic)NSString * pIndi;
@property(strong,nonatomic)NSString * myphotosum;
@property(strong,nonatomic)NSString * pphotosum;

@end
