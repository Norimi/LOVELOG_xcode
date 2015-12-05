//
//  FLChatItem.m
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2015/12/02.
//  Copyright © 2015年 norimingconception.net. All rights reserved.
//

#import "FLChatItem.h"

@implementation FLChatItem

@synthesize chatid,loggedName, loggedMessage, userid,photoFile,logData,planid,heart,myIndi,pIndi,myphotosum,pphotosum;

-(id)init{
    
    
}

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
          pphotosum:(NSString*)sum{
    
    
    self = [super init];
    if(self){
        [self setChatid:chatid];
        [self setLoggedName:name];
        [self setLoggedMessage:message];
        [self setUserid:userid];
        [self setPhotoFile:photo];
        [self setLogData:data];
        [self setPlanid:planid];
        [self setHeart:indicator];
        [self setMyIndi:myIndi];
        [self setPIndi:pIndi];
        [self setMyphotosum:sumIndi];
        [self setPphotosum:sum];
    }
    
    return self;
    
}

#pragma mark NSCoding delegate method
//FLChatViewControllerからFLChatDataをNSData化する際に必要
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:chatid forKey:@"chatid"];
    [aCoder encodeObject:loggedName forKey:@"loggedName"];
    [aCoder encodeObject:loggedMessage forKey:@"loggedMessage"];
    [aCoder encodeObject:userid forKey:@"userid"];
    [aCoder encodeObject:photoFile forKey:@"photoFile"];
    [aCoder encodeObject:logData forKey:@"logData"];
    [aCoder encodeObject:planid forKey:@"planid"];
    [aCoder encodeObject:heart forKey:@"heart"];
    [aCoder encodeObject:myIndi forKey:@"myIndi"];
    [aCoder encodeObject:pIndi forKey:@"pIndi"];
    [aCoder encodeObject:myphotosum forKey:@"myphotosum"];
    [aCoder encodeObject:pphotosum forKey:@"pphotosum"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super init];
    if (self) {
        
        chatid = [aDecoder decodeObjectForKey:@"chatid"];
        loggedName = [aDecoder decodeObjectForKey:@"loggedName"];
        loggedMessage = [aDecoder decodeObjectForKey:@"loggedMessage"];
        userid = [aDecoder decodeObjectForKey:@"userid"];
        photoFile = [aDecoder decodeObjectForKey:@"photoFile"];
        logData = [aDecoder decodeObjectForKey:@"logData"];
        planid = [aDecoder decodeObjectForKey:@"planid"];
        heart = [aDecoder decodeObjectForKey:@"heart"];
        myIndi = [aDecoder decodeObjectForKey:@"myIndi"];
        pIndi = [aDecoder decodeObjectForKey:@"pIndi"];
        myphotosum = [aDecoder decodeObjectForKey:@"myphotosum"];
        pphotosum = [aDecoder decodeObjectForKey:@"pphotosum"];
        
        
    }
    return self;
}

@end
