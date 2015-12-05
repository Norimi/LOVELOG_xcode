//
//  FLChatData.h
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2015/12/02.
//  Copyright © 2015年 norimingconception.net. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLChatItem;

@interface FLChatData : NSObject{
    
    NSMutableArray * allChats;
}
+(FLChatData*)sharedManager;
-(NSArray*)allChats;
-(void)createItemWithItem:(FLChatItem*)item;
-(void)clearAllItems;
-(void)refreshAllChats:(NSMutableArray*)tmpArray;
-(void)addDefaultItems:(NSArray*)chatArray;



@end
