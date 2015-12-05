//
//  FLChatItem.m
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2015/12/02.
//  Copyright © 2015年 norimingconception.net. All rights reserved.
//

#import "FLChatItem.h"

@implementation FLChatItem

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
 [aCoder encodeObject:self forKey:@"keyedChats"];
 
 }
 
 - (id)initWithCoder:(NSCoder *)aDecoder
 {
 NSData * data = [[NSData alloc]init];
 self = [super init];
 if (self) {
 
 data = [aDecoder decodeObjectForKey:@"keyedChats"];
 
 }
 return self;
 }

@end
