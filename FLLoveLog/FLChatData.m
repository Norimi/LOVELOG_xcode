//
//  FLChatData.m
//  LOVE LOG
//
//  Created by netNORIMINGCONCEPTION on 2015/12/02.
//  Copyright © 2015年 norimingconception.net. All rights reserved.
//

#import "FLChatData.h"
#import "FLChatItem.h"

@implementation FLChatData
+(FLChatData*)sharedManager{
    //シングルトン実装
    static FLChatData * sharedManager = nil;
    if(!sharedManager){
        sharedManager = [[super allocWithZone:nil]init];
    }
    
    return sharedManager;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}

-(id)init
{
    self = [super init];
    if(self){
        allChats = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSArray*)allChats{
    
    return [allChats copy];
}

-(void)createItemWithItem:(FLChatItem*)item{
    
    [allChats addObject:item];
    
}

-(void)clearAllItems{
    
    //シングルトン内で配列をクリアする
    [allChats removeAllObjects];
}

-(void)refreshAllChats:(NSMutableArray*)tmpArray{
    
    [allChats removeAllObjects];
    allChats = tmpArray;
}




@end
