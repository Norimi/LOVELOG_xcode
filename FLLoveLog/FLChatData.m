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
    //static変数はstack内に置かれずメモリ内に永久に保持される
    static FLChatData * sharedManager = nil;
    if(!sharedManager){
        sharedManager = [[super allocWithZone:nil]init];
    }
    
    return sharedManager;
}

//allocメソッドはallocWithZoneを呼び出す
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

-(void)addDefaultItems:(NSArray*)chatArray{
    [self clearAllItems];
    allChats = [chatArray mutableCopy];
    
}



@end
